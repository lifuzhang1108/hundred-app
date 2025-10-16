//
//  ContentView.swift
//  PopPimple
//
//  Created on 10/16/2025.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @StateObject private var viewModel = PimpleViewModel()
    @State private var isPlayingVideo = false
    @State private var videoThumbnail: UIImage?
    @State private var player: AVPlayer?
    
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
                        Text("Pimple Couple")
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
                    
                    Text("Ready to pop?")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.pink.opacity(0.8))
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Video preview area
                ZStack {
                    if isPlayingVideo, let player = player {
                        // Inline video player
                        InlineVideoPlayer(player: player)
                            .frame(width: 280, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.pink.opacity(0.5), lineWidth: 3)
                            )
                            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                            .transition(.identity)
                    } else if let thumbnail = videoThumbnail {
                        // Video thumbnail
                        Image(uiImage: thumbnail)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 280, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.pink.opacity(0.5), lineWidth: 3)
                            )
                            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                            .transition(.identity)
                    } else {
                        // Loading placeholder
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 280, height: 350)
                            .overlay(
                                VStack {
                                    ProgressView()
                                        .scaleEffect(1.5)
                                    Text("Loading preview...")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                        .padding(.top, 8)
                                }
                            )
                            .transition(.identity)
                    }
                }
                .frame(height: 400)
                .animation(nil, value: isPlayingVideo)
                
                Spacer()
                
                // Stats section
                VStack(spacing: 15) {
                    // Action button
                    Button(action: {
                        if isPlayingVideo {
                            // Stop video
                            player?.pause()
                            player?.seek(to: .zero)
                            isPlayingVideo = false
                        } else {
                            // Start video
                            setupAndPlayVideo()
                        }
                    }) {
                        HStack {
                            Text(isPlayingVideo ? "😱" : "😈")
                                .font(.system(size: 24))
                            Text(isPlayingVideo ? "STOP" : "LET'S POP!")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text(isPlayingVideo ? "😱" : "😈")
                                .font(.system(size: 24))
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
                        .shadow(color: .pink.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            loadVideoThumbnail()
        }
    }
    
    // Function to extract first frame from video
    private func loadVideoThumbnail() {
        guard let videoURL = Bundle.main.url(forResource: "pimple_pop", withExtension: "mp4") else {
            print("Video file not found")
            return
        }
        
        let asset = AVAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        imageGenerator.requestedTimeToleranceAfter = .zero
        imageGenerator.requestedTimeToleranceBefore = .zero
        
        let time = CMTime(seconds: 0, preferredTimescale: 600)
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                let uiImage = UIImage(cgImage: cgImage)
                
                DispatchQueue.main.async {
                    self.videoThumbnail = uiImage
                }
            } catch {
                print("Error generating thumbnail: \(error.localizedDescription)")
            }
        }
    }
    
    // Function to setup and play video inline
    private func setupAndPlayVideo() {
        guard let videoURL = Bundle.main.url(forResource: "pimple_pop", withExtension: "mp4") else {
            print("Video file not found")
            return
        }
        
        let newPlayer = AVPlayer(url: videoURL)
        newPlayer.seek(to: .zero)
        self.player = newPlayer
        
        isPlayingVideo = true
        
        // Play the video
        newPlayer.play()
        
        // Observe when video ends
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: newPlayer.currentItem,
            queue: .main
        ) { [weak newPlayer] _ in
            newPlayer?.seek(to: .zero)
            self.isPlayingVideo = false
        }
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

