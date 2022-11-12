//
//  GameError.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

enum GameError: LocalizedError {
    
    case notEnoughWords
    case noResource
    case errorParsingList
    
    var errorDescription: String? {
        switch self {
        case .errorParsingList:
            return NSLocalizedString("errorParsingList", comment: "Error parsing the words list.")
        case .noResource:
            return NSLocalizedString("noResource", comment: "Could not find the resource.")
        case .notEnoughWords:
            return NSLocalizedString("notEnoughWords", comment: "Not enough words. The list should have at least two words.")
        }
    }
    
}
