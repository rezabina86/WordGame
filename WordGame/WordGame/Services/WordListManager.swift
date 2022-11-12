//
//  WordListManager.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

struct WordListManager: WordService {
    
    func load() throws -> [WordModel] {
        guard let url = Bundle.main.url(forResource: "words", withExtension: "json") else {
            throw GameError.noResource
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let words = try decoder.decode([WordModel].self, from: data)
            
            guard words.count > 1 else {
                throw GameError.notEnoughWords
            }
            
            return words
        } catch {
            throw GameError.errorParsingList
        }
        
    }
    
}
