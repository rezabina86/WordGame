//
//  WordGameTests+RandomWordManager.swift
//  WordGameTests
//
//  Created by Reza Bina on 11/12/22.
//

import XCTest
@testable import WordGame

final class WordGameTests_RandomWordManager: WordGameTests {

    let mockWordListManager = MockWordListManager()
    
    /*
     This test tries to init RandomWordManager with mock datas
     and calls generateWord() method to generate a new word. Then finds that
     word in the word list and makes sure it generates correct questions.
     */
    func testRandomWordManager() {
        
        do {
            var randomWordManager = try RandomWordManager(service: mockWordListManager)
            let allWords = try mockWordListManager.load()
            
            for _ in 0..<(allWords.count * 10) {
                let newWord = randomWordManager.generateWord()
                
                guard let newWord = newWord else {
                    XCTFail("Could not generate a new word.")
                    return
                }
                
                let wordInWordList = allWords.first { $0.english == newWord.english }
                
                guard let wordInWordList = wordInWordList else {
                    XCTFail("Could not find the generated word in the words list.")
                    return
                }
                
                if newWord.isCorrect {
                    XCTAssertEqual(newWord.spanish, wordInWordList.spanish)
                } else {
                    XCTAssertNotEqual(newWord.spanish, wordInWordList.spanish)
                }
                
            }
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
