# 🤮 Pop Pimple - iOS App

A fun and satisfying pimple popping prank app for iOS!

## 🎮 Features

- **🎥 Video Intro**: Plays your custom pimple popping video when you tap "LET'S POP!" (add your own 5s video!)
- **Interactive Pimple Popping**: Tap on pimples to pop them with satisfying animations
- **Realistic Pimple Graphics**: Red, inflamed pimples with white heads
- **Pop Effects**: Splatter animations when you pop each pimple
- **Counter System**: Track how many pimples you've popped
- **Funny Messages**: Get hilarious reactions with each pop (EWWW! GROSS! SO SATISFYING!)
- **Add More Pimples**: Tap the "LET'S POP!" button to play video and add more pimples
- **Reset Option**: Clear all pimples and start fresh

## 🚀 How to Use

1. **Add Your Video** (Optional but Recommended):
   - See `HOW_TO_ADD_VIDEO.md` for detailed instructions
   - Name your video `pimple_pop.mp4` and add it to the project
   - It will play when the "LET'S POP!" button is tapped!

2. **Open in Xcode**: 
   - Navigate to the `PopPimple` folder
   - Double-click `PopPimple.xcodeproj` to open in Xcode

3. **Build and Run**:
   - Select your target device (iPhone simulator or physical device)
   - Click the Play button or press `Cmd + R`

4. **Play the App**:
   - Tap the **"LET'S POP! 😈"** button to play your video
   - After video ends, pimples appear on the face
   - Tap on any pimple to pop it
   - Watch the satisfying pop animation and splatter effects
   - See funny messages appear with each pop
   - Track your popped pimples count
   - Use the reset button (↻) to clear everything

## 🎨 Customization Ideas

Want to make it your own? Here are some ideas:

1. **Add Your Own Photo**: Replace the placeholder face with an actual photo
   - Add a photo to Assets.xcassets
   - Update ContentView.swift to use Image() instead of RoundedRectangle

2. **Change Pimple Colors**: Modify the pimple colors in `PimpleView.swift`

3. **Add More Messages**: Edit the `funnyMessages` array in `PimpleViewModel.swift`

4. **Adjust Pimple Count**: Change the count in `addRandomPimples(count:)` method

## 📱 Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+

## 🎯 App Structure

- `PopPimpleApp.swift`: Main app entry point
- `ContentView.swift`: Main UI with face and controls
- `VideoPlayerView.swift`: Video player for pimple pop intro video
- `PimpleViewModel.swift`: Game logic and state management
- `PimpleView.swift`: Individual pimple view with pop animations

## 🎉 Have Fun!

This is meant to be a fun prank app. Share it with your girlfriend and let her pop away! 😄

---

Built with ❤️ and SwiftUI

