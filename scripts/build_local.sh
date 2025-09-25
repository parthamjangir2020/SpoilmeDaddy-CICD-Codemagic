#!/bin/bash

# Local Build Script for Flutter App
# Usage: ./scripts/build_local.sh [apk|aab|ios] [debug|release]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Default values
build_type=${1:-apk}
build_mode=${2:-release}

print_info "Starting Flutter build process..."
print_info "Build type: $build_type"
print_info "Build mode: $build_mode"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

# Check if we're in a Flutter project
if [ ! -f "pubspec.yaml" ]; then
    print_error "pubspec.yaml not found. Please run this script from the Flutter project root."
    exit 1
fi

# Clean previous builds
print_step "Cleaning previous builds..."
flutter clean

# Get dependencies
print_step "Getting Flutter dependencies..."
flutter pub get

# Run code analysis
print_step "Running Flutter analyze..."
flutter analyze

# Run tests
print_step "Running Flutter tests..."
flutter test

# Get current version
current_version=$(grep "^version:" pubspec.yaml | sed 's/version: //')
print_info "Building version: $current_version"

# Build based on type
case $build_type in
    apk)
        print_step "Building APK ($build_mode mode)..."
        if [ "$build_mode" = "debug" ]; then
            flutter build apk --debug
        else
            flutter build apk --release
        fi
        print_info "APK build completed!"
        print_info "Output: build/app/outputs/flutter-apk/app-$build_mode.apk"
        ;;
    aab)
        print_step "Building App Bundle ($build_mode mode)..."
        if [ "$build_mode" = "debug" ]; then
            print_warning "Debug mode not supported for App Bundle. Building release instead."
            flutter build appbundle --release
        else
            flutter build appbundle --release
        fi
        print_info "App Bundle build completed!"
        print_info "Output: build/app/outputs/bundle/release/app-release.aab"
        ;;
    ios)
        print_step "Building iOS app ($build_mode mode)..."
        if [ "$build_mode" = "debug" ]; then
            flutter build ios --debug --no-codesign
        else
            flutter build ios --release --no-codesign
        fi
        print_info "iOS build completed!"
        print_info "Output: build/ios/iphoneos/Runner.app"
        ;;
    ipa)
        print_step "Building IPA ($build_mode mode)..."
        if [ "$build_mode" = "debug" ]; then
            print_warning "Debug mode not supported for IPA. Building release instead."
            flutter build ipa --release
        else
            flutter build ipa --release
        fi
        print_info "IPA build completed!"
        print_info "Output: build/ios/ipa/*.ipa"
        ;;
    *)
        print_error "Invalid build type. Use: apk, aab, ios, or ipa"
        exit 1
        ;;
esac

print_info "Build process completed successfully!"

# Show build artifacts
print_step "Build artifacts:"
case $build_type in
    apk)
        ls -la build/app/outputs/flutter-apk/
        ;;
    aab)
        ls -la build/app/outputs/bundle/release/
        ;;
    ios)
        ls -la build/ios/iphoneos/
        ;;
    ipa)
        ls -la build/ios/ipa/
        ;;
esac
