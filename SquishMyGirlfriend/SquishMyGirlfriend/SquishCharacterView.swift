//
//  SquishCharacterView.swift
//  SquishMyGirlfriend
//
//  Created on 10/15/2025.
//

import SwiftUI

struct SquishCharacterView: View {
    let isSquished: Bool
    
    var body: some View {
        ZStack {
            // Main body
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.pink.opacity(0.8), Color.pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: squishWidth, height: squishHeight)
                .shadow(color: .pink.opacity(0.3), radius: 20, x: 0, y: 10)
            
            // Face elements
            VStack(spacing: 20) {
                // Eyes
                HStack(spacing: 40) {
                    Eye(isSquished: isSquished)
                    Eye(isSquished: isSquished)
                }
                .offset(y: isSquished ? 10 : 0)
                
                // Mouth
                Mouth(isSquished: isSquished)
                    .offset(y: isSquished ? 5 : -5)
            }
            .offset(y: -10)
            
            // Cheeks
            HStack(spacing: 120) {
                Cheek()
                Cheek()
            }
            .offset(y: 20)
            
            // Shine effects
            Circle()
                .fill(Color.white.opacity(0.3))
                .frame(width: 40, height: 40)
                .offset(x: -60, y: -60)
            
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 25, height: 25)
                .offset(x: -70, y: -40)
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSquished)
    }
    
    private var squishWidth: CGFloat {
        isSquished ? 240 : 200
    }
    
    private var squishHeight: CGFloat {
        isSquished ? 180 : 200
    }
}

struct Eye: View {
    let isSquished: Bool
    
    var body: some View {
        ZStack {
            // Eye white
            Capsule()
                .fill(Color.white)
                .frame(width: 18, height: eyeHeight)
            
            // Pupil
            Circle()
                .fill(Color.black)
                .frame(width: 10, height: 10)
                .offset(y: isSquished ? 3 : 0)
            
            // Shine
            Circle()
                .fill(Color.white)
                .frame(width: 4, height: 4)
                .offset(x: -2, y: -2)
        }
    }
    
    private var eyeHeight: CGFloat {
        isSquished ? 10 : 25
    }
}

struct Mouth: View {
    let isSquished: Bool
    
    var body: some View {
        if isSquished {
            // Squished mouth - "O" shape
            ZStack {
                Circle()
                    .fill(Color.pink.opacity(0.3))
                    .frame(width: 30, height: 35)
                Circle()
                    .stroke(Color.pink.opacity(0.8), lineWidth: 3)
                    .frame(width: 30, height: 35)
            }
        } else {
            // Happy smile
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addQuadCurve(
                    to: CGPoint(x: 40, y: 0),
                    control: CGPoint(x: 20, y: 15)
                )
            }
            .stroke(Color.pink.opacity(0.8), style: StrokeStyle(lineWidth: 3, lineCap: .round))
            .frame(width: 40, height: 15)
        }
    }
}

struct Cheek: View {
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [Color.pink.opacity(0.6), Color.pink.opacity(0.2), Color.clear],
                    center: .center,
                    startRadius: 0,
                    endRadius: 20
                )
            )
            .frame(width: 40, height: 40)
    }
}

struct SquishCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.pink.opacity(0.1).ignoresSafeArea()
            VStack(spacing: 40) {
                SquishCharacterView(isSquished: false)
                SquishCharacterView(isSquished: true)
            }
        }
    }
}

