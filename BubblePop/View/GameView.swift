//
//  GameView.swift
//  BubblePop
//
//  Created by Xinyi Hu on 22/4/2025.
//

import SwiftUI

// The main gameplay view where users pop bubbles and track their scores and remaining time.
struct GameView: View {
    @Binding var gameTime: Double
    @Binding var maxBubble: Double
    @State private var showHighScore = false
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @EnvironmentObject var gameViewModel: GameViewModel
    
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.976, green: 0.961, blue: 0.878))
                .ignoresSafeArea()
            VStack{
                /// Display the countdown before the game starts
                if gameViewModel.isCountingDown {
                    Spacer()
                    Text("\(gameViewModel.countdownNumber)")
                        .font(.system(size: 100))
                        .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        .transition(.scale)
                        .id(gameViewModel.countdownNumber)
                    Spacer()
                } else {
                    /// Display game information and bubbles during gameplay
                    HStack{
                        VStack{
                            Text("Time")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            Text(String(Int(timerViewModel.remainTime)))
                                .font(.title3 .bold())
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        VStack{
                            Text("Score")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            Text("\(gameViewModel.score)")
                                .font(.title3 .bold())
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        VStack{
                            Text("Top Score")
                                .font(.title3)
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                            Text("\(playerViewModel.topOnePlayer.score)")
                                .font(.title3 .bold())
                                .foregroundColor(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color(red: 0.3451, green: 0.4157, blue: 0.3176))
                        .padding(.horizontal, 20)
                    
                    GeometryReader { geometry in
                        ZStack {
                            /// Test the game displayed area
                            //                        Rectangle()
                            //                            .strokeBorder(Color.gray, lineWidth: 2)
                            //                            .frame(width: geometry.size.width , height: geometry.size.height)
                            //                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            
                            /// Show bubbles
                            ForEach(gameViewModel.bubbles) { bubble in
                                Button(action: {
                                    gameViewModel.removeBubble(bubble)
                                }) {
                                    Circle()
                                        .fill(BubbleStyle.color(for: bubble.type))
                                        .frame(width: BubbleStyle.size(for: bubble.type).width,
                                               height: BubbleStyle.size(for: bubble.type).height)
                                }
                                .position(bubble.position)
                            }
                        }
                        .onAppear() {
                            /// Set the game displayed area size to screen avaliable size to update different devices like iPhone and iPad.
                            let availableSize = geometry.size
                            gameViewModel.setupGrid(size: availableSize)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            /// Start the pre-game countdown when the view appears
            gameViewModel.startCountdown(
                numberOfBubbles: Int(maxBubble),
                gameAreaSize: CGSize(width: 372, height: 650),
                timerViewModel: timerViewModel,
                gameTime: gameTime
            )
        }
        .onChange(of: timerViewModel.isFinished) {
            /// Handle game over: stop timers, update scores, and trigger the high score screen
            if timerViewModel.isFinished {
                timerViewModel.stopTimer()
                playerViewModel.currentPlayer?.score = gameViewModel.score
                playerViewModel.sortPlayersByScore()
                showHighScore = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(timerViewModel)
        .environmentObject(gameViewModel)
        .environmentObject(playerViewModel)
        .fullScreenCover(isPresented: $showHighScore) {
            HighScoreView()
                .onAppear {
                    gameViewModel.stopBubbleTimer()
                }
        }
    }
}


#Preview {
    GameView(gameTime: .constant(60), maxBubble: .constant(15))
        .environmentObject(TimerViewModel())
        .environmentObject(PlayerViewModel())
        .environmentObject(GameViewModel())
}
