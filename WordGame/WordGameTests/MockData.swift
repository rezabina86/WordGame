//
//  MockData.swift
//  WordGameTests
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

@testable import WordGame

enum MockData {
    static let word1 = WordModel(english: "eng1", spanish: "spa1")
    static let word2 = WordModel(english: "eng2", spanish: "spa2")
    static let word3 = WordModel(english: "eng3", spanish: "spa3")
    static let word4 = WordModel(english: "eng4", spanish: "spa4")
    static let word5 = WordModel(english: "eng5", spanish: "spa5")
    
    static let words = [word1, word2, word3, word4, word5]
}
