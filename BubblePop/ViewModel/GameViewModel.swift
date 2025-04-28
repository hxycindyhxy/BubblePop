//
//  GameViewModel.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation
import SwiftUI
import Combine

// ViewModel responsible for managing game setup and game features.
class GameViewModel: ObservableObject {
    @Published var bubbles: [Bubble] = []
    @Published var score: Int = 0
    
    private var lastPoppedBubbleType: BubbleType? = nil
    private var comboCount: Int = 0
    private var availableGridCenters: [CGPoint] = []
    private var timer: AnyCancellable?
    
    private let safeMargin: CGFloat = 25
    
    @Published var countdownNumber: Int = 3
    @Published var isCountingDown: Bool = true
    private var countdownTimer: AnyCancellable?
    
    //0.Set Up Grid and Generate Bubbles
    
    ///Set up the grid with safe margin to avoid bubble go out of the screen
    /// - Parameter size: The available game area size.
    /// - Parameter gridSize: The width and height of each grid cell (default is 80).
    func setupGrid(size: CGSize, gridSize: CGFloat = 80) {
        let numberOfColumns = Int((size.width - safeMargin * 2) / gridSize)
        let numberOfRows = Int((size.height - safeMargin * 2) / gridSize)
        
        availableGridCenters = []
        
        ///Calculate the center position of the grid
        for row in 0..<numberOfRows {
            for col in 0..<numberOfColumns {
                let centerX = safeMargin + CGFloat(col) * gridSize + gridSize / 2
                let centerY = safeMargin + CGFloat(row) * gridSize + gridSize / 2
                let position = CGPoint(x: centerX, y: centerY)
                availableGridCenters.append(position)
            }
        }
    }
    
    /// Generates a new set of bubbles and randomly positioned within the available grid centers.
    /// - Parameter numberOfBubbles: The number of bubbles to generate. It will be passed from the SettingView and get from the GameView.
    func generateBubbles(numberOfBubbles: Int) {
        bubbles.removeAll()
        
        var tempCenters = availableGridCenters
        
        for _ in 0..<numberOfBubbles {
            if tempCenters.isEmpty { break }
            
            let randomIndex = tempCenters.indices.randomElement()!
            let centerPosition = tempCenters[randomIndex]
            tempCenters.remove(at: randomIndex)
            
            ///Offset the center position a little bit to make it looks more naturally displayed
            let offsetX = CGFloat.random(in: -12...12)
            let offsetY = CGFloat.random(in: -12...12)
            let finalPosition = CGPoint(x: centerPosition.x + offsetX, y: centerPosition.y + offsetY)
            
            let randomType = BubbleStyle.randomType()
            let newBubble = Bubble(type: randomType, position: finalPosition)
            
            bubbles.append(newBubble)
        }
    }
    
    //1. Features
    
    //1.1 Refresh Bubble Display
    ///Monitor the refreshment of the bubble sets displayed.
    /// - Parameters: numberOfBubbles: The number of bubbles to generate each time. It will be passed from the SettingView and get from the GameView.
    /// - Parameters: timerViewModel: The timer view model used to monitor remaining game time.
    func startBubbleTimer(numberOfBubbles: Int, timerViewModel: TimerViewModel) {
        stopBubbleTimer()
        
        ///Starts the bubble refresh timer. Initially refreshes every 2 seconds,
        timer = Timer
            .publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                ///and switches to every 1 second during the last 5 seconds of the game.
                if timerViewModel.remainTime <= 5 {
                    self.stopBubbleTimer()
                    self.timer = Timer
                        .publish(every: 1, on: .main, in: .common)
                        .autoconnect()
                        .sink { [weak self] _ in
                            self?.generateBubbles(numberOfBubbles: numberOfBubbles)
                        }
                }
                
                self.generateBubbles(numberOfBubbles: numberOfBubbles)
            }
    }
    
    
    /// Stops the currently running bubble refresh timer.
    func stopBubbleTimer() {
        timer?.cancel()
        timer = nil
    }
    
    //1.2 Add Score
    /// Adds score based on the type of bubble popped.
    /// - Parameter bubble: The bubble that was popped.
    private func addScore(for bubble: Bubble) {
        let baseScore = BubbleStyle.score(for: bubble.type)
        
        /// Consecutive bubbles of the same type earn a 1.5x score multiplier after the first one.
        if let lastType = lastPoppedBubbleType, lastType == bubble.type {
            let bonusScore = Int(round(Double(baseScore) * 1.5))
            score += bonusScore
        } else {
            score += baseScore
        }
        lastPoppedBubbleType = bubble.type
    }
    
    /// Removes the tapped bubble from the screen and updates the score accordingly.
    /// - Parameter bubble: The bubble object that was tapped by the player.
    func removeBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            addScore(for: bubble)
            bubbles.remove(at: index)
        }
    }
    
    //1.3 Countdown Animation
    /// Starts the pre-game countdown (3-2-1).
    /// - Parameters:
    ///   - totalTime: The total countdown time (default is 3 seconds).
    ///   - numberOfBubbles: The number of bubbles to generate initially.
    ///   - gameAreaSize: The size of the game area for grid setup.
    ///   - timerViewModel: The timer view model responsible for the game countdown.
    ///   - gameTime: The total game time in seconds.
    func startCountdown(totalTime: Int = 3, numberOfBubbles: Int, gameAreaSize: CGSize, timerViewModel: TimerViewModel, gameTime: Double) {
        countdownNumber = totalTime
        isCountingDown = true
        
        countdownTimer?.cancel()
        
        countdownTimer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.countdownNumber -= 1
                
                ///Starts the game after countdown
                if self.countdownNumber == 0 {
                    self.countdownTimer?.cancel()
                    self.isCountingDown = false
                    
                    timerViewModel.initTimer(gameTime: gameTime)
                    self.score = 0
                    self.stopBubbleTimer()
                    self.setupGrid(size: gameAreaSize)
                    self.generateBubbles(numberOfBubbles: numberOfBubbles)
                    self.startBubbleTimer(numberOfBubbles: numberOfBubbles, timerViewModel: timerViewModel)
                }
            }
    }
}




