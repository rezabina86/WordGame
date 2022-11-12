//
//  WordGameViewModel.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation
import Combine

class WordGameViewModel: ObservableObject {
    
    // MARK: - Publishers
    
    // Game results
    @Published private(set) var rightAnswers: Int = 0
    @Published private(set) var wrongAnswers: Int = 0
    @Published private(set) var noAnswers: Int = 0
    
    @Published private(set) var currentRoundData: GameRoundData?
    @Published private(set) var numberOfRounds: Int = 0
    
    @Published private(set) var isGameFinished: Bool = false
    @Published private(set) var remainingTimeInRound: Int = 0
    
    // Error
    @Published private(set) var showError: Bool = false
    @Published private(set) var errorMessage: String = ""
    
    // MARK: - Privates
    private var userHasAnsweredTheCurrentRound = false
    private var subscriptions: Set<AnyCancellable> = []
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private var gameRoundDataManager: RoundDataManager?
    
    private func startNewRound() {
        guard !isGameFinished else { return }
        if !self.userHasAnsweredTheCurrentRound {
            self.noAnswers += 1
        }
        self.remainingTimeInRound = Constants.kTimeOfEachRound
        self.currentRoundData = self.gameRoundDataManager?.generateWord()
        self.userHasAnsweredTheCurrentRound = false
    }
    
    private func privateInit() {
        // Game is over after three incorrect attempts
        $wrongAnswers
            .receive(on: RunLoop.main)
            .map { wAnswers in
                return wAnswers >= Constants.kNumberOfWrongAttemps
            }
            .assign(to: &$isGameFinished)
        
        // Game is finished after 15 word pairs
        $numberOfRounds
            .receive(on: RunLoop.main)
            .map { numOfRounds in
                return numOfRounds >= Constants.kNumberOfWordsInRound
            }
            .assign(to: &$isGameFinished)
        
        timer
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.remainingTimeInRound == 0 {
                    self.startNewRound()
                }
                self.remainingTimeInRound -= 1
            }
            .store(in: &subscriptions)
        
        
        self.startNewRound()
    }
    
    // MARK: - Initializers
    
    init() {
        do {
            self.gameRoundDataManager = try RoundDataManager(service: WordListManager(), probabilityOfCorrectWord: Constants.kProbabilityOfCorrectWord)
        } catch {
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
        self.privateInit()
    }
    
    init(wordService: WordService) {
        
        do {
            self.gameRoundDataManager = try RoundDataManager(service: wordService, probabilityOfCorrectWord: Constants.kProbabilityOfCorrectWord)
        } catch {
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
    
        self.privateInit()
    }
    
    deinit {
        timer.upstream.connect().cancel()
    }
    
    // MARK: - Publics
    public func submitAnswer(isCorrect: Bool) {
        self.userHasAnsweredTheCurrentRound = true
        let isCurrentRoundCorrect = currentRoundData?.isCorrect ?? false
        
        if isCurrentRoundCorrect == isCorrect {
            rightAnswers += 1
        } else  {
            wrongAnswers += 1
        }
        
        startNewRound()
    }
    
    public func restartGame() {
        self.rightAnswers = 0
        self.wrongAnswers = 0
        self.noAnswers = 0
        self.numberOfRounds = 0
        
        self.startNewRound()
    }
    
}
