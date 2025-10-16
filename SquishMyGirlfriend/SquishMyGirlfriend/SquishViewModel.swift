//
//  SquishViewModel.swift
//  SquishMyGirlfriend
//
//  Created on 10/15/2025.
//

import SwiftUI
import Combine

class SquishViewModel: ObservableObject {
    @Published var squishCount: Int = 0
    @Published var loveLevel: Double = 0.0
    @Published var isSquished: Bool = false
    @Published var currentMessage: String = ""
    @Published var hearts: [FloatingHeart] = []
    
    private let maxLoveLevel: Double = 100.0
    private let loveIncrement: Double = 2.0
    
    let cuteMessages = [
        "So squishy! 🥰",
        "Love you! 💕",
        "Awww~ 💖",
        "Hehe~ 😊",
        "More squishes! 🤗",
        "You're the best! ✨",
        "Squish squish! 💗",
        "So cute! 🌸",
        "Keep going~ 💝",
        "Love this! 💓"
    ]
    
    func squish(at location: CGPoint) {
        // Update squish state
        isSquished = true
        squishCount += 1
        
        // Update love level
        loveLevel = min(loveLevel + loveIncrement, maxLoveLevel)
        
        // Show random message
        let messageToShow = cuteMessages.randomElement() ?? "Love you! 💕"
        currentMessage = messageToShow
        
        // Create floating hearts
        createHeart(at: location)
        
        // Reset squish after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isSquished = false
        }
        
        // Clear message after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.currentMessage == messageToShow {
                self.currentMessage = ""
            }
        }
    }
    
    private func createHeart(at location: CGPoint) {
        let heart = FloatingHeart(
            id: UUID(),
            position: location,
            offset: CGFloat.random(in: -30...30)
        )
        hearts.append(heart)
        
        // Remove heart after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hearts.removeAll { $0.id == heart.id }
        }
    }
    
    func resetStats() {
        squishCount = 0
        loveLevel = 0
    }
}

struct FloatingHeart: Identifiable {
    let id: UUID
    let position: CGPoint
    let offset: CGFloat
}

