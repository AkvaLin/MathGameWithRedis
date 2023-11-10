//
//  MainMenuView.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import SwiftUI

struct MainMenuView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Redis")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image(.radish)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color(.radish))
                    Spacer()
                }
                .frame(height: 50)
                .padding()
                Spacer()
                NavigationLink {
                    GameView()
                } label: {
                    Text("Start game")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                NavigationLink {
                    LeaderboardView()
                } label: {
                    Text("Leaderboard")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Text("Settings")
                    }
                    .buttonStyle(.automatic)
                    .padding(.horizontal)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .tint(.radish)
        .onAppear {
            viewModel.onLaunch()
        }
    }
}

#Preview {
    MainMenuView()
}
