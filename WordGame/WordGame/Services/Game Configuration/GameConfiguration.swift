//
//  GameConfiguration.swift
//  WordGame
//
//  Created by Reza Bina on 11/13/22.
//

import Foundation

struct GameConfiguration: GameConfigurationService {
    var numberOfWordsInRound: Int = Constants.kNumberOfWordsInRound
    var numberOfWrongAttemps: Int = Constants.kNumberOfWrongAttemps
    var timeOfEachRound: Int = Constants.kTimeOfEachRound
    var probabilityOfCorrectWord: Double = Constants.kProbabilityOfCorrectWord
}
