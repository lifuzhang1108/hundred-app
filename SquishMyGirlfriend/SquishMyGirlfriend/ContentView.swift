//
//  ContentView.swift
//  SquishMyGirlfriend
//
//  Created on 10/15/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SquishViewModel()
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.9, blue: 0.95),
                    Color(red: 1.0, green: 0.8, blue: 0.9)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Title
                VStack(spacing: 8) {
                    Text("Squish My Girlfriend!")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.pink, Color.purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("Tap and hold to squish! 🥰")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.pink.opacity(0.8))
                }
                .padding(.top, 40)
                
                Spacer()
                
                // Squish Character Area
                ZStack {
                    // Floating hearts
                    ForEach(viewModel.hearts) { heart in
                        HeartView(heart: heart)
                    }
                    
                    // Main character
                    SquishCharacterView(isSquished: viewModel.isSquished)
                        .scaleEffect(scale)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        scale = 0.95
                                    }
                                    viewModel.squish(at: value.location)
                                }
                                .onEnded { _ in
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        scale = 1.0
                                    }
                                }
                        )
                }
                .frame(height: 300)
                
                // Message display
                Text(viewModel.currentMessage)
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(.pink)
                    .frame(height: 30)
                    .animation(.easeInOut, value: viewModel.currentMessage)
                
                Spacer()
                
                // Stats section
                VStack(spacing: 20) {
                    // Squish counter
                    HStack {
                        Image(systemName: "hand.tap.fill")
                            .foregroundColor(.pink)
                        Text("Squishes Today:")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                        Spacer()
                        Text("\(viewModel.squishCount)")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.pink)
                    }
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    
                    // Love level bar
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.pink)
                            Text("Love Level:")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                            Spacer()
                            Text("\(Int(viewModel.loveLevel))%")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.pink)
                        }
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                // Background
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.5))
                                    .frame(height: 20)
                                
                                // Fill
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.pink, Color.purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: geometry.size.width * (viewModel.loveLevel / 100), height: 20)
                                    .animation(.spring(response: 0.5), value: viewModel.loveLevel)
                            }
                        }
                        .frame(height: 20)
                    }
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    
                    // Reset button
                    Button(action: {
                        withAnimation {
                            viewModel.resetStats()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Reset")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.pink.opacity(0.8), Color.purple.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
}

struct HeartView: View {
    let heart: FloatingHeart
    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        Text("💗")
            .font(.system(size: 30))
            .offset(x: heart.offset, y: offset)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeOut(duration: 2.0)) {
                    offset = -200
                    opacity = 0
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

