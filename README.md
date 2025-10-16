# Squish My Girlfriend 💕

A cute iOS app that lets you squish an adorable character with fun animations and interactions!

## Features

- 🥰 **Interactive Squishing**: Tap and hold the character to see it squish with adorable animations
- 💗 **Floating Hearts**: Hearts float up when you squish
- 📊 **Squish Counter**: Tracks how many times you've squished today
- 💖 **Love Level Bar**: Increases with each squish
- 😊 **Cute Messages**: Random loving messages appear with each squish
- 🎨 **Beautiful UI**: Pink gradient background with smooth animations

## Requirements

- Xcode 15.0 or later
- iOS 15.0 or later
- Swift 5.0 or later
- macOS for development

## Getting Started

### Opening the Project

1. Navigate to the project directory:
   ```bash
   cd hundred-app
   ```

2. Open the Xcode project:
   ```bash
   open SquishMyGirlfriend/SquishMyGirlfriend.xcodeproj
   ```

### Running the App

1. Select your target device or simulator in Xcode
2. Press `Cmd + R` or click the Run button
3. The app will build and launch on your selected device/simulator

### Before Submitting to App Store

You'll need to update the following:

1. **Bundle Identifier**: 
   - Go to Project Settings → General → Bundle Identifier
   - Change from `com.yourcompany.SquishMyGirlfriend` to your own identifier
   - Example: `com.yourname.SquishMyGirlfriend`

2. **Development Team**:
   - In Xcode, go to Project Settings → Signing & Capabilities
   - Select your development team from the dropdown

3. **App Icons**:
   - Create app icons in various sizes (see Assets.xcassets/AppIcon.appiconset/)
   - Required sizes: 20x20, 29x29, 40x40, 60x60, 76x76, 83.5x83.5, 1024x1024
   - Use a design tool or service like AppIcon.co to generate all sizes
   - Drag and drop icons into the AppIcon.appiconset in Xcode

4. **Privacy Policy** (required for App Store):
   - Create a privacy policy if your app collects any data
   - Add the URL in App Store Connect

## App Store Connect Setup

### Creating an App Record

1. Log in to [App Store Connect](https://appstoreconnect.apple.com)

2. Click **"My Apps"** → **"+"** → **"New App"**

3. Fill in the app information:
   - **Platforms**: iOS
   - **Name**: Squish My Girlfriend (or your preferred name)
   - **Primary Language**: English
   - **Bundle ID**: Select the bundle ID you configured in Xcode
   - **SKU**: Create a unique identifier (e.g., SQUISH-GF-001)

4. **App Information**:
   - Category: Entertainment or Games
   - Subcategory: (optional)
   - Content Rights: Specify if you have rights to all content

5. **Pricing and Availability**:
   - Set as Free or Paid
   - Choose availability territories

6. **App Privacy**:
   - Fill out the privacy questionnaire
   - If app doesn't collect data, indicate "No, this app does not collect data"

### Preparing for Submission

1. **Screenshots** (Required):
   - iPhone 6.7" Display: 1290 x 2796 pixels
   - iPhone 6.5" Display: 1242 x 2688 pixels
   - iPad Pro 12.9" (optional): 2048 x 2732 pixels
   - Take screenshots using Simulator or device

2. **App Preview Video** (Optional):
   - Create a short video showing app functionality
   - Upload to App Store Connect

3. **App Description**:
   ```
   Squish My Girlfriend - The Cutest Stress Relief App! 💕
   
   Need a cute way to relax and have fun? Meet your adorable virtual companion 
   who loves to be squished! Tap and hold to squish the character and watch 
   the delightful animations.
   
   Features:
   • Adorable squishable character with smooth animations
   • Floating hearts and cute messages
   • Track your squishes and love level
   • Beautiful pink gradient design
   • Simple and relaxing gameplay
   
   Perfect for:
   - Stress relief
   - Boredom busting  
   - Showing affection
   - Just having fun!
   
   Download now and start squishing! 🥰
   ```

4. **Keywords**:
   - cute, squish, fun, relaxing, stress relief, adorable, kawaii, girlfriend, 
     entertainment, casual

5. **Support URL**: Add your website or support email

6. **Marketing URL** (optional): Your app's landing page

### Building for Release

1. In Xcode, select **"Any iOS Device"** as the target

2. Go to **Product** → **Archive**

3. Once archived, click **"Distribute App"**

4. Select **"App Store Connect"**

5. Follow the prompts to upload to App Store Connect

6. In App Store Connect, select your build and submit for review

### Review Process

- Apple typically reviews apps within 24-48 hours
- You'll receive notifications about review status
- Address any feedback from Apple if app is rejected
- Once approved, the app will be available on the App Store

## Project Structure

```
SquishMyGirlfriend/
├── SquishMyGirlfriend.xcodeproj/     # Xcode project file
└── SquishMyGirlfriend/               # Source code
    ├── SquishMyGirlfriendApp.swift   # App entry point
    ├── ContentView.swift              # Main view
    ├── SquishCharacterView.swift      # Character view component
    ├── SquishViewModel.swift          # State management
    ├── Assets.xcassets/               # Images and colors
    └── Info.plist                     # App configuration
```

## Customization Ideas

- Change the character color scheme in `SquishCharacterView.swift`
- Add more cute messages in `SquishViewModel.swift`
- Modify squish animation parameters for different effects
- Add sound effects when squishing
- Implement haptic feedback
- Add different character styles or themes
- Save high scores or daily squish records
- Add achievements or milestones

## Testing Checklist

Before submitting to App Store:

- [ ] Test on multiple iOS devices (iPhone, iPad)
- [ ] Test on different iOS versions (15.0+)
- [ ] Test in both light and dark mode
- [ ] Verify all animations work smoothly
- [ ] Check that stats reset properly
- [ ] Ensure no crashes or memory leaks
- [ ] Test with VoiceOver for accessibility
- [ ] Verify app icon displays correctly
- [ ] Test launch screen appearance

## Troubleshooting

### Build Errors

- **"No such module 'SwiftUI'"**: Make sure deployment target is iOS 15.0+
- **Code signing errors**: Select your development team in project settings

### Simulator Issues

- If simulator is slow, try:
  - Using a newer device model
  - Restart Xcode
  - Clean build folder (Cmd + Shift + K)

## Contributing

Feel free to customize this app for your own use! Some ideas:
- Personalize messages for your girlfriend
- Change colors to her favorite colors
- Add her favorite emoji or symbols

## License

This project is open source. Feel free to use and modify as needed.

## Support

For questions or issues:
- Open an issue in the repository
- Contact: [your-email@example.com]

---

Made with 💕 for squishing fun!
