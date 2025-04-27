//
//  GameViewModel.swift
//  BubblePop
//
//  Created by Xinyi Hu on 24/4/2025.
//

import Foundation
import SwiftUI

class GameViewModel:ObservableObject {
    @Published var bubbles: [Bubble] = []
    
    func createBubble() {
        let randomType: BubbleType = [.red, .blue].randomElement()!
        let newBubble = Bubble(type: randomType)
        bubbles.append(newBubble)
    }
}
