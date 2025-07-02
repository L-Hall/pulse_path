# Firebase Setup Instructions

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `pulse-path-hrv` (or your preferred name)
4. Enable/disable Google Analytics as needed
5. Choose your analytics location if enabled

## Step 2: Add Android App

1. In Firebase console, click "Add app" → Android
2. Enter package name: `com.example.pulse_path`
3. Enter app nickname: `PulsePath Android`
4. Download `google-services.json`
5. Copy `google-services.json` to `android/app/` directory (replace the template)

## Step 3: Add iOS App

1. In Firebase console, click "Add app" → iOS  
2. Enter bundle ID: `com.example.pulse_path`
3. Enter app nickname: `PulsePath iOS`
4. Download `GoogleService-Info.plist`
5. Copy `GoogleService-Info.plist` to `ios/Runner/` directory (replace the template)

## Step 4: Enable Authentication

1. In Firebase console, go to "Authentication" → "Sign-in method"
2. Enable "Email/Password" provider
3. Enable "Anonymous" provider (for offline-first experience)

## Step 5: Set up Firestore Database

1. Go to "Firestore Database" → "Create database"
2. Choose "Start in test mode" (we'll add security rules later)
3. Select your preferred region

## Step 6: Configure Security Rules

Replace the default Firestore rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only access their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // HRV readings subcollection
      match /hrv_readings/{readingId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      // Settings subcollection
      match /settings/{settingId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

## Next Steps

After completing these steps:
1. Remove the `.template` files
2. Run `flutter clean && flutter pub get`
3. The Firebase services will be automatically initialized
4. Test authentication and cloud sync functionality

## Important Security Notes

- Never commit actual Firebase config files to version control if they contain sensitive data
- Use environment variables for production builds
- Review and test Firestore security rules thoroughly
- Enable App Check for additional security in production