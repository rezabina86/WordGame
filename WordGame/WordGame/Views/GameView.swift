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
                        Text("Correct attempts: \(viewModel.rightAnswers)")
                        Text("Wrong attempts: \(viewModel.wrongAnswers)")
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
                    Button("Correct") {
                        self.viewModel.submitAnswer(isCorrect: true)
                    }.buttonStyle(.borderedProminent)
                     .tint(.green)
                    
                    
                    Button("Wrong") {
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
            Text("Game Over")
                .font(.headline)
            
            Spacer()
                .frame(height: 24)
            
            Text("Correct attempts: \(viewModel.rightAnswers)")
            Text("Wrong attempts: \(viewModel.wrongAnswers)")
            
            Spacer()
                .frame(height: 24)
            
            HStack {
                Button("Play again") {
                    self.viewModel.restartGame()
                }.buttonStyle(.borderedProminent)
                 .tint(.green)
                
                
                Button("Quit game") {
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
