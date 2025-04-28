//
//  PlayerViewModel.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation


class PlayerViewModel: ObservableObject {
    @Published var currentPlayer: Player?
    @Published var players: [Player] = [] {
        didSet {
            savePlayers()
        }
    }
    
    private let playersKey = "playersKey"
    
    var topThreePlayers: [Player] {
        Array(players.prefix(3))
    }
    
    var topTenPlayers: [Player] {
        Array(players.prefix(10))
    }
    
    init() {
            loadPlayers()
    }
    
    private func savePlayers() {
         if let encoded = try? JSONEncoder().encode(players) {
             UserDefaults.standard.set(encoded, forKey: playersKey)
         }
     }
    
    private func loadPlayers() {
            if let savedData = UserDefaults.standard.data(forKey: playersKey),
               let decoded = try? JSONDecoder().decode([Player].self, from: savedData) {
                players = decoded
            }
    }
    
    func sortPlayersByScore() {
        players.sort { $0.score > $1.score }
    }
    
    func addNewPlayer(name: String, score: Int) {
        let player = Player(name: name, score: score)
        currentPlayer = player
        players.append(player)
        sortPlayersByScore()
    }
    
    func resetCurrentPlayer() {
        currentPlayer = nil
    }
}
