# Xcode & App Store Connect Setup Guide 🚀

This guide will walk you through setting up your iOS app in Xcode and preparing it for the App Store.

## Part 1: Setting Up Xcode

### Step 1: Open the Project

1. Open Terminal and navigate to the project:
   ```bash
   cd ~/Desktop/hundred-app
   ```

2. Open the Xcode project:
   ```bash
   open SquishMyGirlfriend/SquishMyGirlfriend.xcodeproj
   ```

### Step 2: Configure Your Apple Developer Account

1. Open Xcode → **Settings** (Cmd + ,)
2. Click **"Accounts"** tab
3. Click **"+"** at bottom left
4. Select **"Apple ID"**
5. Sign in with your Apple ID
6. Your account will appear in the list

> **Note**: You need an Apple Developer Program membership ($99/year) to publish apps to the App Store.

### Step 3: Configure Project Settings

1. In Xcode, click on the **blue project icon** in the left sidebar

2. Under **"TARGETS"**, select **"SquishMyGirlfriend"**

3. In the **"General"** tab:

   **Display Name:**
   - Change to your preferred app name (shown under icon on device)
   - Example: "Squish My GF 💕"

   **Bundle Identifier:**
   - Click on the current identifier: `com.yourcompany.SquishMyGirlfriend`
   - Change to: `com.YOUR_NAME.SquishMyGirlfriend`
   - Example: `com.john.SquishMyGirlfriend`
   - This must be unique across the App Store

   **Version:**
   - Keep as `1.0` for first release
   - Increment for updates (1.1, 1.2, etc.)

   **Build:**
   - Keep as `1` for first submission
   - Increment each time you upload to App Store Connect

   **Minimum Deployments:**
   - iOS: `15.0` (already set)

4. In the **"Signing & Capabilities"** tab:

   - Check **"Automatically manage signing"**
   - Select your **Team** from dropdown (your Apple Developer account)
   - Xcode will automatically create provisioning profiles

### Step 4: Add App Icon

You need to create app icons in multiple sizes. Here's how:

1. **Create Your Icon Design:**
   - Design a 1024x1024 pixel icon
   - Should be simple, recognizable, and cute
   - No transparency allowed
   - Square with rounded corners (iOS adds these automatically)

