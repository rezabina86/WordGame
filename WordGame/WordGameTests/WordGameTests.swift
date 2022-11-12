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
    

    struct MockWordListManager: WordService {
        func load() throws -> [WordModel] {
            return MockData.words
        }
    }

}
