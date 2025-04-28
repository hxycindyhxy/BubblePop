//
//  TimerViewModel.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation
import SwiftUI
import Combine


class TimerViewModel:ObservableObject {
    @Published var remainTime: Int = 0
    @Published var isCountingDown = false
    @Published var isFinished = false
    
    private var timer: AnyCancellable?
    
    func initTimer(gameTime: Double) {
        remainTime = Int(gameTime)
        isFinished = false
        isCountingDown = true
        
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    ///Update every second
    private func updateTimer() {
        if remainTime > 0 {
            remainTime -= 1
        } else {
            stopTimer()
            isFinished = true
        }
    }
    
    ///Stop the timer
   func stopTimer() {
        timer?.cancel()
        isCountingDown = false
    }
}
