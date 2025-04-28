//
//  ContentView.swift
//  BubblePop
//
//  Created by Xinyi Hu on 8/4/2025.
//

import SwiftUI

// The entry view of the app, displaying the main menu with navigation options.
struct ContentView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @EnvironmentObject var gameViewModel: GameViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 0.976, green: 0.961, blue: 0.878))
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("BubblePop")
                        .font(.system(size: 45, weight: .bold))
                        .foregroundColor(Color(red: 0.0078, green: 0.1882, blue: 0.2863))
                        .padding()
                    
                    Spacer()
                    
                    /// Navigation link to the game setting view
                    NavigationLink(destination: SettingView()) {
                        Text("Play")
                            .font(.title2)
                            .padding()
                            .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                    }
                    .onAppear {
                        playerViewModel.resetCurrentPlayer()
                    }
                    
                    /// Navigation link to the high score leaderboard view
                    NavigationLink(destination: MainHighScoreView()) {
                        Text("High Score")
                            .font(.title2)
                            .padding()
                            .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                    }
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .tint(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
        .environmentObject(timerViewModel)
        .environmentObject(playerViewModel)
        .environmentObject(gameViewModel)
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlayerViewModel())
        .environmentObject(GameViewModel())
}

