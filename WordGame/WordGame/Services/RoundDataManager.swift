//
//  RoundDataManager.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

struct RoundDataManager {
    
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
    
    private mutating func generateCorrectQuestion() -> WordModel? {
        
        if availableWordIndexs.isEmpty {
            reset()
        }
        
        // The words list can not be empty. If it's empty, we throw an error when we try to call load() func.
        guard let randomIndex = availableWordIndexs.randomElement() else { return  nil }
        
        // Remove the randomIndex from availableWordIndexs.
        // It avoids picking the same word more than once.
        if let removingIndex = availableWordIndexs.firstIndex(of: randomIndex) {
            availableWordIndexs.remove(at: removingIndex)
        }
        
        return words[randomIndex]
    }
    
    private func generateWrongQuestion() -> WordModel? {
        
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
    
    public mutating func generateWord() -> GameRoundData? {
        if shouldGenerateCorrectAnswer {
            guard let correctWord = generateCorrectQuestion() else { return nil }
            return GameRoundData(word: correctWord, isCorrect: true)
        } else {
            guard let wrongWord = generateWrongQuestion() else { return nil }
            return GameRoundData(word: wrongWord, isCorrect: false)
        }
    }
    
}
