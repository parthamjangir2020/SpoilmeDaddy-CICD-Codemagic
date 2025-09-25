# CodeMagic Setup Helper Script (PowerShell)
# This script helps prepare your project for CodeMagic CI/CD

param(
    [switch]$Help
)

if ($Help) {
    Write-Host "CodeMagic Setup Helper Script" -ForegroundColor Green
    Write-Host "Usage: .\scripts\setup_codemagic.ps1" -ForegroundColor Yellow
    Write-Host "This script validates your project for CodeMagic CI/CD setup"
    exit 0
}

function Write-Info {
    param($Message)
    Write-Host "[INFO] $Message" -ForegroundColor Green
}

function Write-Warning {
    param($Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param($Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-Step {
    param($Message)
    Write-Host "[STEP] $Message" -ForegroundColor Blue
}

Write-Info "CodeMagic Setup Helper"
Write-Info "======================"

# Check if we're in a Flutter project
if (-not (Test-Path "pubspec.yaml")) {
    Write-Error "pubspec.yaml not found. Please run this script from the Flutter project root."
    exit 1
}

# Check if codemagic.yaml exists
if (-not (Test-Path "codemagic.yaml")) {
    Write-Error "codemagic.yaml not found. Please ensure the CI/CD configuration file exists."
    exit 1
}

Write-Step "Validating project structure..."

# Check Android configuration
if (-not (Test-Path "android\key.properties")) {
    Write-Warning "android\key.properties not found. You'll need to configure Android signing."
} else {
    Write-Info "✓ Android key.properties found"
}

if (-not (Test-Path "android\app\key.jks")) {
    Write-Warning "android\app\key.jks not found. You'll need to upload your keystore to CodeMagic."
} else {
    Write-Info "✓ Android keystore found"
}

# Check if build.gradle.kts has signing config
$buildGradleContent = Get-Content "android\app\build.gradle.kts" -Raw
if ($buildGradleContent -match "signingConfigs") {
    Write-Info "✓ Android signing configuration found in build.gradle.kts"
} else {
    Write-Warning "Android signing configuration not found in build.gradle.kts"
}

# Check iOS configuration
if (Test-Path "ios") {
    Write-Info "✓ iOS project found"
    if (Test-Path "ios\Runner.xcworkspace") {
        Write-Info "✓ iOS workspace found"
    } else {
        Write-Warning "iOS workspace not found. Run 'cd ios && pod install' if using CocoaPods"
    }
} else {
    Write-Warning "iOS project not found"
}

# Check Fastlane configuration
if (Test-Path "android\fastlane\Fastfile") {
    Write-Info "✓ Android Fastlane configuration found"
} else {
    Write-Warning "Android Fastlane configuration not found"
}

# Validate codemagic.yaml
Write-Step "Validating codemagic.yaml..."

$codemagicContent = Get-Content "codemagic.yaml" -Raw

if ($codemagicContent -match "workflows:") {
    Write-Info "✓ Workflows section found"
} else {
    Write-Error "Workflows section not found in codemagic.yaml"
}

if ($codemagicContent -match "android_signing:") {
    Write-Info "✓ Android signing configuration found"
} else {
    Write-Warning "Android signing configuration not found in codemagic.yaml"
}

if ($codemagicContent -match "google_play:") {
    Write-Info "✓ Google Play publishing configuration found"
} else {
    Write-Warning "Google Play publishing configuration not found in codemagic.yaml"
}

# Check environment variables documentation
if (Test-Path "CODEMAGIC_SETUP.md") {
    Write-Info "✓ Setup documentation found"
} else {
    Write-Warning "Setup documentation not found"
}

Write-Step "Checking Flutter configuration..."

# Get current version
$pubspecContent = Get-Content "pubspec.yaml"
$versionLine = $pubspecContent | Where-Object { $_ -match "^version:" }
$currentVersion = $versionLine -replace "version: ", ""
Write-Info "Current app version: $currentVersion"

# Check package name
$packageName = $buildGradleContent | Select-String 'applicationId = "([^"]*)"' | ForEach-Object { $_.Matches[0].Groups[1].Value }
Write-Info "Package name: $packageName"

Write-Step "Setup checklist:"
Write-Info "=================="

Write-Host "Before using CodeMagic, ensure you have:"
Write-Host "□ Created a CodeMagic account"
Write-Host "□ Connected your GitHub repository"
Write-Host "□ Uploaded Android keystore to CodeMagic"
Write-Host "□ Created Google Play service account"
Write-Host "□ Set up environment variables in CodeMagic"
Write-Host "□ Configured email notifications"
Write-Host ""

Write-Info "Environment variables needed:"
Write-Host "• GCLOUD_SERVICE_ACCOUNT_CREDENTIALS"
Write-Host "• KEYSTORE_PASSWORD"
Write-Host "• KEY_ALIAS"
Write-Host "• KEY_PASSWORD"
Write-Host "• PACKAGE_NAME"
Write-Host ""

Write-Info "For detailed setup instructions, see CODEMAGIC_SETUP.md"

Write-Step "Testing Flutter installation..."
try {
    $flutterVersion = flutter --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Info "✓ Flutter found"
        Write-Info "Testing basic commands..."
        flutter clean
        flutter pub get
        flutter analyze
        $testResult = flutter test
        if ($LASTEXITCODE -eq 0) {
            Write-Info "✓ All tests passed"
        } else {
            Write-Warning "Some tests failed. Fix them before deploying."
        }
    }
} catch {
    Write-Warning "Flutter not found. Install Flutter to test builds locally."
}

Write-Info "Setup validation completed!"
Write-Info "Review the warnings above and follow CODEMAGIC_SETUP.md for detailed instructions."
