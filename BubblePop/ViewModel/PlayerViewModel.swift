//
//  PlayerViewModel.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation


class PlayerViewModel: ObservableObject {
    @Published var players: [Player] = []
    
    func addnewPlayer(player: Player) {
        let newPlayer = Player(name: player.name, score: player.score)
        players.append(newPlayer)
    }
}
