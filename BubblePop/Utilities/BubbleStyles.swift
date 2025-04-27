//
//  BubbleStyles.swift
//  BubblePop
//
//  Created by Xinyi Hu on 27/4/2025.
//

import SwiftUI

struct BubbleStyle {
    static func color(for type: BubbleType) -> Color {
        switch type {
        case .red: return .red
        case .blue: return .blue
        }
    }
    
    static func size(for type: BubbleType) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
