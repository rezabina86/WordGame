//
//  GameConfigurationService.swift
//  WordGame
//
//  Created by Reza Bina on 11/13/22.
//

import Foundation

protocol GameConfigurationService {
    var numberOfWordsInRound: Int { get }
    var numberOfWrongAttemps: Int { get }
    var timeOfEachRound: Int { get } // In seconds
    var probabilityOfCorrectWord: Double { get } // Between 0 and 1
}
