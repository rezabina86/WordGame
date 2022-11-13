//
//  WordGameTests.swift
//  WordGameTests
//
//  Created by Reza Bina on 11/11/22.
//

import XCTest
@testable import WordGame

class WordGameTests: XCTestCase {
    
    let wordListManager = WordListManager()
    let mockWordListManager = MockWordListManager()
    let mockGameConfiguration = MockGameConfiguration()
    
    class MockWordListManager: WordService {
        func load() throws -> [WordModel] {
            return MockData.words
        }
    }
    
    class MockGameConfiguration: GameConfigurationService {
        var numberOfWordsInRound: Int = 15
        var numberOfWrongAttemps: Int = 3
        var timeOfEachRound: Int = 5
        var probabilityOfCorrectWord: Double = 0.25
    }

}
