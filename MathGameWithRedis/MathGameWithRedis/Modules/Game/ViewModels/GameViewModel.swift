//
//  ViewModel.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import Foundation
import SwiftRedis

class GameViewModel: ObservableObject {
    @Published var choiceArray = Array(repeating: ButtonModel(), count: 4)
    @Published var firstNumber = 0
    @Published var secondNumber = 0
    @Published var score = 0
    @Published var timeLeft = 30.0
    
    public let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var correctAnswer = 0
    private var difficulty = 1000
    private var redis = Redis()
    
    public func generateAnswers() {
        firstNumber = Int.random(in: 0...(difficulty/2))
        secondNumber = Int.random(in: 0...(difficulty/2))
        var answersList = [ButtonModel]()
        
        correctAnswer = firstNumber + secondNumber
        
        for _ in 0...2 {
            var number = Int.random(in: 0...difficulty)
            if number == correctAnswer {
                number += [-1,1].randomElement()!
            }
            answersList.append(ButtonModel(number: number, isCorrect: false))
        }
        
        answersList.append(ButtonModel(number: correctAnswer, isCorrect: true))
        
        choiceArray = answersList.shuffled()
    }
    
    public func correctAnswerPressed() {
        if timeLeft <= 27 {
            timeLeft += 1.5
        } else {
            timeLeft = 30
        }
        score += 1
        difficulty = [50, 75, 100, 250, 500, 750, 1000].randomElement()!
        generateAnswers()
    }
    
    public func incorrectAnswerPressed() {
        if timeLeft >= 2 {
            timeLeft -= 2
        } else {
            timeLeft = 0
        }
    }
    
    public func reset() {
        sendScore()
        score = 0
        timeLeft = 30
        generateAnswers()
    }
    
    public func sendScore() {
        let newScore = self.score
        redis.connect(host: "172.20.10.3", port: 6379) { error in
            if let error = error { return }
            DispatchQueue.global(qos: .utility).async { [weak self] in
                guard let strongSelf = self else { return }
                guard let username = UserDefaults.standard.value(forKey: "username") else { return }
                strongSelf.redis.zscore("TopPlayers", member: "\(username)") { prevScore, err in
                    let prevScore = prevScore?.asInteger ?? 0
                    if newScore > prevScore {
                        strongSelf.redis.zadd("TopPlayers", tuples: (newScore, "\(username)")) { result, err in
                            print(result, err)
                        }
                    }
                }
            }
        }
    }
}
