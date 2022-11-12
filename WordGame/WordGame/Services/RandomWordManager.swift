//
//  RandomWordManager.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

struct RandomWordManager {
    
    // MARK: - Privates
    private let service: WordService
    private let words: [WordModel]
    private var availableWordIndexs: [Int] = []
    
    private var shouldGenerateCorrectAnswer: Bool {
        // The probability for a correct word pair to appear should be 25%
        Int.random(in: 0..<4) == 0
    }
    
    private mutating func reset() {
        availableWordIndexs = Array(words.startIndex..<words.endIndex)
    }
    
    private mutating func generateCorrectQuestion() -> WordModel {
        
        if availableWordIndexs.isEmpty {
            reset()
        }
        
        // The words list can not be empty. If it's empty, we throw an error when we try to call load() func.
        let randomIndex = availableWordIndexs.randomElement() ?? 0
        
        // Remove the randomIndex from availableWordIndexs.
        // It avoids picking the same word more than once.
        if let removingIndex = availableWordIndexs.firstIndex(of: randomIndex) {
            availableWordIndexs.remove(at: removingIndex)
        }
        
        return words[randomIndex]
    }
    
    private func generateWrongQuestion() -> WordModel {
        
#if DEBUG
        assert(words.count > 1, "We should have at least two words to generate a wrong question.")
#endif
        
        if let firstWord = words.randomElement(),
           let secondWord = words.randomElement(),
           firstWord != secondWord
        {
            return WordModel(english: firstWord.english, spanish: secondWord.spanish)
        }
        
        return generateWrongQuestion()
    }
    
    // MARK: - Initializer
    
    init(service: WordService) throws {
        self.service = service
        
        do {
            words = try service.load()
        } catch {
            throw error
        }
        
        reset()
    }
    
    // MARK: - Publics
    
    public mutating func generateWord() -> RandomWordModel {
        if shouldGenerateCorrectAnswer {
            let correctWord = generateCorrectQuestion()
            return RandomWordModel(word: correctWord, isCorrect: true)
        } else {
            let wrongWord = generateWrongQuestion()
            return RandomWordModel(word: wrongWord, isCorrect: false)
        }
    }
    
}