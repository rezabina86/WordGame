//
//  ContentView.swift
//  WordGame
//
//  Created by Reza Bina on 11/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = WordGameViewModel()
    
    var body: some View {
        if viewModel.isGameFinished {
            resultView()
        } else {
            gameView()
        }
    }
    
    @ViewBuilder
    func gameView() -> some View {
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
            Text(viewModel.currentRoundData?.english ?? "")
            
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
    
    @ViewBuilder
    func resultView() -> some View {
        VStack(alignment: .center) {
            Spacer()
            Text("Game Over")
            Text("Correct attempts: \(viewModel.rightAnswers)")
            Text("Wrong attempts: \(viewModel.wrongAnswers)")
            Text("No answers: \(viewModel.noAnswers)")
            Spacer()
            HStack {
                Button("Play again") {
                    self.viewModel.restartGame()
                }.buttonStyle(.borderedProminent)
                 .tint(.green)
                
                
                Button("Quit") {
                    //self.viewModel.submitAnswer(isCorrect: false)
                }.buttonStyle(.borderedProminent)
                 .tint(.red)
            }
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
