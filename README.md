🍎 Calorize
![alt text](https://img.shields.io/badge/Platform-Android-3DDC84?style=flat&logo=android&logoColor=white)

![alt text](https://img.shields.io/badge/Built%20with-Flutter-02569B?style=flat&logo=flutter&logoColor=white)

![alt text](https://img.shields.io/badge/License-CC_BY--NC_4.0-lightgrey?style=flat)
The intelligent, privacy-first nutrition tracker.
Snap a photo, scan a barcode, or log manually—all without your health data leaving your device.
✨ Features
👁️ AI Food Analysis: Snap a photo of your meal. Calorize uses Google Gemini 2.5 to identify ingredients, estimate portion sizes, and calculate calories instantly.
🔒 Privacy First: No servers. No accounts. All data is stored locally on your device. Your health data belongs to you.
📷 Barcode Scanner: Instant nutritional data for packaged goods via OpenFoodFacts.
📊 Deep Analytics: Interactive charts for weight, BMI, and calorie trends.
🔄 Rolling History: Detailed food logs are kept for 7 days, while long-term stats are saved forever.
📱 Home Screen Widgets: View your remaining calories and macros at a glance.
⏰ Smart Reminders: Never forget to log Breakfast, Lunch, or Dinner.
📲 How to Install (Android)
Since Calorize is open-source and privacy-focused, it is not on the Play Store. You can install it directly on your phone.
1. Download the APK
Go to the Releases page on this repository and download the latest app-release.apk file to your phone.
2. Install
Open the file. Your phone will likely warn you about installing unknown apps.
Tap Settings (on the popup).
Toggle "Allow from this source".
Tap Install.
3. ⚠️ Important: Enable Alarms & Notifications
Because this app is installed manually, Android restricts some permissions by default. To make sure Daily Reminders work:
Open Calorize and go to Settings.
Tap "Open Settings to Fix" (under Notifications) or go to your phone's Settings > Apps > Calorize.
Tap Alarms & Reminders → Turn ON.
(Optional but recommended) Tap Battery → Set to Unrestricted.
🚀 How to Use
Onboarding: Enter your height, weight, and goals. The app calculates your daily calorie budget automatically.
Log Food:
Tap the big + button.
Snap: Take a picture of your food. AI will estimate the calories.
Scan: Scan a barcode on a package.
Manual: Type it in yourself.
Track Progress: Swipe to the Progress tab to see your weight trends and weekly calorie averages.
Widgets: Long-press your home screen to add the Calorize widget for quick access.
🛠️ Building from Source (For Developers)
If you want to modify the code or build it yourself:
Clone the repo: git clone https://github.com/yourusername/calorize.git
Add your Gemini API Key to android/local.properties:
code
Properties
GEMINI_API_KEY=AIzaSy...
Run code generation: dart run build_runner build --delete-conflicting-outputs
Build: flutter run --release
⚖️ License
Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
✅ Free to use: You can download, use, and modify this app for personal use.
❌ No Commercial Use: You cannot sell this app, use it for paid services, or monetize it without permission.
See the LICENSE file for details.
