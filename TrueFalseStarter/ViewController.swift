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
    
    let questionsPerRound = quizQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var previousQuestions:[Int] = []
    
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 1
    var wrongSound: SystemSoundID = 2
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var fourthChoiceButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

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
    
    func displayQuestion() {
        // Select a question using random index value
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(quizQuestions.count)
        
        // If question was used previously, will generate another random index until we get a new question.
        while previousQuestions.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(quizQuestions.count)
        }
        
        previousQuestions.append(indexOfSelectedQuestion)
        let quizQuestion = quizQuestions[indexOfSelectedQuestion]
        questionField.text = quizQuestion.question
        
        // Assign possible answers to buttons
        firstChoiceButton.setTitle(quizQuestion.firstChoice, forState: .Normal)
        secondChoiceButton.setTitle(quizQuestion.secondChoice, forState: .Normal)
        thirdChoiceButton.setTitle(quizQuestion.thirdChoice, forState: .Normal)
        fourthChoiceButton.setTitle(quizQuestion.fourthChoice, forState: .Normal)
        
        playAgainButton.hidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        firstChoiceButton.hidden = true
        secondChoiceButton.hidden = true
        thirdChoiceButton.hidden = true
        fourthChoiceButton.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestion = quizQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestion.answer
        
        if (sender.titleLabel?.text == correctAnswer){
            playCorrectAnswerSound()
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            playWrongAnswerSound()
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        firstChoiceButton.hidden = false
        secondChoiceButton.hidden = false
        thirdChoiceButton.hidden = false
        fourthChoiceButton.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        indexOfSelectedQuestion = 0
        previousQuestions = []
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
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
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("CorrectSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &correctSound)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    // Wrong Answer Sound
    func loadWrongAnswerSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("WrongSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &wrongSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
}

