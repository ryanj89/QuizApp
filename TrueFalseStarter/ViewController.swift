//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // Setup questions for new game
    let questionsPerRound = quizQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var previousQuestions:[Int] = []
    
    
    
    // Setup game sounds
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 1
    var wrongSound: SystemSoundID = 2
    
    
    
    // Setup 'Lightning Mode' timer
    var seconds = 15
    var timer = NSTimer()
    var timerActive = false
    
    
    
    // IBOutlets
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var fourthChoiceButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        loadCorrectAnswerSound()
        loadWrongAnswerSound()
        
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Generates a random question with answers and displays it on the screen
    func displayQuestion() {
        
        // Select a question using random index value
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(quizQuestions.count)
        
        // If question was used previously, will generate another random index until we get a new question.
        while previousQuestions.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(quizQuestions.count)
        }
        
        // Append question to previousQuestion array so it will not be repeated.
        previousQuestions.append(indexOfSelectedQuestion)
        
        // Display the current question
        let quizQuestion = quizQuestions[indexOfSelectedQuestion]
        questionField.text = quizQuestion.question
        
        // Assign possible answers to buttons
        firstChoiceButton.setTitle(quizQuestion.firstChoice, forState: .Normal)
        secondChoiceButton.setTitle(quizQuestion.secondChoice, forState: .Normal)
        thirdChoiceButton.setTitle(quizQuestion.thirdChoice, forState: .Normal)
        fourthChoiceButton.setTitle(quizQuestion.fourthChoice, forState: .Normal)
        
        enableButtons()
        
        // Hide Next Question and Play again Buttons
        nextQuestionButton.hidden = true
        playAgainButton.hidden = true
        
        // Start Timer
        timerLabel.textColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        resetTimer()
        startTimer()
    }
    
    
    
    // Displays final score of game
    func displayScore() {
        
        // Hide the answer, timer, and next question buttons
        firstChoiceButton.hidden = true
        secondChoiceButton.hidden = true
        thirdChoiceButton.hidden = true
        fourthChoiceButton.hidden = true
        nextQuestionButton.hidden = true
        timerLabel.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        // Displays # of correct answers in the quiz
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    
    
    // Checks the users answer and displays correct or incorrect
    @IBAction func checkAnswer(sender: UIButton) {
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        disableButtons()
        
        // Assign correct answer to variable
        let selectedQuestion = quizQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestion.answer
        
        // If/Else to check whether user chose the correct answer
        if (sender.titleLabel?.text == correctAnswer) {
            playCorrectAnswerSound()
            correctQuestions += 1
//            sender.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
            timerLabel.text = "Correct!"
            timerLabel.textColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
            timer.invalidate()
        } else {
            playWrongAnswerSound()
            timerLabel.text = "Sorry, wrong answer!"
            timerLabel.textColor = UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0)
            timer.invalidate()
        }
        
        // Display next question button
        nextQuestionButton.hidden = false
    }
    
    
    
    // Loads the next round or the score if the game is over
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    
    
    // Pressing Next Question Button loads the next round
    @IBAction func loadNextRoundWithButton(sender: AnyObject) {
        nextRound()
    }
    
    
    
    // Pressing the Play Again button will start a new game
    @IBAction func playAgain() {
        // Show the answer buttons and timer label
        firstChoiceButton.hidden = false
        secondChoiceButton.hidden = false
        thirdChoiceButton.hidden = false
        fourthChoiceButton.hidden = false
        timerLabel.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        indexOfSelectedQuestion = 0
        previousQuestions = []
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    
    
    // Start Timer
    func startTimer() {
        // If timer is not active, start the timer and set it to active
        if timerActive == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerActive = true
        }
    }
    
    
    
    // Update Timer
    func updateTimer() {
        
        // Assign correct answer to variable
        let selectedQuestion = quizQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestion.answer
        
        // Counts down the seconds and displays it on screen
        seconds -= 1
        timerLabel.text = "Time Remaining: \(seconds)"
        
        // When the time reaches 0 seconds, notifies user and displays the correct answer
        if seconds == 0 {
            questionsAsked += 1
            timer.invalidate()
            timerLabel.text = "Time's up! \nThe correct answer is: \(correctAnswer)"
            timerLabel.textColor = UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0)
            disableButtons()
            
            nextQuestionButton.hidden = false
        }
    }
    
    
    
    // Reset Timer
    func resetTimer() {
        // Reset to default time and make the timer inactive
        seconds = 15
        timerLabel.text = "Time Remaining: \(seconds)"
        timerActive = false
    }
    
    
    
    // Loads next round after a set time
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    
    
    // Enable Buttons
    func enableButtons() {
        firstChoiceButton.userInteractionEnabled = true
        secondChoiceButton.userInteractionEnabled = true
        thirdChoiceButton.userInteractionEnabled = true
        fourthChoiceButton.userInteractionEnabled = true
        
        firstChoiceButton.alpha = 1
        secondChoiceButton.alpha = 1
        thirdChoiceButton.alpha = 1
        fourthChoiceButton.alpha = 1
    }
    
    
    
    // Disable Buttons
    func disableButtons() {
        firstChoiceButton.userInteractionEnabled = false
        secondChoiceButton.userInteractionEnabled = false
        thirdChoiceButton.userInteractionEnabled = false
        fourthChoiceButton.userInteractionEnabled = false
        
        firstChoiceButton.alpha = 0.5
        secondChoiceButton.alpha = 0.5
        thirdChoiceButton.alpha = 0.5
        fourthChoiceButton.alpha = 0.5
    }
    
    
    
    // Game Start Sound
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    
    // Correct Answer Sound
    func loadCorrectAnswerSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("CorrectSound", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &correctSound)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    
    
    // Wrong Answer Sound
    func loadWrongAnswerSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("WrongSound", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &wrongSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
}