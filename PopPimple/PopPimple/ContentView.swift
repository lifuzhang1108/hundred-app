//
//  ContentView.swift
//  PopPimple
//
//  Created on 10/16/2025.
//

import SwiftUI
import AVKit
import UIKit

struct ContentView: View {
    @StateObject private var viewModel = PimpleViewModel()
    @State private var isPlayingVideo = false
    @State private var player: AVPlayer?
    @State private var currentPhase: Int = 0 // 0 = not started, 1 = first tenth, 2 = second tenth, etc.
    @State private var videoDuration: Double = 0
    @State private var timeObserver: Any?

    // Draggable hand properties
    @State private var handPosition: CGPoint = CGPoint(x: 300, y: 600)
    @State private var handOffset: CGSize = .zero
    @State private var isDragging = false
    @State private var handScale: CGFloat = 1.0
    @State private var handRotation: Angle = .zero
    
    var body: some View {
        mainContentView
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
                            .onTapGesture {
                                animateHand()
                            }
                        Text("Pimple Boo")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .onTapGesture {
                                animateHand()
                            }
                        Text("🤮")
                            .font(.system(size: 40))
                            .onTapGesture {
                                animateHand()
                            }
                    }
                    
                    if currentPhase == 0 {
                        VStack(spacing: 5) {
                            Text("Drag the hand around and tap it to start!")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.pink.opacity(0.8))
                                .multilineTextAlignment(.center)
                            Text("👆 Look for the yellow hand!")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Video preview area - always showing video (paused or playing)
                ZStack {
                    if let player = player {
                        InlineVideoPlayer(player: player)
                            .frame(width: 280, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.pink.opacity(0.5), lineWidth: 3)
                            )
                            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                    } else {
                        // Loading placeholder (only shown briefly on first load)
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 280, height: 350)
                            .overlay(
                                VStack {
                                    ProgressView()
                                        .scaleEffect(1.5)
                                    Text("Loading...")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                        .padding(.top, 8)
                                }
                            )
                    }
                }
                .frame(height: 400)
                
                Spacer()
                
                // Stats section
                VStack(spacing: 15) {
                    // Action button
                    Button(action: {
                        // TODO: Implement upload new face functionality
                        print("Upload new face tapped")
                        animateHand()
                    }) {
                        VStack(spacing: 8) {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(.white)

                            Text("Upload New Face")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 25)
                        .padding(.horizontal, 20)
                        .background(
                            LinearGradient(
                                colors: [Color.pink, Color.purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(20)
                        .shadow(color: .pink.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }

            // Draggable hand overlay (on top of everything)
            DraggableHandView(
                position: $handPosition,
                isDragging: $isDragging,
                scale: handScale,
                rotation: handRotation,
                onTap: {
                    playNextPhase()
                }
            )
        }
        .onAppear {
            setupPlayer()
            // Position hand in upper right area for better visibility (avoid bottom UI)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                handPosition = CGPoint(x: UIScreen.main.bounds.width - 100, y: 300)
            }
        }
        .onDisappear {
            // Clean up observer
            if let observer = timeObserver, let player = player {
                player.removeTimeObserver(observer)
            }
        }
    }
    
    
    // Setup player when view loads (preload)
    private func setupPlayer() {
        guard let videoURL = Bundle.main.url(forResource: "pimple_pop", withExtension: "mp4") else {
            print("Video file not found")
            return
        }
        
        let newPlayer = AVPlayer(url: videoURL)
        newPlayer.seek(to: .zero)
        self.player = newPlayer
        
        // Get video duration
        let asset = AVAsset(url: videoURL)
        Task {
            do {
                let duration = try await asset.load(.duration)
                await MainActor.run {
                    self.videoDuration = CMTimeGetSeconds(duration)
                }
            } catch {
                print("Error loading video duration: \(error)")
            }
        }
        
        // Observe when segment ends
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: newPlayer.currentItem,
            queue: .main
        ) { [weak newPlayer] _ in
            self.isPlayingVideo = false
            // Don't reset phase - user will advance it manually
        }
    }
    
    // Play the next phase
    private func playNextPhase() {
        guard let player = player, videoDuration > 0 else { return }

        // Remove any existing time observer
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
            timeObserver = nil
        }

        let segmentDuration = videoDuration / 10.0

        // Advance to next phase
        currentPhase += 1

        // If we've completed all phases, restart
        if currentPhase > 10 {
            currentPhase = 0
            player.seek(to: .zero)
            return
        }

        // Calculate start and end times for this phase
        let startTime = Double(currentPhase - 1) * segmentDuration
        let endTime = Double(currentPhase) * segmentDuration

        print("Playing phase \(currentPhase): \(startTime)s to \(endTime)s")

        // Seek to the start of this segment and wait for it to complete
        player.seek(to: CMTime(seconds: startTime, preferredTimescale: 600), toleranceBefore: .zero, toleranceAfter: .zero) { finished in
            if finished {
                // Set up a boundary observer to stop at the end of this segment
                let endTimeValue = CMTime(seconds: endTime, preferredTimescale: 600)
                let times = [NSValue(time: endTimeValue)]

                self.timeObserver = player.addBoundaryTimeObserver(forTimes: times, queue: .main) {
                    player.pause()
                    self.isPlayingVideo = false
                    print("Phase \(self.currentPhase) completed")
                }

                // Play the segment
                self.isPlayingVideo = true
                player.play()
            }
        }
    }

    // Animate the hand when other UI elements are tapped
    private func animateHand() {
        // Random new position - avoid bottom area where upload button is
        let screenBounds = UIScreen.main.bounds
        let newX = CGFloat.random(in: 80...(screenBounds.width - 80))
        let newY = CGFloat.random(in: 120...(screenBounds.height - 250)) // Avoid bottom 250px for UI

        // Animate to new position with scale and rotation
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            handPosition = CGPoint(x: newX, y: newY)
            handScale = 1.2
            handRotation = .degrees(Double.random(in: -30...30))
        }

        // Return to normal after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                handScale = 1.0
                handRotation = .zero
            }
        }
    }

}

