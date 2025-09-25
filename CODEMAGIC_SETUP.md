# CodeMagic CI/CD Setup Guide

This guide will help you set up CodeMagic CI/CD pipeline for your Flutter app with multiple build profiles and automatic publishing to Google Play Store.

## Prerequisites

1. **CodeMagic Account**: Sign up at [codemagic.io](https://codemagic.io)
2. **Google Play Console Account**: For publishing to Play Store
3. **Apple Developer Account**: For iOS builds (optional)
4. **GitHub Repository**: Your code should be pushed to GitHub

## Required Environment Variables and Secrets

### 1. Android Signing Configuration

#### Keystore Setup
1. Upload your `key.jks` file to CodeMagic:
   - Go to your app settings in CodeMagic
   - Navigate to "Code signing identities"
   - Upload your keystore file
   - Set the reference name as `keystore_reference`

#### Environment Variables for Android
```
KEYSTORE_PASSWORD=123456
KEY_ALIAS=key
KEY_PASSWORD=123456
PACKAGE_NAME=com.activeitzone.activeecommercecmsdemoapp
```

### 2. Google Play Store Configuration

#### Service Account Setup
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google Play Android Developer API
4. Create a service account:
   - Go to IAM & Admin > Service Accounts
   - Click "Create Service Account"
   - Download the JSON key file
5. In Google Play Console:
   - Go to Setup > API access
   - Link your Google Cloud project
   - Grant access to the service account

#### Environment Variables for Google Play
```
GCLOUD_SERVICE_ACCOUNT_CREDENTIALS=<content of your service account JSON file>
GOOGLE_PLAY_TRACK=internal|alpha|beta|production
```

### 3. iOS Configuration (Optional)

#### App Store Connect API
1. Go to [App Store Connect](https://appstoreconnect.apple.com/)
2. Navigate to Users and Access > Keys
3. Create a new API key with App Manager role
4. Download the .p8 file

#### Environment Variables for iOS
```
APP_STORE_CONNECT_ISSUER_ID=<your issuer ID>
APP_STORE_CONNECT_KEY_IDENTIFIER=<your key ID>
APP_STORE_CONNECT_PRIVATE_KEY=<content of your .p8 file>
APP_ID=<your app ID from App Store Connect>
```

## Environment Groups Setup

### 1. Create `google_play` Group
In CodeMagic dashboard:
1. Go to Teams > Your Team > Integrations
2. Create a new group called `google_play`
3. Add these variables:
   - `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS`
   - `KEYSTORE_PASSWORD`
   - `KEY_ALIAS`
   - `KEY_PASSWORD`

### 2. Create `app_store_credentials` Group (for iOS)
1. Create a new group called `app_store_credentials`
2. Add these variables:
   - `APP_STORE_CONNECT_ISSUER_ID`
   - `APP_STORE_CONNECT_KEY_IDENTIFIER`
   - `APP_STORE_CONNECT_PRIVATE_KEY`
   - `APP_ID`

## Build Profiles Explanation

### 1. Development Build (`development-build`)
- **Trigger**: Push to `develop` or `feature/*` branches
- **Output**: Debug and Release APK files
- **Purpose**: Testing and development
- **Publishing**: Email notifications only

### 2. Staging Build (`staging-build`)
- **Trigger**: Push to `staging` branch
- **Output**: Release AAB file
- **Purpose**: Internal testing
- **Publishing**: Google Play Internal Testing track

### 3. Production Build (`production-build`)
- **Trigger**: Push to `main`/`master` branch or version tags
- **Output**: Release AAB and APK files (obfuscated)
- **Purpose**: Production release
- **Publishing**: Google Play Production track (10% rollout)

### 4. Manual Build (`manual-build`)
- **Trigger**: Manual trigger from CodeMagic dashboard
- **Output**: Both APK and AAB files
- **Purpose**: On-demand builds
- **Publishing**: Email notifications only

### 5. iOS Build (`ios-build`)
- **Trigger**: Push to `main` or `ios/*` branches
- **Output**: IPA file
- **Purpose**: iOS app distribution
- **Publishing**: TestFlight

## Setup Instructions

### Step 1: Connect Repository
1. Log in to CodeMagic
2. Click "Add application"
3. Connect your GitHub repository
4. Select your Flutter project

### Step 2: Configure Environment Variables
1. Go to App Settings > Environment variables
2. Create the environment groups mentioned above
3. Add all required variables to respective groups

### Step 3: Upload Signing Certificates
1. Go to App Settings > Code signing identities
2. Upload your Android keystore file
3. Upload iOS certificates and provisioning profiles (if building iOS)

### Step 4: Configure Workflows
1. The `codemagic.yaml` file in your repository root will be automatically detected
2. Review and customize the workflows as needed
3. Update email recipients in the publishing sections

### Step 5: Test the Pipeline
1. Push code to the `develop` branch to trigger development build
2. Check build logs and artifacts
3. Verify email notifications are received

## Troubleshooting

### Common Issues

1. **Keystore not found**
   - Ensure keystore file is uploaded with correct reference name
   - Check that `key.properties` file exists in `android/` directory

2. **Google Play API errors**
   - Verify service account has proper permissions
   - Ensure Google Play Android Developer API is enabled
   - Check that the service account is linked in Google Play Console

3. **Build failures**
   - Check Flutter and Dart versions compatibility
   - Ensure all dependencies are properly configured
   - Review build logs for specific error messages

4. **iOS signing issues**
   - Verify certificates are not expired
   - Check provisioning profiles match bundle identifier
   - Ensure App Store Connect API key has proper permissions

### Support

For additional support:
- CodeMagic Documentation: [docs.codemagic.io](https://docs.codemagic.io)
- Flutter Documentation: [flutter.dev](https://flutter.dev)
- Google Play Console Help: [support.google.com/googleplay](https://support.google.com/googleplay)

## Security Notes

- Never commit sensitive information like passwords or API keys to your repository
- Use CodeMagic's secure environment variables for all secrets
- Regularly rotate API keys and certificates
- Monitor build logs for any exposed sensitive information
