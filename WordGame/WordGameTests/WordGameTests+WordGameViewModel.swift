//
//  WordGameTests+WordGameViewModel.swift
//  WordGameTests
//
//  Created by Reza Bina on 11/12/22.
//

import XCTest
import Combine
@testable import WordGame

final class WordGameTests_WordGameViewModel: WordGameTests {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func testCorrectAnswer() {
        
        let viewModel = WordGameViewModel(wordService: mockWordListManager)
        
        let expectation = XCTestExpectation(description: "testCorrectAnswer")
        
        viewModel.$rightAnswers
            .sink { rightAnws in
            if rightAnws > 0 {
                expectation.fulfill()
            }
        }
        .store(in: &subscriptions)
        
        
        viewModel.$currentRoundData
            .sink { rData in
            DispatchQueue.main.async {
                viewModel.submitAnswer(isCorrect: rData?.isCorrect ?? false)
            }
        }
        .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(viewModel.rightAnswers == 1)
        XCTAssertTrue(viewModel.wrongAnswers == 0)
    }
    
    func testWrongAnswer() {
        
        let viewModel = WordGameViewModel(wordService: mockWordListManager)
        
        let expectation = XCTestExpectation(description: "testCorrectAnswer")
        
        viewModel.$wrongAnswers
            .sink { wrongAnws in
            if wrongAnws > 0 {
                expectation.fulfill()
            }
        }
        .store(in: &subscriptions)
        
        
        viewModel.$currentRoundData
            .sink { rData in
            DispatchQueue.main.async {
                viewModel.submitAnswer(isCorrect: !(rData?.isCorrect ?? false))
            }
        }
        .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(viewModel.rightAnswers == 0)
        XCTAssertTrue(viewModel.wrongAnswers == 1)
    }

}
