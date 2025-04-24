//
//  GameView.swift
//  BubblePop
//
//  Created by Xinyi Hu on 22/4/2025.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            ZStack{
                Rectangle()
                    .fill(Color(red: 0.976, green: 0.961, blue: 0.878))
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        VStack{
                            Text("Time")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            Text(String(Int(timerViewModel.remainTime)))
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        VStack{
                            Text("Score")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            Text("0")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        VStack{
                            Text("High Score")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            Text("0")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        .padding(.horizontal, 20)
                    
                    VStack {
                        Text("Game in Progress...")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                timerViewModel.initTimer()
            }
            .environmentObject(timerViewModel)
            .fullScreenCover(isPresented: $timerViewModel.isFinished) {
                HighScoreView()
            }
    }
}


#Preview {
    GameView()
        .environmentObject(TimerViewModel())
}
