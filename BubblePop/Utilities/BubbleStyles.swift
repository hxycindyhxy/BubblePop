//
//  BubbleStyles.swift
//  BubblePop
//
//  Created by Xinyi Hu on 27/4/2025.
//

import SwiftUI

// A utility struct that provides bubble style properties such as color, size, score, and random generation probability.
struct BubbleStyle {
    
    /// Returns the color associated with a given bubble type.
    /// - Parameter type: The type of the bubble.
    /// - Returns: A `Color` corresponding to the specified bubble type.
    static func color(for type: BubbleType) -> Color {
        switch type {
        case .red: return Color(red: 0.898, green: 0.353, blue: 0.251)
        case .pink: return Color(red: 0.945, green: 0.725, blue: 0.647)
        case .green: return Color(red: 0.545, green: 0.553, blue: 0.337)
        case .blue: return Color(red: 0.525, green: 0.561, blue: 0.788)
        case .black: return Color(red: 0.196, green: 0.184, blue: 0.180)
        }
    }
    
    /// Returns the fixed size for a bubble, regardless of type.
    /// - Parameter type: The type of the bubble (currently unused).
    /// - Returns: A `CGSize` representing the width and height of a bubble.
    static func size(for type: BubbleType) -> CGSize {
        return CGSize(width: 55, height: 55)
    }
    
    /// Randomly selects a bubble type based on predefined appearance probabilities.
    /// - Returns: A randomly chosen `BubbleType`.
    static func randomType() -> BubbleType {
        var typePool: [BubbleType] = []
        typePool += Array(repeating: .red, count: 40)
        typePool += Array(repeating: .pink, count: 30)
        typePool += Array(repeating: .green, count: 15)
        typePool += Array(repeating: .blue, count: 10)
        typePool += Array(repeating: .black, count: 5)
        
        return typePool.randomElement()!
    }
    
    /// Returns the score value assigned to a specific bubble type.
    /// - Parameter type: The type of the bubble.
    /// - Returns: An `Int` representing the points earned by popping this type of bubble.
    static func score(for type: BubbleType) -> Int {
          switch type {
          case .red: return 1
          case .pink: return 2
          case .green: return 5
          case .blue: return 8
          case .black: return 10
          }
      }
}
