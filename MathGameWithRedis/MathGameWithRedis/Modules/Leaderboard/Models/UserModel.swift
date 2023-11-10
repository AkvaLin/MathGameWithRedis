//
//  UserModel.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import Foundation

struct UserModel: Identifiable {
    let name: String
    let score: Int
    let id = UUID()
}
