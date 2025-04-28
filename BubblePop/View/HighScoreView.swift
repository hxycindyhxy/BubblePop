//
//  HighScoreView.swift
//  BubblePop
//
//  Created by Xinyi Hu on 10/4/2025.
//

import SwiftUI

struct HighScoreView: View {
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
                        .padding(.vertical, 10)
                    
                    Rectangle()
                        .frame(height: 120)
                        .opacity(0)
                    
                    VStack{
                        HStack{
                            Text("Your Name:")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            Text(playerViewModel.currentPlayer?.name ?? "Unknown")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        }
                        
                        HStack{
                            Text("Your Score:")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            Text("\(gameViewModel.score)")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        }
                    }
                    .padding(.vertical, 10)
                    
                    Rectangle()
                        .frame(height: 10)
                        .opacity(0)
                                        
                    List {
                        ForEach(playerViewModel.topThreePlayers) {player in
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
                    
                    
                    Spacer()
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Play Again")
                            .font(.title2.bold())
                    }
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
    HighScoreView()
        .environmentObject(PlayerViewModel())
        .environmentObject(TimerViewModel())
        .environmentObject(GameViewModel())
}
