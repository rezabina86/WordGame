//
//  RandomWordModel.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

struct RandomWordModel {
    var english: String
    var spanish: String
    var isCorrect: Bool
    
    init(word: WordModel, isCorrect: Bool) {
        self.english = word.english
        self.spanish = word.spanish
        self.isCorrect = isCorrect
    }
}
