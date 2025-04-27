//
//  Bubble.swift
//  BubblePop
//
//  Created by Xinyi Hu on 27/4/2025.
//

import Foundation
import SwiftUI

enum BubbleType {
    case red, blue
}

struct Bubble: Identifiable {
    var id: UUID = UUID()
    var type: BubbleType
}

//    var point: Int {
//        switch type {
//        case .red: return 1
//        case .blue: return 8
//        }
//    }
    
//    var probability: Double