// Draggable hand view
struct DraggableHandView: View {
    @Binding var position: CGPoint
    @Binding var isDragging: Bool
    let scale: CGFloat
    let rotation: Angle
    let onTap: () -> Void

    // Screen bounds for constraining movement
    private var screenBounds: CGRect {
        UIScreen.main.bounds
    }

    var body: some View {
        Image(systemName: "hand.point.up.fill")
            .font(.system(size: 60, weight: .bold))
            .foregroundColor(.yellow)
            .shadow(color: .yellow.opacity(0.4), radius: 10, x: 0, y: 5)
            .position(position)
            .scaleEffect(scale)
            .rotationEffect(rotation)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        // Constrain position within screen bounds, avoiding bottom UI area
                        let newX = max(60, min(screenBounds.width - 60, value.location.x))
                        let newY = max(100, min(screenBounds.height - 200, value.location.y)) // Avoid bottom 200px for UI
                        position = CGPoint(x: newX, y: newY)
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            .onTapGesture {
                onTap()
            }
            .animation(isDragging ? nil : .spring(response: 0.3, dampingFraction: 0.6), value: position)
    }
}

// Inline video player view
struct InlineVideoPlayer: UIViewRepresentable {
    let player: AVPlayer
    
    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.playerLayer.player = player
        view.playerLayer.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) {
        // Frame is handled automatically by PlayerView's layoutSubviews
    }
    
    class PlayerView: UIView {
        override class var layerClass: AnyClass {
            return AVPlayerLayer.self
        }
        
        var playerLayer: AVPlayerLayer {
            return layer as! AVPlayerLayer
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            // Frame is automatically set because the layer IS the view's layer
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

