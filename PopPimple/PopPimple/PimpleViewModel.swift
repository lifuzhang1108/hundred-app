//
//  PimpleViewModel.swift
//  PopPimple
//
//  Created on 10/16/2025.
//

import SwiftUI
import Combine

class PimpleViewModel: ObservableObject {
    @Published var pimples: [Pimple] = []
    @Published var poppedCount: Int = 0
    @Published var currentMessage: String = ""
    @Published var popEffects: [PopEffect] = []
    
    let funnyMessages = [
        "EWWW! 🤢",
        "GROSS! 😖",
        "SO SATISFYING! 😌",
        "POP! 💥",
        "That was a BIG one! 🤮",
        "YUCK! 🤢",
        "Nice pop! 👍",
        "Keep going! 😈",
        "Oh no! 😱",
        "SPLAT! 💦"
    ]
    
    init() {
        // Start with some pimples
        addRandomPimples(count: 8)
    }
    
    func popPimple(_ pimple: Pimple) {
        guard !pimple.isPopped else { return }
        
        // Mark as popped
        if let index = pimples.firstIndex(where: { $0.id == pimple.id }) {
            pimples[index].isPopped = true
        }
        
        poppedCount += 1
        
        // Show random message
        let messageToShow = funnyMessages.randomElement() ?? "POP! 💥"
        currentMessage = messageToShow
        
        // Create pop effect
        createPopEffect(at: pimple.position)
        
        // Clear message after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.currentMessage == messageToShow {
                self.currentMessage = ""
            }
        }
        
        // Check if all pimples are popped
        checkAllPopped()
    }
    
    func addRandomPimples(count: Int = 10) {
        // Remove all existing pimples first
        pimples.removeAll()
        poppedCount = 0
        
        // Add new pimples at random positions
        // Positions are relative to the face area (280x350 centered)
        for _ in 0..<count {
            let randomX = CGFloat.random(in: -120...120)
            let randomY = CGFloat.random(in: -150...150)
            let randomSize = CGFloat.random(in: 0.8...1.5)
            
            let pimple = Pimple(
                position: CGPoint(x: randomX, y: randomY),
                size: randomSize
            )
            pimples.append(pimple)
        }
    }
    
    private func createPopEffect(at position: CGPoint) {
        let effect = PopEffect(
            id: UUID(),
            position: position
        )
        popEffects.append(effect)
        
        // Remove effect after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.popEffects.removeAll { $0.id == effect.id }
        }
    }
    
    private func checkAllPopped() {
        let allPopped = pimples.allSatisfy { $0.isPopped }
        if allPopped && !pimples.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.currentMessage = "All clean! 🎉 Tap the button to add more!"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.currentMessage = ""
                }
            }
        }
    }
    
    func reset() {
        pimples.removeAll()
        poppedCount = 0
        currentMessage = ""
        popEffects.removeAll()
    }
}

struct Pimple: Identifiable {
    let id = UUID()
    let position: CGPoint
    let size: CGFloat
    var isPopped: Bool = false
}

struct PopEffect: Identifiable {
    let id: UUID
    let position: CGPoint
}

