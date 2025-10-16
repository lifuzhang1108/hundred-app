//
//  PimpleView.swift
//  PopPimple
//
//  Created on 10/16/2025.
//

import SwiftUI

struct PimpleView: View {
    let pimple: Pimple
    let onPop: () -> Void
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Outer inflamed area
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.red.opacity(0.3),
                            Color.red.opacity(0.15),
                            Color.red.opacity(0.05)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 20
                    )
                )
                .frame(width: 35 * pimple.size, height: 35 * pimple.size)
            
            // Main pimple body
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.red,
                            Color.red.opacity(0.8)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 10
                    )
                )
                .frame(width: 20 * pimple.size, height: 20 * pimple.size)
                .shadow(color: .red.opacity(0.4), radius: 4, x: 0, y: 2)
            
            // White head (pus)
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white,
                            Color.yellow.opacity(0.9),
                            Color.yellow.opacity(0.7)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 5
                    )
                )
                .frame(width: 10 * pimple.size, height: 10 * pimple.size)
                .offset(y: -1)
            
            // Shine effect
            Circle()
                .fill(Color.white.opacity(0.6))
                .frame(width: 4 * pimple.size, height: 4 * pimple.size)
                .offset(x: -3 * pimple.size, y: -3 * pimple.size)
        }
        .scaleEffect(scale)
        .position(x: 140 + pimple.position.x, y: 200 + pimple.position.y)
        .onTapGesture {
            // Animate pop
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                scale = 1.3
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeOut(duration: 0.2)) {
                    scale = 0
                }
            }
            
            // Trigger pop action
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                onPop()
            }
        }
    }
}

struct PopEffectView: View {
    let effect: PopEffect
    
    @State private var opacity: Double = 1.0
    @State private var scale: CGFloat = 0.5
    @State private var particles: [PopParticle] = []
    
    var body: some View {
        ZStack {
            particlesView
            splashView
        }
        .position(x: effectXPosition, y: effectYPosition)
        .onAppear(perform: setupEffect)
    }
    
    private var particlesView: some View {
        ForEach(particles) { particle in
            Circle()
                .fill(particle.color)
                .frame(width: particle.size, height: particle.size)
                .offset(x: particle.offset.x, y: particle.offset.y)
                .opacity(opacity)
        }
    }
    
    private var splashView: some View {
        ZStack {
            ForEach(0..<8) { i in
                splashCircle(at: i)
            }
        }
        .opacity(opacity)
    }
    
    private func splashCircle(at index: Int) -> some View {
        let angle = Double(index) * .pi / 4
        let xOffset = cos(angle) * 15 * scale
        let yOffset = sin(angle) * 15 * scale
        
        return Circle()
            .fill(Color.yellow.opacity(0.7))
            .frame(width: 6, height: 6)
            .offset(x: xOffset, y: yOffset)
    }
    
    private var effectXPosition: CGFloat {
        140 + effect.position.x
    }
    
    private var effectYPosition: CGFloat {
        200 + effect.position.y
    }
    
    private func setupEffect() {
        generateParticles()
        animateEffect()
    }
    
    private func generateParticles() {
        for _ in 0..<12 {
            let randomAngle = Double.random(in: 0...(2 * .pi))
            let randomDistance = CGFloat.random(in: 10...30)
            let xOffset = cos(randomAngle) * randomDistance
            let yOffset = sin(randomAngle) * randomDistance
            
            let colors: [Color] = [.yellow, .white, Color.yellow.opacity(0.8)]
            let randomColor = colors.randomElement() ?? .yellow
            
            let particle = PopParticle(
                offset: CGPoint(x: xOffset, y: yOffset),
                size: CGFloat.random(in: 3...8),
                color: randomColor
            )
            particles.append(particle)
        }
    }
    
    private func animateEffect() {
        withAnimation(.easeOut(duration: 0.5)) {
            scale = 1.5
            opacity = 0
        }
    }
}

struct PopParticle: Identifiable {
    let id = UUID()
    let offset: CGPoint
    let size: CGFloat
    let color: Color
}

struct PimpleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.pink.opacity(0.1).ignoresSafeArea()
            PimpleView(
                pimple: Pimple(position: .zero, size: 1.0),
                onPop: {}
            )
        }
    }
}

