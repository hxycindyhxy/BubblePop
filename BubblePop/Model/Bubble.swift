//
//  Bubble.swift
//  BubblePop
//
//  Created by Xinyi Hu on 27/4/2025.
//

import Foundation
import SwiftUI

enum BubbleType: CaseIterable {
    case red, pink, green, blue, black
}

struct Bubble: Identifiable {
    var id: UUID = UUID()
    var type: BubbleType
    var position: CGPoint
}


