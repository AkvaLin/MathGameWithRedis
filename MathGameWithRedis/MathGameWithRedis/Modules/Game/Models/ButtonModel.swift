//
//  ButtonModel.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import Foundation

struct ButtonModel {
    let number: Int
    let isCorrect: Bool
    
    init(number: Int, isCorrect: Bool) {
        self.number = number
        self.isCorrect = isCorrect
    }
    
    init() {
        self.number = 0
        self.isCorrect = false
    }
}
