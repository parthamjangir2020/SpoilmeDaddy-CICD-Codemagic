#!/bin/bash

# CodeMagic Setup Helper Script
# This script helps prepare your project for CodeMagic CI/CD

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

print_info "CodeMagic Setup Helper"
print_info "======================"

# Check if we're in a Flutter project
if [ ! -f "pubspec.yaml" ]; then
    print_error "pubspec.yaml not found. Please run this script from the Flutter project root."
    exit 1
fi

# Check if codemagic.yaml exists
if [ ! -f "codemagic.yaml" ]; then
    print_error "codemagic.yaml not found. Please ensure the CI/CD configuration file exists."
    exit 1
fi

print_step "Validating project structure..."

# Check Android configuration
if [ ! -f "android/key.properties" ]; then
    print_warning "android/key.properties not found. You'll need to configure Android signing."
else
    print_info "✓ Android key.properties found"
fi

if [ ! -f "android/app/key.jks" ]; then
    print_warning "android/app/key.jks not found. You'll need to upload your keystore to CodeMagic."
else
    print_info "✓ Android keystore found"
fi

# Check if build.gradle.kts has signing config
if grep -q "signingConfigs" android/app/build.gradle.kts; then
    print_info "✓ Android signing configuration found in build.gradle.kts"
else
    print_warning "Android signing configuration not found in build.gradle.kts"
fi

# Check iOS configuration
if [ -d "ios" ]; then
    print_info "✓ iOS project found"
    if [ -f "ios/Runner.xcworkspace" ]; then
        print_info "✓ iOS workspace found"
    else
        print_warning "iOS workspace not found. Run 'cd ios && pod install' if using CocoaPods"
    fi
else
    print_warning "iOS project not found"
fi

# Check Fastlane configuration
if [ -f "android/fastlane/Fastfile" ]; then
    print_info "✓ Android Fastlane configuration found"
else
    print_warning "Android Fastlane configuration not found"
fi

# Validate codemagic.yaml
print_step "Validating codemagic.yaml..."

if grep -q "workflows:" codemagic.yaml; then
    print_info "✓ Workflows section found"
else
    print_error "Workflows section not found in codemagic.yaml"
fi

if grep -q "android_signing:" codemagic.yaml; then
    print_info "✓ Android signing configuration found"
else
    print_warning "Android signing configuration not found in codemagic.yaml"
fi

if grep -q "google_play:" codemagic.yaml; then
    print_info "✓ Google Play publishing configuration found"
else
    print_warning "Google Play publishing configuration not found in codemagic.yaml"
fi

# Check environment variables documentation
if [ -f "CODEMAGIC_SETUP.md" ]; then
    print_info "✓ Setup documentation found"
else
    print_warning "Setup documentation not found"
fi

print_step "Checking Flutter configuration..."

# Get current version
current_version=$(grep "^version:" pubspec.yaml | sed 's/version: //')
print_info "Current app version: $current_version"

# Check package name
package_name=$(grep "applicationId" android/app/build.gradle.kts | sed 's/.*= "//' | sed 's/"//')
print_info "Package name: $package_name"

print_step "Setup checklist:"
print_info "=================="

echo "Before using CodeMagic, ensure you have:"
echo "□ Created a CodeMagic account"
echo "□ Connected your GitHub repository"
echo "□ Uploaded Android keystore to CodeMagic"
echo "□ Created Google Play service account"
echo "□ Set up environment variables in CodeMagic"
echo "□ Configured email notifications"
echo ""

print_info "Environment variables needed:"
echo "• GCLOUD_SERVICE_ACCOUNT_CREDENTIALS"
echo "• KEYSTORE_PASSWORD"
echo "• KEY_ALIAS"
echo "• KEY_PASSWORD"
echo "• PACKAGE_NAME"
echo ""

print_info "For detailed setup instructions, see CODEMAGIC_SETUP.md"

print_step "Testing local build..."
if command -v flutter &> /dev/null; then
    print_info "Flutter found. Testing basic build..."
    flutter clean
    flutter pub get
    flutter analyze
    if flutter test; then
        print_info "✓ All tests passed"
    else
        print_warning "Some tests failed. Fix them before deploying."
    fi
else
    print_warning "Flutter not found. Install Flutter to test builds locally."
fi

print_info "Setup validation completed!"
print_info "Review the warnings above and follow CODEMAGIC_SETUP.md for detailed instructions."
