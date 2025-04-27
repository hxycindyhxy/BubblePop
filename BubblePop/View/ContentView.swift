//
//  ContentView.swift
//  BubblePop
//
//  Created by Xinyi Hu on 8/4/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 0.976, green: 0.961, blue: 0.878))
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("BubblePop")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color(red: 0.0078, green: 0.1882, blue: 0.2863))
                        .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: SettingView()) {
                        Text("Play")
                            .font(.title2)
                            .padding()
                            .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                    }
                    .onAppear {
                        playerViewModel.resetCurrentPlayer()
                    }
                    
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
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlayerViewModel())
}

