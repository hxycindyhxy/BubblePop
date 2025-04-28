//
//  PlayerViewModel.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation

// ViewModel responsible for managing player data, scores, and rankings.
class PlayerViewModel: ObservableObject {
    @Published var currentPlayer: Player?
    @Published var players: [Player] = [] {
        didSet {
            savePlayers()
        }
    }
    private let playersKey = "playersKey"
    
    //0. Display Top N players
    /// The top one player with the highest score. Displayed in GameView during a new game.
    var topOnePlayer: Player {
        players.first ?? Player(name: "Unknown", score: 0)
    }
    
    /// The top three player with the highest score. Displayed in HighScoreView after finsh a game.
    var topThreePlayers: [Player] {
        Array(players.prefix(3))
    }
    
    /// The top ten player with the highest score. Displayed in MainHighScoreView which can be navigated from ContentView.
    var topTenPlayers: [Player] {
        Array(players.prefix(10))
    }

    //1. Load and Safe Players' Detail
    /// Initializes the PlayerViewModel and loads saved player data from UserDefaults.
    init() {
            loadPlayers()
    }
    
    /// Loads the list of players from UserDefaults.
    private func loadPlayers() {
            if let savedData = UserDefaults.standard.data(forKey: playersKey),
               let decoded = try? JSONDecoder().decode([Player].self, from: savedData) {
                players = decoded
            }
    }
    
    /// Saves the current list of players to UserDefaults.
    private func savePlayers() {
         if let encoded = try? JSONEncoder().encode(players) {
             UserDefaults.standard.set(encoded, forKey: playersKey)
         }
     }

    //2. Add New Player and Sort Them by Score
    /// Adds a new player with the specified name and score, updates currentPlayer, and sorts the list.
    /// - Parameters:
    ///   - name: The name of the new player.
    ///   - score: The initial score of the new player.
    func addNewPlayer(name: String, score: Int) {
        let player = Player(name: name, score: score)
        currentPlayer = player
        players.append(player)
        sortPlayersByScore()
    }
    
    /// Sorts the players list by score in descending order.
    func sortPlayersByScore() {
        players.sort { $0.score > $1.score }
    }
    
    /// Resets the current active player to nil.
    func resetCurrentPlayer() {
        currentPlayer = nil
    }
}
