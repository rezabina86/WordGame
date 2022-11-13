//
//  GameView.swift
//  WordGame
//
//  Created by Reza Bina on 11/11/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = WordGameViewModel()
    
    var body: some View {
        if viewModel.isGameFinished {
            resultView()
        } else {
            gameView()
                .onAppear {
                    viewModel.restartGame()
                }
        }
    }
    
    @ViewBuilder
    func gameView() -> some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(String(localized: "gameView.correctAttempts")): \(viewModel.rightAnswers)")
                        Text("\(String(localized: "gameView.wrongAttempts")): \(viewModel.wrongAnswers)")
                    }
                }
                
                Spacer()
                Text(viewModel.currentRoundData?.spanish ?? "")
                    .font(.largeTitle)
                    .offset(y: viewModel.yOffset * proxy.size.height)
                    .animation(.default, value: self.viewModel.currentRoundData?.spanish)
                
                Text(viewModel.currentRoundData?.english ?? "")
                    .font(.title)
                    .animation(.default, value: self.viewModel.currentRoundData?.english)
                
                Spacer()
                
                HStack {
                    Button(String(localized: "gameView.correct")) {
                        self.viewModel.submitAnswer(isCorrect: true)
                    }.buttonStyle(.borderedProminent)
                     .tint(.green)
                    
                    
                    Button(String(localized: "gameView.wrong")) {
                        self.viewModel.submitAnswer(isCorrect: false)
                    }.buttonStyle(.borderedProminent)
                     .tint(.red)
                }
            }.padding()
        }
    }
    
    @ViewBuilder
    func resultView() -> some View {
        VStack(alignment: .center) {
            Spacer()
            Text(String(localized: "gameView.gameOver"))
                .font(.headline)
            
            Spacer()
                .frame(height: 24)
            
            Text("\(String(localized: "gameView.correctAttempts")): \(viewModel.rightAnswers)")
            Text("\(String(localized: "gameView.wrongAttempts")): \(viewModel.wrongAnswers)")
            
            Spacer()
                .frame(height: 24)
            
            HStack {
                Button(String(localized: "gameView.playAgain")) {
                    self.viewModel.restartGame()
                }.buttonStyle(.borderedProminent)
                 .tint(.green)
                
                
                Button(String(localized: "gameView.quitGame")) {
                    exit(0)
                }.buttonStyle(.borderedProminent)
                 .tint(.red)
            }
            Spacer()
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
