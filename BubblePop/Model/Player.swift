//
//  Player.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation

// A model representing a player with a name and score.
class Player: Codable, ObservableObject, Identifiable {
    var id = UUID()
    var name: String
    var score: Int
    
    /// Initializes a new player with a given name and score.
    /// - Parameters:
    ///   - name: The player's name.
    ///   - score: The player's score.
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
