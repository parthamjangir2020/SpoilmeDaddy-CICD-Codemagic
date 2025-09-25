#!/bin/bash

# Version Bump Script for Flutter App
# Usage: ./scripts/version_bump.sh [major|minor|patch]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Check if pubspec.yaml exists
if [ ! -f "pubspec.yaml" ]; then
    print_error "pubspec.yaml not found. Please run this script from the project root."
    exit 1
fi

# Get current version from pubspec.yaml
current_version=$(grep "^version:" pubspec.yaml | sed 's/version: //' | sed 's/+.*//')
current_build=$(grep "^version:" pubspec.yaml | sed 's/.*+//')

print_info "Current version: $current_version+$current_build"

# Parse version components
IFS='.' read -ra VERSION_PARTS <<< "$current_version"
major=${VERSION_PARTS[0]}
minor=${VERSION_PARTS[1]}
patch=${VERSION_PARTS[2]}

# Determine version bump type
bump_type=${1:-patch}

case $bump_type in
    major)
        major=$((major + 1))
        minor=0
        patch=0
        ;;
    minor)
        minor=$((minor + 1))
        patch=0
        ;;
    patch)
        patch=$((patch + 1))
        ;;
    *)
        print_error "Invalid bump type. Use: major, minor, or patch"
        exit 1
        ;;
esac

# Increment build number
new_build=$((current_build + 1))
new_version="$major.$minor.$patch"

print_info "New version: $new_version+$new_build"

# Update pubspec.yaml
sed -i.bak "s/^version:.*/version: $new_version+$new_build/" pubspec.yaml

# Remove backup file
rm pubspec.yaml.bak

print_info "Version updated successfully!"
print_info "Don't forget to commit the changes:"
print_warning "git add pubspec.yaml"
print_warning "git commit -m \"Bump version to $new_version+$new_build\""
print_warning "git tag v$new_version"
print_warning "git push origin main --tags"
