//
//  Player.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation

class Player: Codable, ObservableObject, Identifiable {
    var id = UUID()
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
