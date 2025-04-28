//
//  GameViewModel.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var bubbles: [Bubble] = []
    @Published var score: Int = 0
    
    private var lastPoppedBubbleType: BubbleType? = nil
    private var comboCount: Int = 0
    private var availableGridCenters: [CGPoint] = []
    private var timer: AnyCancellable?
    
    private let safeMargin: CGFloat = 25
    
    func setupGrid(size: CGSize, gridSize: CGFloat = 80) {
        let numberOfColumns = Int((size.width - safeMargin * 2) / gridSize)
        let numberOfRows = Int((size.height - safeMargin * 2) / gridSize)
        
        availableGridCenters = []
        
        for row in 0..<numberOfRows {
            for col in 0..<numberOfColumns {
                let centerX = safeMargin + CGFloat(col) * gridSize + gridSize / 2
                let centerY = safeMargin + CGFloat(row) * gridSize + gridSize / 2
                let position = CGPoint(x: centerX, y: centerY)
                availableGridCenters.append(position)
            }
        }
    }
    
    func generateBubbles(numberOfBubbles: Int) {
        bubbles.removeAll()
        
        var tempCenters = availableGridCenters
        
        for _ in 0..<numberOfBubbles {
            if tempCenters.isEmpty { break }
            
            let randomIndex = tempCenters.indices.randomElement()!
            let centerPosition = tempCenters[randomIndex]
            tempCenters.remove(at: randomIndex)
            
            let offsetX = CGFloat.random(in: -12...12)
            let offsetY = CGFloat.random(in: -12...12)
            let finalPosition = CGPoint(x: centerPosition.x + offsetX, y: centerPosition.y + offsetY)
            
            let randomType = BubbleStyle.randomType()
            let newBubble = Bubble(type: randomType, position: finalPosition)
            
            bubbles.append(newBubble)
        }
    }
    
    func startBubbleTimer(numberOfBubbles: Int) {
        stopBubbleTimer()
        
        timer = Timer
            .publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.generateBubbles(numberOfBubbles: numberOfBubbles)
            }
    }
    
    func stopBubbleTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func addScore(for bubble: Bubble) {
        let baseScore = BubbleStyle.score(for: bubble.type)
        
        if let lastType = lastPoppedBubbleType, lastType == bubble.type {
            let bonusScore = Int(round(Double(baseScore) * 1.5))
            score += bonusScore
        } else {
            score += baseScore
        }
        lastPoppedBubbleType = bubble.type
    }
    
    func removeBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            addScore(for: bubble)
            bubbles.remove(at: index)
        }
    }
    
    
}




