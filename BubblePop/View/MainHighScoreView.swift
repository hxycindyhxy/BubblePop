//
//  MainHighScoreView.swift
//  BubblePop
//
//  Created by Xinyi Hu on 26/4/2025.
//

import SwiftUI

// A view that displays the top 10 highest scores in the game.
struct MainHighScoreView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var gameViewModel: GameViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 0.976, green: 0.961, blue: 0.878))
                    .ignoresSafeArea()
                VStack {
                    Text("High Score")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    /// List displaying the top 10 players and their scores
                    List {
                        ForEach(playerViewModel.topTenPlayers) {player in
                            HStack{
                                Text("\(player.name)")
                                    .font(.title3)
                                    .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                                Spacer()
                                Text("\(player.score)")
                                    .font(.title3)
                                    .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
        }
        .tint(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
        .environmentObject(playerViewModel)
        .environmentObject(timerViewModel)
        .environmentObject(gameViewModel)
    }
}

#Preview {
    MainHighScoreView()
        .environmentObject(PlayerViewModel())
        .environmentObject(TimerViewModel())
        .environmentObject(GameViewModel())
}
