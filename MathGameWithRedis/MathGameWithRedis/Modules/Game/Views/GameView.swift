//
//  ContentView.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    @State var showAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ProgressView(value: viewModel.timeLeft, total: 30) {
                Text("Time left: \(Int(viewModel.timeLeft))")
            }
            .progressViewStyle(.linear)
            .padding(.horizontal)
            Spacer()
            Text("\(viewModel.firstNumber) + \(viewModel.secondNumber)")
                .font(.largeTitle)
                .bold()
            
            HStack {
                ForEach(0..<2) { index in
                    AnswerButton(number: viewModel.choiceArray[index].number, isCorrect: viewModel.choiceArray[index].isCorrect) {
                        if viewModel.choiceArray[index].isCorrect {
                            viewModel.correctAnswerPressed()
                        } else {
                            viewModel.incorrectAnswerPressed()
                        }
                    }
                }
            }
            HStack {
                ForEach(2..<4) { index in
                    AnswerButton(number: viewModel.choiceArray[index].number, isCorrect: viewModel.choiceArray[index].isCorrect) {
                        if viewModel.choiceArray[index].isCorrect {
                            viewModel.correctAnswerPressed()
                        } else {
                            viewModel.incorrectAnswerPressed()
                        }
                    }
                }
            }
            
            Text("Score: \(viewModel.score)")
                .font(.headline)
                .bold()
                .padding()
            Spacer()
            
        }
        .padding()
        .onAppear(perform: viewModel.generateAnswers)
        .onReceive(viewModel.timer) { time in
            if viewModel.timeLeft > 0 {
                viewModel.timeLeft -= 1
            }
        }
        .onChange(of: viewModel.timeLeft) { oldValue, newValue in
            if newValue <= 0 {
                showAlert = true
            }
        }
        .alert("The game is over", isPresented: $showAlert) {
            Button("Restart") {
                viewModel.reset()
            }
            Button("Return to main page") {
                viewModel.sendScore()
                dismiss()
            }
        }
    }
}

#Preview {
    GameView()
}
