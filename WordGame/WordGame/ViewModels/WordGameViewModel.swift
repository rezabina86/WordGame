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
    
    @Published private(set) var currentRoundData: GameRoundData?
    
    @Published private(set) var isGameFinished: Bool = false
    @Published private(set) var remainingTimeInRound: Int = Constants.kTimeOfEachRound
    
    // Error
    @Published private(set) var showError: Bool = false
    @Published private(set) var errorMessage: String = ""
    
    // MARK: - Privates
    private var userHasAnsweredTheCurrentRound = false
    private var subscriptions: Set<AnyCancellable> = []
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private var gameRoundDataManager: RoundDataManager?
    
    private func privateInit() {
        $rightAnswers
            .combineLatest($wrongAnswers)
            .receive(on: RunLoop.main)
            .map { rAns, wAns in
                let totalAns = rAns + wAns
                return (totalAns >= Constants.kNumberOfWordsInRound) || (wAns >= Constants.kNumberOfWrongAttemps)
            }.assign(to: &$isGameFinished)
        
        $remainingTimeInRound
            .receive(on: RunLoop.main)
            .sink { timeLeft in
                guard !self.isGameFinished else { return }
                
                if timeLeft == 0 && !self.userHasAnsweredTheCurrentRound {
                    self.wrongAnswers += 1
                }
            }
            .store(in: &subscriptions)
        
        timer
            .sink { _ in
                guard !self.isGameFinished else { return }
                
                if self.remainingTimeInRound == 0 {
                    self.startNewRound()
                    return
                }
                
                self.remainingTimeInRound -= 1
            }
            .store(in: &subscriptions)
    }
    
    private func startNewRound() {
        guard !isGameFinished else { return }
        self.currentRoundData = self.gameRoundDataManager?.generateWord()
        self.remainingTimeInRound = Constants.kTimeOfEachRound
        self.userHasAnsweredTheCurrentRound = false
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
        guard !isGameFinished else { return }
        self.userHasAnsweredTheCurrentRound = true
        let isAnswerCorrect = currentRoundData?.isCorrect ?? false
        
        if isAnswerCorrect == isCorrect {
            rightAnswers += 1
        } else  {
            wrongAnswers += 1
        }
        
        startNewRound()
    }
    
    public func restartGame() {
        self.rightAnswers = 0
        self.wrongAnswers = 0
        self.isGameFinished = false
        
        self.startNewRound()
    }
    
}
