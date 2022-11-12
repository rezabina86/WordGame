//
//  WordGameTests.swift
//  WordGameTests
//
//  Created by Reza Bina on 11/11/22.
//

import XCTest
@testable import WordGame

class WordGameTests: XCTestCase {

    struct MockWordListManager: WordService {
        
        func load() throws -> [WordModel] {
            let word1 = WordModel(english: "equator", spanish: "ecuador")
            let word2 = WordModel(english: "humid", spanish: "húmedo")
            let word3 = WordModel(english: "emergency", spanish: "urgencia")
            let word4 = WordModel(english: "island", spanish: "isla")
            let word5 = WordModel(english: "medical", spanish: "médico")
            
            return [word1, word2, word3, word4, word5]
        }
        
    }

}