2. **Generate All Required Sizes:**

   Option A - Use Online Tool (Easiest):
   - Visit [AppIcon.co](https://appicon.co) or [MakeAppIcon](https://makeappicon.com)
   - Upload your 1024x1024 image
   - Download the generated icon set
   - Drag all icons into Xcode's AppIcon.appiconset

   Option B - Manual in Xcode:
   - In Xcode, click on **Assets.xcassets** in left sidebar
   - Click on **AppIcon**
   - Drag your 1024x1024 icon into the "App Store iOS 1024pt" slot
   - For other sizes, you'll need to create/resize manually

### Step 5: Test Your App

1. **Choose a Simulator:**
   - At the top of Xcode, click the device dropdown
   - Select "iPhone 15 Pro" or another simulator

2. **Run the App:**
   - Press **Cmd + R** or click the Play button
   - App will build and launch in simulator
   - Test all functionality:
     - Tap and hold to squish
     - Check hearts animation
     - Verify counter increases
     - Test reset button

3. **Test on Physical Device:**
   - Connect your iPhone via USB
   - Select your device from the dropdown
   - Press **Cmd + R**
   - App will install and launch on your device

### Step 6: Fix Any Issues

Common issues and solutions:

**"Failed to register bundle identifier"**
- Your bundle ID is already taken
- Change to a different bundle identifier

**"Signing requires a development team"**
- Select your team in Signing & Capabilities tab

**"No such module SwiftUI"**
- Check deployment target is iOS 15.0 or later

## Part 2: Creating App Store Connect Record

### Step 1: Log Into App Store Connect

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Sign in with your Apple Developer account
3. Click **"My Apps"**

### Step 2: Create New App

1. Click the **"+"** button → **"New App"**

2. Fill in the form:

   **Platforms:** ☑️ iOS
   
   **Name:** `Squish My Girlfriend` (or your chosen name)
   - This is the name users see on the App Store
   - Can be different from display name in Xcode
   - 30 character limit
   
   **Primary Language:** `English (U.S.)`
   
   **Bundle ID:** Select the bundle ID you created in Xcode
   - Should match exactly: `com.YOUR_NAME.SquishMyGirlfriend`
   
   **SKU:** `SQUISH-GF-001` (or any unique identifier)
   - Internal use only, users won't see this
   - Can be any format you prefer
   
   **User Access:** Full Access (default)

3. Click **"Create"**

### Step 3: Fill Out App Information

#### General Information

1. Click **"App Information"** in left sidebar

2. Fill in required fields:

   **Subtitle:** (optional, 30 chars)
   - `Your adorable virtual companion 💕`

   **Category:**
   - Primary: `Entertainment`
   - Secondary: Leave blank or choose `Lifestyle`

   **Content Rights:**
   - Check: ☑️ "I own the rights to all content"

   **Age Rating:**
   - Click "Edit"
   - Answer questionnaire (all "No" for this app)
   - Rating will be "4+"

#### Pricing and Availability

1. Click **"Pricing and Availability"** in left sidebar

2. **Price Schedule:**
   - Select "Free" (recommended for first app)
   - Or set a price tier if you want to charge

3. **Availability:**
   - Select all countries or choose specific ones
   - Use default "Available from the moment your app is approved"

#### App Privacy

1. Click **"App Privacy"** in left sidebar

2. Click **"Get Started"**

3. **Privacy Policy:**
   - This app doesn't collect data, so you can use a simple policy
   - You can generate one at [privacypolicygenerator.info](https://www.privacypolicygenerator.info)
   - Host on a website (GitHub Pages, your website, etc.)
   - Enter the URL

4. **Data Collection:**
   - "Does this app collect data from users?" → **No**
   - Click "Save"

### Step 4: Prepare App Store Listing

1. Click **"App Store"** → **"iOS App"** in left sidebar

2. Click **"1.0 Prepare for Submission"**

#### Screenshots (Required)

You need screenshots for at least one device size:

**iPhone 6.7" Display** (iPhone 15 Pro Max, 14 Pro Max, etc.):
- Size: 1290 x 2796 pixels
- Required: 3-10 screenshots

How to capture:
1. Run app in simulator (iPhone 15 Pro Max)
2. Cmd + S to save screenshot
3. Screenshots save to Desktop
4. Drag into App Store Connect

**Recommended Screenshots:**
1. Main screen with character
2. Character being squished
3. Love level bar filled up
4. Stats screen showing high numbers

#### App Previews (Optional but recommended)

- Video showing app in action (15-30 seconds)
- Same sizes as screenshots
- Use screen recording software

#### Promotional Text (Optional, 170 chars)

```
Tap and hold to squish the cutest character ever! 
Watch hearts float, track your squishes, and enjoy adorable messages. 
The perfect stress-relief companion! 🥰
```

#### Description (Required, up to 4000 chars)

```
Squish My Girlfriend - The Cutest Stress Relief App! 💕

Need a cute way to relax and have fun? Meet your adorable virtual companion who loves to be squished! Simply tap and hold to squish the character and watch the delightful animations come to life.

✨ FEATURES ✨

🥰 Interactive Squishing
Tap and hold the adorable character to see smooth, satisfying squish animations. The more you squish, the more love you spread!

💗 Floating Hearts
Watch cute hearts float up every time you squish. Each interaction fills the screen with love!

📊 Squish Counter
Keep track of how many times you've squished your virtual companion. Can you reach 100 squishes? 1000?

💖 Love Level Bar
See your love level grow with each squish. Fill up the bar to max out your affection!

😊 Cute Messages
Receive random loving messages with each squish. Every interaction is different and adorable!

🎨 Beautiful Design
Enjoy a stunning pink gradient interface with smooth animations and a delightful user experience.

🌟 WHY YOU'LL LOVE IT 🌟

• Perfect for stress relief after a long day
• Great boredom buster
• Show affection in a fun way
• Simple and intuitive
• No ads, no interruptions
• Works offline
• Suitable for all ages

💝 PERFECT FOR 💝

- Couples looking for a cute way to connect
- Anyone who loves kawaii and cute things
- Stress relief and relaxation
- Quick fun during breaks
- Gift for your girlfriend or boyfriend
- Kids who love cute characters

The app is completely free with no in-app purchases or ads. Just pure, wholesome squishing fun!

Download now and start spreading the love! Your adorable virtual companion is waiting to be squished! 🥰✨

Got feedback? We'd love to hear from you! Contact us at [your-email]
```

#### Keywords (Required, 100 chars max)

```
cute,squish,fun,relax,stress relief,kawaii,girlfriend,adorable,love,hearts,entertainment,casual
```

#### Support URL (Required)

- Your website, GitHub repo, or support email
- Example: `https://github.com/yourusername/hundred-app`

#### Marketing URL (Optional)

- Your app's landing page if you have one

### Step 5: Build and Upload from Xcode

#### Create Archive

1. In Xcode, select target device:
   - Click device dropdown at top
   - Select **"Any iOS Device (arm64)"**

2. Create archive:
   - Menu: **Product** → **Archive**
   - Xcode will build your app (may take a few minutes)
   - Archive will appear in Organizer window

#### Validate Archive (Optional but recommended)

1. In Organizer window, select your archive
2. Click **"Validate App"**
3. Choose automatic signing
4. Click **"Validate"**
5. Wait for validation (checks for common issues)
6. Fix any errors that appear

#### Upload to App Store Connect

1. In Organizer, click **"Distribute App"**

2. Select distribution method:
   - Choose **"App Store Connect"**
   - Click **"Next"**

3. Select destination:
   - Choose **"Upload"**
   - Click **"Next"**

4. Distribution options:
   - Keep all defaults
   - Click **"Next"**

5. Signing:
   - Choose **"Automatically manage signing"**
   - Click **"Next"**

6. Review and upload:
   - Review summary
   - Click **"Upload"**
   - Wait for upload to complete

7. Success!
   - You'll see "Upload Successful"
   - Click **"Done"**

### Step 6: Select Build in App Store Connect

1. Go back to App Store Connect in your browser

2. Refresh the page or click **"App Store"** → **"iOS App"**

3. Under **"Build"**:
   - Wait 5-30 minutes for build to process
   - Refresh page periodically
   - Once processed, click **"+"** button
   - Select your build
   - Click **"Done"**

4. Fill in **"What's New in This Version"** (required):
   ```
   Welcome to Squish My Girlfriend! 🥰
   
   • Adorable squishable character
   • Fun animations and effects
   • Track your squishes
   • Cute messages with every squish
   • Beautiful pink-themed design
   
   Enjoy spreading the love! 💕
   ```

### Step 7: Submit for Review

1. Review all information:
   - ✓ Screenshots uploaded
   - ✓ Description filled out
   - ✓ Build selected
   - ✓ Privacy policy URL added
   - ✓ Support URL added

2. Click **"Add for Review"** (top right)

3. Answer additional questions:

   **Export Compliance:**
   - "Is your app designed to use cryptography?"
   - Select **"No"** (for this simple app)

   **Advertising Identifier:**
   - "Does this app use the Advertising Identifier?"
   - Select **"No"**

4. Click **"Submit to App Review"**

### Step 8: Wait for Review

- **Review Time:** Usually 24-48 hours
- **Status:** Check in App Store Connect
- **Notifications:** You'll receive emails about status changes

**Possible Outcomes:**

1. **Approved** ✅
   - App goes live on App Store automatically (or at scheduled time)
   - You'll receive congratulations email!

2. **Rejected** ❌
   - Read rejection reason carefully
   - Fix the issues mentioned
   - Resubmit (no additional fee)

Common rejection reasons:
- Missing features or not working as described
- Crashes or bugs
- Incomplete information
- Privacy policy issues

## Part 3: After Approval

### Your App is Live! 🎉

1. **Find your app:**
   - Search App Store for your app name
   - Share the link with friends

2. **Monitor Performance:**
   - Check App Store Connect for:
     - Download statistics
     - Crash reports
     - User reviews

3. **Respond to Reviews:**
   - Reply to user feedback
   - Build community around your app

### Updating Your App

When you want to release an update:

1. **In Xcode:**
   - Make your changes
   - Increment version number (1.0 → 1.1)
   - Increment build number (1 → 2)
   - Archive and upload

2. **In App Store Connect:**
   - Click **"+"** → **"iOS"**
   - Add version number (e.g., 1.1)
   - Describe what's new
   - Select new build
   - Submit for review

## Troubleshooting

### Common Xcode Issues

**"No such file or directory"**
- Clean build folder: Cmd + Shift + K
- Rebuild: Cmd + B

**"Code signing error"**
- Check team selection in Signing & Capabilities
- Try toggling "Automatically manage signing" off and on

**"Build failed"**
- Read error message carefully
- Check for syntax errors in code

### Common App Store Connect Issues

**"Invalid Bundle ID"**
- Bundle ID doesn't match between Xcode and App Store Connect
- Create new bundle ID or fix existing one

**"Missing Compliance Information"**
- Answer export compliance questions
- Usually "No" for simple apps

**"Missing Required Icon"**
- Ensure all icon sizes are provided in Assets.xcassets

## Next Steps

### Marketing Your App

1. **Create a Landing Page:**
   - Use Carrd.co, Wix, or GitHub Pages
   - Include screenshots and description
   - Add download button

2. **Social Media:**
   - Share on Instagram, Twitter, TikTok
   - Use hashtags: #iOSApp #CuteApp #AppStore

3. **Ask for Reviews:**
   - Encourage users to leave positive reviews
   - Respond to feedback

### Monetization (Future)

If you want to add monetization later:

1. **In-App Purchases:**
   - Add premium themes
   - Unlock new characters
   - Remove ads

2. **Ads:**
   - Integrate AdMob or similar
   - Show interstitial ads occasionally

3. **Subscription:**
   - Monthly/yearly access to premium features

## Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)

## Questions?

If you get stuck:

1. Check error messages carefully
2. Search Stack Overflow
3. Visit Apple Developer Forums
4. Contact Apple Developer Support

---

Good luck with your app! 🚀💕

Remember: Everyone's first app submission can be nerve-wracking, but you've got this! Take it step by step, and don't hesitate to reach out to the Apple Developer community if you need help.

