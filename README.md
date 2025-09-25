# 🛍️ Active Ecommerce CMS - Flutter App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

**A Complete Modern Ecommerce Solution Built with Flutter**

[📱 Download APK](#-download) • [🚀 Live Demo](#-demo) • [📖 Documentation](#-documentation) • [🤝 Contributing](#-contributing)

</div>

---

## 🌟 Overview

Active Ecommerce CMS is a comprehensive, feature-rich mobile ecommerce application built with Flutter. It provides a complete shopping experience with modern UI/UX design, multiple payment gateways, social authentication, and advanced ecommerce features.

### ✨ Key Highlights

- 🎨 **Modern UI/UX** - Clean, intuitive design with smooth animations
- 🔐 **Secure Authentication** - Multiple login options including social media
- 💳 **Multiple Payment Gateways** - Support for 15+ payment methods
- 🌍 **Multi-language Support** - Localization for global reach
- 📱 **Cross-platform** - Works seamlessly on Android and iOS
- 🚀 **CI/CD Ready** - Complete CodeMagic pipeline for automated deployment

---

## 🚀 Features

### 🛒 **Core Ecommerce Features**
- **Product Catalog** - Browse thousands of products with advanced filtering
- **Shopping Cart** - Add, remove, and manage cart items
- **Wishlist** - Save favorite products for later
- **Order Management** - Track orders from placement to delivery
- **Search & Filter** - Smart search with category and price filters
- **Product Reviews** - Customer ratings and reviews system

### 🔐 **Authentication & Security**
- **Multi-login Options**:
  - 📧 Email/Password
  - 📱 Phone Number (OTP)
  - 🔵 Facebook Login
  - 🔴 Google Sign-in
  - 🍎 Apple ID (iOS)
- **Guest Checkout** - Shop without registration
- **Secure Sessions** - JWT token-based authentication

### 💰 **Payment Integration**
- **15+ Payment Gateways**:
  - 💳 Stripe
  - 🅿️ PayPal
  - 💸 Razorpay
  - 🏦 SSLCommerz
  - 📱 bKash
  - 🌊 Flutterwave
  - 💎 IYZICO
  - 📲 Paytm
  - 🔷 Khalti
  - 💰 PayHere
  - ⚡ PayFast
  - 📱 M-Pesa
  - 🏪 Cash on Delivery

### 🎯 **Advanced Features**
- **Flash Deals** - Limited time offers and discounts
- **Auction System** - Bid on products
- **Classified Ads** - User-generated product listings
- **Multi-vendor Support** - Multiple seller management
- **Coupon System** - Discount codes and promotions
- **Wallet System** - Digital wallet for payments
- **Club Points** - Loyalty rewards program
- **Live Chat** - Customer support messaging

### 🌐 **Localization & Accessibility**
- **Multi-language Support** - English, Arabic, and more
- **RTL Support** - Right-to-left language compatibility
- **Currency Support** - Multiple currency options
- **Responsive Design** - Optimized for all screen sizes

---

## 🛠️ Tech Stack

### **Frontend**
- **Framework**: Flutter 3.4.0+
- **Language**: Dart 3.0+
- **State Management**: Provider Pattern
- **Navigation**: GoRouter
- **UI Components**: Material Design 3

### **Backend Integration**
- **API**: RESTful APIs
- **Authentication**: JWT Tokens
- **Real-time**: Firebase Cloud Messaging
- **Storage**: Shared Preferences
- **Caching**: HTTP Cache

### **Third-party Services**
- **Maps**: Google Maps
- **Analytics**: Firebase Analytics
- **Crash Reporting**: Firebase Crashlytics
- **Push Notifications**: Firebase FCM
- **Social Login**: Facebook, Google, Apple
- **File Upload**: Multi-part form data

### **Development Tools**
- **IDE**: Android Studio / VS Code
- **Version Control**: Git
- **CI/CD**: CodeMagic
- **Testing**: Flutter Test Framework
- **Code Quality**: Flutter Lints

---

## 📱 Screenshots

<div align="center">

| Home Screen | Product Details | Shopping Cart | Profile |
|-------------|-----------------|---------------|---------|
| <img src="assets/screenshots/home.png" width="200"/> | <img src="assets/screenshots/product.png" width="200"/> | <img src="assets/screenshots/cart.png" width="200"/> | <img src="assets/screenshots/profile.png" width="200"/> |

| Categories | Search | Checkout | Orders |
|------------|--------|----------|--------|
| <img src="assets/screenshots/categories.png" width="200"/> | <img src="assets/screenshots/search.png" width="200"/> | <img src="assets/screenshots/checkout.png" width="200"/> | <img src="assets/screenshots/orders.png" width="200"/> |

</div>

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.4.0 or higher
- **Dart SDK**: 3.0.0 or higher
- **Android Studio** / **VS Code**
- **Git**

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/SpoilmeDaddy-CICD-Codemagic.git
   cd SpoilmeDaddy-CICD-Codemagic
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` (Android)
   - Add your `GoogleService-Info.plist` (iOS)

4. **Set up API Configuration**
   ```dart
   // lib/app_config.dart
   static const String DOMAIN_PATH = "your_domain.com";
   static String purchase_code = "your_purchase_code";
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### 🔧 Configuration

#### API Setup
1. Update `lib/app_config.dart` with your backend URL
2. Configure payment gateway credentials
3. Set up social login app IDs

#### Firebase Setup
1. Create a Firebase project
2. Enable Authentication, FCM, and Analytics
3. Download configuration files

#### Payment Gateway Setup
1. Configure payment providers in your backend
2. Update payment method configurations
3. Test payment flows

---

## 📁 Project Structure

```
lib/
├── 📁 screens/           # UI Screens
│   ├── auth/            # Authentication screens
│   ├── home/            # Home and dashboard
│   ├── product/         # Product related screens
│   ├── checkout/        # Cart and checkout
│   ├── profile/         # User profile
│   └── orders/          # Order management
├── 📁 repositories/     # Data layer
├── 📁 data_model/       # Data models
├── 📁 helpers/          # Utility functions
├── 📁 providers/        # State management
├── 📁 services/         # External services
├── 📁 custom/           # Custom widgets
└── 📁 ui_elements/      # Reusable UI components
```

---

## 🔄 CI/CD Pipeline

This project includes a complete **CodeMagic CI/CD pipeline** with:

- ✅ **Automated Testing** - Unit tests and widget tests
- 🏗️ **Multi-environment Builds** - Dev, Staging, Production
- 📦 **Automated Deployment** - Google Play Store & App Store
- 🔐 **Code Signing** - Automated certificate management
- 📧 **Notifications** - Build status alerts

### Build Profiles

| Profile | Trigger | Output | Deployment |
|---------|---------|--------|------------|
| **Development** | `develop` branch | APK | Email |
| **Staging** | `staging` branch | AAB | Internal Testing |
| **Production** | `main` branch | AAB + APK | Play Store |
| **iOS** | `ios/*` branches | IPA | TestFlight |

📖 **[View CI/CD Documentation](README_CICD.md)**

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

---

## 📱 Download

<div align="center">

### 🚀 Try the App Now!

[![Download APK](https://img.shields.io/badge/Download-APK-green?style=for-the-badge&logo=android)](https://github.com/yourusername/SpoilmeDaddy-CICD-Codemagic/releases/latest)
[![Google Play](https://img.shields.io/badge/Google_Play-414141?style=for-the-badge&logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=com.activeitzone.activeecommercecmsdemoapp)
[![App Store](https://img.shields.io/badge/App_Store-0D96F6?style=for-the-badge&logo=app-store&logoColor=white)](https://apps.apple.com/app/your-app-id)

</div>

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### 🐛 **Bug Reports**
- Use the [issue tracker](https://github.com/yourusername/SpoilmeDaddy-CICD-Codemagic/issues)
- Include detailed steps to reproduce
- Provide device and OS information

### 💡 **Feature Requests**
- Open an issue with the `enhancement` label
- Describe the feature and its benefits
- Include mockups or examples if possible

### 🔧 **Pull Requests**
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### 📋 **Development Guidelines**
- Follow [Flutter style guide](https://dart.dev/guides/language/effective-dart/style)
- Write tests for new features
- Update documentation as needed
- Ensure CI/CD pipeline passes

---

## 📞 Contact & Support

<div align="center">

### 👨‍💻 **Developer Information**

**Your Name** - Lead Flutter Developer

[![Portfolio](https://img.shields.io/badge/Portfolio-000000?style=for-the-badge&logo=About.me&logoColor=white)](https://yourportfolio.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/yourprofile)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/yourusername)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:your.email@example.com)

</div>

### 📧 **Business Inquiries**
- **Email**: business@yourcompany.com
- **Phone**: +1 (555) 123-4567
- **Website**: [www.yourcompany.com](https://www.yourcompany.com)

### 💬 **Community & Support**
- **Discord**: [Join our community](https://discord.gg/yourserver)
- **Telegram**: [@YourChannel](https://t.me/yourchannel)
- **Stack Overflow**: [Ask questions](https://stackoverflow.com/questions/tagged/flutter)

### 🏢 **Company Information**
**ActiveItZone** - Leading Mobile App Development Company

- 🌐 **Website**: [activeitzone.com](https://activeitzone.com)
- 📧 **Support**: support@activeitzone.com
- 📱 **WhatsApp**: +880 1234-567890
- 🏢 **Address**: 123 Tech Street, Digital City, Country

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 ActiveItZone

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing framework
- **Firebase** - For backend services
- **Community Contributors** - For valuable feedback and contributions
- **Open Source Libraries** - Listed in [pubspec.yaml](pubspec.yaml)

---

## 📊 Project Stats

<div align="center">

![GitHub stars](https://img.shields.io/github/stars/yourusername/SpoilmeDaddy-CICD-Codemagic?style=social)
![GitHub forks](https://img.shields.io/github/forks/yourusername/SpoilmeDaddy-CICD-Codemagic?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/yourusername/SpoilmeDaddy-CICD-Codemagic?style=social)

![GitHub issues](https://img.shields.io/github/issues/yourusername/SpoilmeDaddy-CICD-Codemagic)
![GitHub pull requests](https://img.shields.io/github/issues-pr/yourusername/SpoilmeDaddy-CICD-Codemagic)
![GitHub last commit](https://img.shields.io/github/last-commit/yourusername/SpoilmeDaddy-CICD-Codemagic)

</div>

---

<div align="center">

### 🌟 **Star this repository if you found it helpful!**

**Made with ❤️ by [Your Name](https://github.com/yourusername)**

</div>
