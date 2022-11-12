//
//  WordGameTests+WordListManager.swift
//  WordGameTests
//
//  Created by Reza Bina on 11/12/22.
//

import XCTest
@testable import WordGame

final class WordGameTests_WordListManager: WordGameTests {

    func testWordListManager() {
        do {
            let words = try wordListManager.load()
            guard words.count > 1 else {
                XCTFail("Not enough word to play the game.")
                return
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }

}
