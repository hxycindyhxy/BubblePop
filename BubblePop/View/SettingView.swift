//
//  SettingView.swift
//  BubblePop
//
//  Created by Xinyi Hu on 22/4/2025.
//

import SwiftUI

struct SettingView: View {
    @State private var maxBubble: Double = 15
    @State private var gameStarted = false
    @State private var playerName = ""
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            ZStack{
                Rectangle()
                    .fill(Color(red: 0.976, green: 0.961, blue: 0.878))
                    .ignoresSafeArea()
                VStack{
                    
                    ///Enter Player Name
                    Text("Player Name")
                        .font(.title)
                        .foregroundColor(Color(red: 0.0078, green: 0.1882, blue: 0.2863))
                    TextField("Enter your name", text: $playerName)
                        .padding()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.0078, green: 0.1882, blue: 0.2863) .opacity(0.4), lineWidth: 2)
                        )
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.vertical)
                    
                    Spacer().frame(height: 70)
                    
                    ///Enter Playing Time
                    Text("Game Time: \(Int(timerViewModel.gameTime))")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.0078, green: 0.1882, blue: 0.2863))
                        .padding(.horizontal)
                        .padding(.horizontal)
                    Slider(value: $timerViewModel.gameTime, in: 5...60, step: 1)
                        .tint(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        .padding()
                        .padding(.horizontal)
                        .padding(.horizontal)
                    
                    Spacer().frame(height: 30)
                    
                    ///Enter Max Bubble
                    Text("Max Bubble on Screen: \(Int(maxBubble))")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.0078, green: 0.1882, blue: 0.2863))
                        .padding(.horizontal)
                        .padding(.horizontal)
                    Slider(value: $maxBubble, in: 1...15)
                        .tint(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        .padding()
                        .padding(.horizontal)
                        .padding(.horizontal)
                    
                    Spacer().frame(height: 80)
                    
                    ///Play Game Button
                    NavigationLink(destination: GameView()){
                        Text("Play")
                            .padding()
                            .font(.title .bold())
                            .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                    }
                }
            }
        .environmentObject(playerViewModel)
        .environmentObject(timerViewModel)
    }
    private func addNewPlayer() {
        playerViewModel.addnewPlayer(player: Player(name: playerName, score: 0))
    }
}

#Preview {
    SettingView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlayerViewModel())
}
