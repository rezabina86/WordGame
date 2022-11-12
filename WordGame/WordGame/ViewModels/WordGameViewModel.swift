//
//  WordGameViewModel.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation
import Combine

class WordGameViewModel: ObservableObject {
    
    // Mark: - Constants
    private static let kNumberOfWordsInRound = 15
    private static let kNumberOfWrongAttemps = 3
    private static let kTimeOfEachRound = 5 // In seconds
    
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
    private var userHasAnsweredCurrentRound = false
    private var subscriptions: Set<AnyCancellable> = []
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private var gameRoundDataManager: RoundDataManager?
    
    private func startNewRound() {
        if !self.userHasAnsweredCurrentRound {
            self.noAnswers += 1
        }
        guard !isGameFinished else { return }
        self.remainingTimeInRound = WordGameViewModel.kTimeOfEachRound
        self.currentRoundData = self.gameRoundDataManager?.generateWord()
        self.userHasAnsweredCurrentRound = false
    }
    
    // MARK: - Initializer
    init() {
        do {
            self.gameRoundDataManager = try RoundDataManager(service: WordListManager())
        } catch {
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
        
        // Game is over after three incorrect attempts
        $wrongAnswers
            .receive(on: RunLoop.main)
            .map { wAnswers in
                return wAnswers > 2
            }
            .assign(to: &$isGameFinished)
        
        // Game is finished after 15 word pairs
        $numberOfRounds
            .receive(on: RunLoop.main)
            .map { numOfRounds in
                return numOfRounds > WordGameViewModel.kNumberOfWordsInRound
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
    
    deinit {
        timer.upstream.connect().cancel()
    }
    
    // MARK: - Publics
    public func submitAnswer(isCorrect: Bool) {
        self.userHasAnsweredCurrentRound = true
        let isCurrentRoundCorrect = currentRoundData?.isCorrect ?? false
        
        if (isCurrentRoundCorrect && isCorrect) || (!isCurrentRoundCorrect && !isCorrect) {
            rightAnswers += 1
        } else  {
            wrongAnswers += 1
        }
        
        startNewRound()
    }
    
    public func restartGame() {
        self.gameRoundDataManager?.reset()
        self.rightAnswers = 0
        self.wrongAnswers = 0
        self.noAnswers = 0
        self.numberOfRounds = 0
        
        self.startNewRound()
    }
    
}
