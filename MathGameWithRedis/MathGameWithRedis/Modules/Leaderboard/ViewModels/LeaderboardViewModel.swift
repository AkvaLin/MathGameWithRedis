//
//  LeaderboardViewModel.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import Foundation
import SwiftRedis

class LeaderboardViewModel: ObservableObject {
    
    @Published var users = [UserModel]()
    @Published var personalScore = 0
    
    private let redis = Redis()
    
    public func onAppear() {
        
        var topUsers = [UserModel]()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.redis.connect(host: "172.20.10.3", port: 6379) { (redisError: NSError?) in
                if let error = redisError {
                    print(error)
                } else {
                    strongSelf.redis.zrange("TopPlayers", start: 0, stop: 25) { result, err in
                        var data = [UserModel]()
                        guard let result = result else { return }
                        result.forEach { user in
                            guard let user = user else { return }
                            strongSelf.redis.zscore("TopPlayers", member: user) { score, err in
                                guard let score = score?.asInteger else { return }
                                data.append(UserModel(name: user.asString, score: score))
                            }
                        }
                        DispatchQueue.main.async {
                            strongSelf.users = data.reversed()
                        }
                    }
                }
            }
        }
    }
}
