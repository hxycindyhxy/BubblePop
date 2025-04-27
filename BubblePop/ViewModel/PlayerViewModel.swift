//
//  PlayerViewModel.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation


class PlayerViewModel: ObservableObject {
    @Published var currentPlayer: Player?
    @Published var players: [Player] = []
    
    func resetCurrentPlayer() {
            currentPlayer = nil
        }
    
    func addNewPlayer(name: String, score: Int) {
        let player = Player(name: name, score: score)
        currentPlayer = player
        players.append(player)
    }
}
