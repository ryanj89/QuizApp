//
//  QuizModel.swift
//  TrueFalseStarter
//
//  Created by Ryan on 8/4/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

// Create Quiz class to instantiate each trivia question
import Foundation

class Quiz {
    let question: String
    let firstChoice: String
    let secondChoice: String
    let thirdChoice: String
    let fourthChoice: String
    let answer: String
    
    init(question: String, firstChoice: String, secondChoice: String, thirdChoice: String, fourthChoice: String, answer: String) {
        self.question = question
        self.firstChoice = firstChoice
        self.secondChoice = secondChoice
        self.thirdChoice = thirdChoice
        self.fourthChoice = fourthChoice
        self.answer = answer
    }
}

// Instantiate trivia questions with the Quiz class

let quizQuestion1 = Quiz(question: "This was the only US President to serve more than two consecutive terms.",
                         firstChoice: "George Washington",
                         secondChoice: "Franklin D. Roosevelt",
                         thirdChoice: "Woodrow Wilson",
                         fourthChoice: "Andrew Jackson",
                         answer: "Franklin D. Roosevelt")

let quizQuestion2 = Quiz(question: "Which of the following countries has the most residents?",
                         firstChoice: "Nigeria",
                         secondChoice: "Russia",
                         thirdChoice: "Iran",
                         fourthChoice: "Vietnam",
                         answer: "Nigeria")

let quizQuestion3 = Quiz(question: "In what year was the United Nations founded?",
                         firstChoice: "1918",
                         secondChoice: "1919",
                         thirdChoice: "1945",
                         fourthChoice: "1954",
                         answer: "1945")

let quizQuestion4 = Quiz(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
                         firstChoice: "Paris",
                         secondChoice: "Washington D.C.",
                         thirdChoice: "New York City",
                         fourthChoice: "Boston",
                         answer: "New York City")

let quizQuestion5 = Quiz(question: "Which nation produces the most oil?",
                         firstChoice: "Iran",
                         secondChoice: "Iraq",
                         thirdChoice: "Brazil",
                         fourthChoice: "Canada",
                         answer: "Canada")

let quizQuestion6 = Quiz(question: "Which country has most recently won consecutive World Cups in Soccer?",
                         firstChoice: "Italy",
                         secondChoice: "Brazil",
                         thirdChoice: "Argentina",
                         fourthChoice: "Spain",
                         answer: "Brazil")

let quizQuestion7 = Quiz(question: "Which of the following rivers is longest?",
                         firstChoice: "Yangtze",
                         secondChoice: "Mississippi",
                         thirdChoice: "Congo",
                         fourthChoice: "Mekong",
                         answer: "Mississippi")

let quizQuestion8 = Quiz(question: "Which city is the oldest?",
                         firstChoice: "Mexico City",
                         secondChoice: "Cape Town",
                         thirdChoice: "San Juan",
                         fourthChoice: "Sydney",
                         answer: "Mexico City")

let quizQuestion9 = Quiz(question: "Which country was the first to allow women to vote in national elections?",
                         firstChoice: "Poland",
                         secondChoice: "United States",
                         thirdChoice: "Sweden",
                         fourthChoice: "Senegal",
                         answer: "Poland")

let quizQuestion10 = Quiz(question: "Which of these countries won the most medals in the 2012 Summer Games?",
                         firstChoice: "France",
                         secondChoice: "Germany",
                         thirdChoice: "Japan",
                         fourthChoice: "Great Britain",
                         answer: "Great Britain")

// Create collection of all quiz questions

let quizQuestions = [quizQuestion1,
                     quizQuestion2,
                     quizQuestion3,
                     quizQuestion4,
                     quizQuestion5,
                     quizQuestion6,
                     quizQuestion7,
                     quizQuestion8,
                     quizQuestion9,
                     quizQuestion10]