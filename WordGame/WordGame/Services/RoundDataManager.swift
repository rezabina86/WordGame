//
//  RoundDataManager.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

struct RoundDataManager {
    
    // MARK: - Initializer
    
    init(service: WordService, probabilityOfCorrectWord: Double) throws {
        self.service = service
        self.probabilityOfCorrectWord = probabilityOfCorrectWord
        
        do {
            words = try service.load()
        } catch {
            throw error
        }
    }
    
    // MARK: - Privates
    private let service: WordService
    private let words: [WordModel]
    private let probabilityOfCorrectWord: Double
    
    private var shouldGenerateCorrectAnswer: Bool {
        Double.random(in: 0...1) < probabilityOfCorrectWord
    }
    
    private func generateCorrectQuestion() -> WordModel? {
        return words.randomElement()
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
    
    // MARK: - Publics
    
    public func generateWord() -> GameRoundData? {
        if shouldGenerateCorrectAnswer {
            guard let correctWord = generateCorrectQuestion() else { return nil }
            return GameRoundData(word: correctWord, isCorrect: true)
        } else {
            guard let wrongWord = generateWrongQuestion() else { return nil }
            return GameRoundData(word: wrongWord, isCorrect: false)
        }
    }
    
}
