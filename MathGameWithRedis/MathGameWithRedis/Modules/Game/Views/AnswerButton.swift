//
//  AnswerButton.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import SwiftUI

struct AnswerButton: View {
    
    let number: Int
    let isCorrect: Bool
    let action: () -> Void
    
    @State var backgroundColor: Color = .radish
    
    var body: some View {
        Button {
            if isCorrect {
                let impact = UIImpactFeedbackGenerator(style: .soft)
                impact.impactOccurred(intensity: 0.5)
            } else {
                withAnimation() {
                    backgroundColor = .black
                }
                let impact = UIImpactFeedbackGenerator(style: .heavy)
                impact.impactOccurred(intensity: 3)
                Task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation() {
                            backgroundColor = .radish
                        }
                    }
                }
            }
            action()
        } label: {
            Text("\(number)")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 110, height: 110)
                .background(backgroundColor)
                .clipShape(Circle())
                .padding()
        }
    }
}

#Preview {
    AnswerButton(number: 100, isCorrect: false, action: {})
}
