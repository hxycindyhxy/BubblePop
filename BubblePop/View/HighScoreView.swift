//
//  HighScoreView.swift
//  BubblePop
//
//  Created by Xinyi Hu on 10/4/2025.
//

import SwiftUI

struct HighScoreView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
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
                    
                    List {
                        ForEach(playerViewModel.players) {player in Text("\(player.name): \(player.score)")}
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    
                    
                    Spacer()
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Play Again")
                    }
                }
            }
        }
        .tint(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
        .environmentObject(playerViewModel)
    }
}

#Preview {
    HighScoreView()
        .environmentObject(PlayerViewModel())
}
