# 🚀 CodeMagic CI/CD Pipeline for Flutter App

This repository contains a complete CodeMagic CI/CD pipeline configuration for building and publishing your Flutter app to Google Play Store and App Store.

## 📋 Overview

The CI/CD pipeline includes multiple build profiles:

- **Development Build**: APK builds for testing (triggered by `develop` and `feature/*` branches)
- **Staging Build**: AAB builds for internal testing (triggered by `staging` branch)
- **Production Build**: Production-ready AAB builds with Play Store publishing (triggered by `main`/`master` branch)
- **Manual Build**: On-demand builds with both APK and AAB outputs
- **iOS Build**: iOS app builds with TestFlight distribution
- **Multi-Platform Build**: Combined Android and iOS builds for releases

## 🏗️ Project Structure

```
├── codemagic.yaml                 # Main CI/CD configuration
├── CODEMAGIC_SETUP.md            # Detailed setup instructions
├── README_CICD.md                # This file
├── scripts/
│   ├── version_bump.sh           # Version management script
│   ├── build_local.sh            # Local build script
│   ├── setup_codemagic.sh        # Setup validation script (Linux/Mac)
│   └── setup_codemagic.ps1       # Setup validation script (Windows)
├── android/
│   ├── key.properties            # Android signing configuration
│   └── fastlane/
│       ├── Fastfile              # Fastlane automation
│       ├── Appfile               # App configuration
│       └── metadata/             # Play Store metadata
└── ios/                          # iOS project files
```

## 🚀 Quick Start

### 1. Prerequisites
- CodeMagic account ([codemagic.io](https://codemagic.io))
- Google Play Console account
- Apple Developer account (for iOS)
- GitHub repository

### 2. Setup Validation
Run the setup validation script:

**Windows:**
```powershell
.\scripts\setup_codemagic.ps1
```

**Linux/Mac:**
```bash
chmod +x scripts/*.sh
./scripts/setup_codemagic.sh
```

### 3. Configure Environment Variables
See `CODEMAGIC_SETUP.md` for detailed instructions on setting up:
- Android keystore
- Google Play service account
- App Store Connect API keys
- Environment variables

### 4. Trigger Builds
- Push to `develop` → Development build
- Push to `staging` → Staging build with internal testing
- Push to `main` → Production build with Play Store publishing
- Manual trigger → Custom build with both APK and AAB

## 🔧 Build Profiles

### Development Build
```yaml
Trigger: Push to develop, feature/* branches
Output: Debug + Release APK
Publishing: Email notifications
Duration: ~15-20 minutes
```

### Staging Build
```yaml
Trigger: Push to staging branch
Output: Release AAB
Publishing: Google Play Internal Testing
Duration: ~20-25 minutes
```

### Production Build
```yaml
Trigger: Push to main/master, version tags
Output: Obfuscated AAB + APK
Publishing: Google Play Production (10% rollout)
Duration: ~25-30 minutes
```

### iOS Build
```yaml
Trigger: Push to main, ios/* branches
Output: IPA file
Publishing: TestFlight
Duration: ~30-40 minutes
```

## 📱 Build Commands

### Local Development
```bash
# Build APK for testing
./scripts/build_local.sh apk debug

# Build release AAB
./scripts/build_local.sh aab release

# Build iOS app
./scripts/build_local.sh ios release
```

### Version Management
```bash
# Bump patch version (5.4.0 → 5.4.1)
./scripts/version_bump.sh patch

# Bump minor version (5.4.0 → 5.5.0)
./scripts/version_bump.sh minor

# Bump major version (5.4.0 → 6.0.0)
./scripts/version_bump.sh major
```

## 🔐 Security Configuration

### Required Secrets
- `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS`: Google Play service account JSON
- `KEYSTORE_PASSWORD`: Android keystore password
- `KEY_ALIAS`: Android key alias
- `KEY_PASSWORD`: Android key password
- `APP_STORE_CONNECT_*`: iOS App Store Connect API credentials

### Environment Groups
- `google_play`: Android publishing credentials
- `app_store_credentials`: iOS publishing credentials

## 📊 Build Artifacts

Each build produces:
- **APK/AAB files**: Installable app packages
- **Mapping files**: For crash reporting and debugging
- **Symbol files**: For obfuscated builds
- **Build logs**: Detailed build information

## 🔄 Workflow Triggers

| Branch/Tag Pattern | Workflow | Output | Publishing |
|-------------------|----------|---------|------------|
| `develop`, `feature/*` | Development | APK | Email |
| `staging` | Staging | AAB | Internal Testing |
| `main`, `master` | Production | AAB + APK | Play Store |
| `v*` tags | Production | AAB + APK | Play Store |
| `ios/*` | iOS | IPA | TestFlight |
| `release-*` tags | Multi-Platform | AAB + IPA | Both Stores |

## 🛠️ Customization

### Modify Build Configuration
Edit `codemagic.yaml` to:
- Change trigger patterns
- Modify build commands
- Update publishing settings
- Add new workflows

### Update App Metadata
Edit files in `android/fastlane/metadata/` to update:
- App title and description
- Screenshots and graphics
- Release notes
- Store listing information

### Environment Variables
Add new variables in CodeMagic dashboard:
1. Go to App Settings → Environment variables
2. Add to appropriate environment group
3. Reference in `codemagic.yaml`

## 📈 Monitoring and Notifications

### Email Notifications
Configure in each workflow's `publishing` section:
```yaml
email:
  recipients:
    - developer@yourcompany.com
    - qa@yourcompany.com
  notify:
    success: true
    failure: true
```

### Slack Integration
Add Slack webhook for build notifications:
```yaml
slack:
  channel: '#mobile-builds'
  notify_on_build_start: true
  notify:
    success: true
    failure: true
```

## 🐛 Troubleshooting

### Common Issues

1. **Build Failures**
   - Check Flutter/Dart version compatibility
   - Verify all dependencies are properly configured
   - Review build logs for specific errors

2. **Signing Issues**
   - Ensure keystore is uploaded to CodeMagic
   - Verify key.properties file exists
   - Check signing configuration in build.gradle.kts

3. **Publishing Failures**
   - Verify Google Play service account permissions
   - Check App Store Connect API key validity
   - Ensure app is properly configured in stores

### Debug Commands
```bash
# Validate project structure
./scripts/setup_codemagic.sh

# Test local build
./scripts/build_local.sh apk debug

# Check Flutter configuration
flutter doctor -v
flutter analyze
flutter test
```

## 📚 Additional Resources

- [CodeMagic Documentation](https://docs.codemagic.io)
- [Flutter CI/CD Best Practices](https://flutter.dev/docs/deployment/cd)
- [Google Play Publishing Guide](https://developer.android.com/distribute/googleplay)
- [App Store Connect Guide](https://developer.apple.com/app-store-connect/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the CI/CD pipeline
5. Submit a pull request

## 📄 License

This CI/CD configuration is provided as-is for educational and development purposes.

---

**Need Help?** Check `CODEMAGIC_SETUP.md` for detailed setup instructions or contact your development team.
