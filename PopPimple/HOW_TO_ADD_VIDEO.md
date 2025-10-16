# 🎥 How to Add Your Pimple Pop Video

Follow these simple steps to add your 5-second pimple popping video to the app:

## Step 1: Prepare Your Video

1. **Name your video file**: `pimple_pop.mp4`
2. **Recommended specs**:
   - Duration: ~5 seconds
   - Format: MP4 (H.264)
   - Resolution: 1080p or 720p (iPhone native is fine)
   - File size: Keep it under 10MB for best performance

## Step 2: Add Video to Xcode

### Method A: Using Xcode (Easier)

1. **Open your project** in Xcode:
   ```bash
   open PopPimple.xcodeproj
   ```

2. **In Xcode's left sidebar** (Project Navigator), locate the `PopPimple` folder

3. **Right-click** on the `PopPimple` folder and select **"Add Files to PopPimple..."**

4. **Navigate** to where your `pimple_pop.mp4` video is saved

5. **IMPORTANT**: Check these boxes:
   - ✅ **"Copy items if needed"** (This copies the video into your project)
   - ✅ **"Add to targets: PopPimple"** (Makes it available to the app)

6. Click **"Add"**

### Method B: Using Finder (Alternative)

1. **Drag and drop** your `pimple_pop.mp4` file directly into:
   ```
   /Users/lifuzhang/Desktop/hundred-app/PopPimple/PopPimple/
   ```

2. **Open Xcode** and the project should automatically detect it

3. **If not detected**: Use Method A above to add it manually

## Step 3: Verify It's Added

1. In Xcode, check the **Project Navigator** (left sidebar)
2. You should see `pimple_pop.mp4` listed with your other files
3. Click on it to verify it's there

## Step 4: Build and Run!

1. **Clean the build**: Press `Shift + Cmd + K`
2. **Build and run**: Press `Cmd + R`
3. **Test it**: Tap "LET'S POP! 😈" and your video should play!

## How It Works:

1. **User taps "LET'S POP!"** → Video starts playing fullscreen
2. **Video plays** for ~5 seconds (or user can skip with "Skip" button)
3. **Video ends** → Automatically transitions to the interactive pimple game
4. **User pops pimples** → Fun and satisfying!

## Troubleshooting:

### Video doesn't play?
- Make sure the file is named exactly `pimple_pop.mp4` (case sensitive!)
- Verify the video was added to the target (see Method A, step 5)
- Check that the video format is MP4 (not MOV or other formats)

### Video is too large?
- Compress it using:
  - Mac: QuickTime Player → Export As → Reduce file size
  - Online: HandBrake or similar tools
  - Target: Under 10MB

### Want to use a different filename?
- Edit `ContentView.swift`, line 16:
  ```swift
  VideoPlayerView(videoName: "your_filename_here", onFinish: { ...
  ```
  (Don't include the .mp4 extension)

### Want to test without video?
- The app will automatically skip the video if it's not found
- It will go straight to the pimple popping game

## Optional Enhancements:

Want to make it even better? You can:
- Add multiple videos and play a random one
- Add sound effects when pimples pop
- Change the video player background color
- Add a replay button after the video ends

---

Enjoy your pimple popping prank app! 🤮😄

