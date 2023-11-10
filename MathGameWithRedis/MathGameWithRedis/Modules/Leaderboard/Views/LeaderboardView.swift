//
//  LeaderboardView.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import SwiftUI

struct LeaderboardView: View {
    
    @StateObject private var viewModel = LeaderboardViewModel()
    
    var body: some View {
        VStack {
            Text("Personal best: \(viewModel.personalScore)")
            List {
                ForEach(viewModel.users) { user in
                    HStack {
                        Text(user.name)
                        Spacer()
                        Text("\(user.score)")
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

#Preview {
    LeaderboardView()
}
