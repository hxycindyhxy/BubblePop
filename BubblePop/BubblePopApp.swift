//
//  BubblePopApp.swift
//  BubblePop
//
//  Created by Xinyi Hu on 8/4/2025.
//

import SwiftUI

@main
struct BubblePopApp: App {
    @StateObject private var timerVM = TimerViewModel()
    @StateObject private var playerVM = PlayerViewModel()
    @StateObject private var gameVM = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerVM)
                .environmentObject(playerVM)
                .environmentObject(gameVM)
        }
    }
}
