//
//  VideoPlayerView.swift
//  PopPimple
//
//  Created on 10/16/2025.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoName: String
    let onFinish: () -> Void
    
    @State private var player: AVPlayer?
    @State private var isVideoEnded = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let player = player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
                    .onAppear {
                        player.play()
                        setupVideoEndObserver()
                    }
                    .onDisappear {
                        player.pause()
                        NotificationCenter.default.removeObserver(self)
                    }
            } else {
                VStack(spacing: 20) {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                    Text("Loading video...")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
            }
            
            // Skip button
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        player?.pause()
                        onFinish()
                    }) {
                        Text("Skip")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(20)
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .onAppear {
            setupPlayer()
        }
    }
    
    private func setupPlayer() {
        guard let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            print("Video file not found: \(videoName).mp4")
            // If video not found, skip to finish
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                onFinish()
            }
            return
        }
        
        player = AVPlayer(url: videoURL)
        player?.volume = 1.0
        
        // Ensure video starts from the beginning
        player?.seek(to: .zero)
    }
    
    private func setupVideoEndObserver() {
        guard let player = player else { return }
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            if !isVideoEnded {
                isVideoEnded = true
                onFinish()
            }
        }
    }
}

