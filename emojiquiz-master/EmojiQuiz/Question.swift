//
//  Question.swift
//  EmojiQuiz
//
//  Created by Matthew Fortier on 2/8/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import Foundation

class Question {
    var mQuestion: String
    var mAnswer: String
    var mCategory: String
    
    init(_ question: String, _ answer: String, _ category: String) {
        self.mQuestion = question
        self.mAnswer = answer
        self.mCategory = category
    }
    
    func getQuestion() -> String {
        return self.mQuestion
    }
    func setQuestion(_ question: String) {
        self.mQuestion = question
    }
    
    func getAnswer() -> String {
        return self.mAnswer
    }
    func setAnswer(_ answer: String) {
        self.mAnswer = answer
    }
    
    func getCategory() -> String {
        return self.mCategory
    }
    func setCategory(_ category: String) {
        self.mCategory = category
    }
}
