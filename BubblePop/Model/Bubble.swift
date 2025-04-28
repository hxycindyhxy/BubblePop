//
//  Bubble.swift
//  BubblePop
//
//  Created by Xinyi Hu on 27/4/2025.
//

import Foundation
import SwiftUI

// A model representing a bubble displayed on the screen.
struct Bubble: Identifiable {
    var id: UUID = UUID()
    var type: BubbleType
    var position: CGPoint
}

/// The available types of bubbles
enum BubbleType: CaseIterable {
    case red, pink, green, blue, black
}



