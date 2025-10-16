//
//  ContentView.swift
//  PopPimple
//
//  Created on 10/16/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PimpleViewModel()
    @State private var isPlayingVideo = false
    
    var body: some View {
        if isPlayingVideo {
            VideoPlayerView(videoName: "pimple_pop", onFinish: {
                isPlayingVideo = false
                withAnimation {
                    viewModel.addRandomPimples()
                }
            })
            .transition(.opacity)
        } else {
            mainContentView
        }
    }
    
    private var mainContentView: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.95, blue: 0.85),
                    Color(red: 1.0, green: 0.9, blue: 0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Title
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        Text("🤮")
                            .font(.system(size: 40))
                        Text("Pimple Popper Prank")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        Text("🤮")
                            .font(.system(size: 40))
                    }
                    
                    Text("Let the popping begin!")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.pink.opacity(0.8))
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Face with pimples area
                ZStack {
                    // Face background (placeholder - could be replaced with actual photo)
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.99, green: 0.96, blue: 0.92),
                                    Color(red: 0.98, green: 0.94, blue: 0.88)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 280, height: 350)
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                    
                    // Pimples
                    ForEach(viewModel.pimples) { pimple in
                        if !pimple.isPopped {
                            PimpleView(pimple: pimple) {
                                viewModel.popPimple(pimple)
                            }
                        }
                    }
                    
                    // Pop effects
                    ForEach(viewModel.popEffects) { effect in
                        PopEffectView(effect: effect)
                    }
                    
                    // Emoji decorations on face
                    VStack(spacing: 60) {
                        HStack(spacing: 80) {
                            Text("😨")
                                .font(.system(size: 35))
                            Text("😨")
                                .font(.system(size: 35))
                        }
                        
                        Text("😱")
                            .font(.system(size: 40))
                    }
                }
                .frame(height: 400)
                
                // Message display
                Text(viewModel.currentMessage)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundColor(.pink)
                    .frame(height: 30)
                    .animation(.easeInOut, value: viewModel.currentMessage)
                
                Spacer()
                
                // Stats section
                VStack(spacing: 15) {
                    // Pop counter
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.red)
                        Text("Pimples Popped:")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                        Spacer()
                        Text("\(viewModel.poppedCount)")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.pink)
                    }
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    
                    // Tip text
                    HStack {
                        Text("💡")
                        Text("Tip: Click the button to add pimples to the photo")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.orange.opacity(0.8))
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(15)
                    
                    // Action buttons
                    HStack(spacing: 15) {
                        Button(action: {
                            withAnimation {
                                isPlayingVideo = true
                            }
                        }) {
                            HStack {
                                Text("😈")
                                    .font(.system(size: 18))
                                Text("LET'S POP!")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                Text("😈")
                                    .font(.system(size: 18))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                        }
                        
                        Button(action: {
                            withAnimation {
                                viewModel.reset()
                            }
                        }) {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(Color.gray.opacity(0.6))
                                .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

