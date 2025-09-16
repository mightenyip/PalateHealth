# PalateHealth

A comprehensive health and wellness tracking app built with Flutter. Track nutrition, log food intake, monitor sugar consumption, and maintain healthy habits.

## 🚀 Features

- **Food Logging**: Search and log food items with nutritional information
- **Sugar Tracking**: Monitor daily sugar intake with visual progress indicators
- **Health Dashboard**: Track weight, steps, calories, and other health metrics
- **Nutrition Overview**: View macronutrient breakdown and daily totals
- **Cross-Platform**: Runs on iOS, Android, Web, and Desktop

## 📱 Screenshots

*Coming soon...*

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: Provider
- **Navigation**: Go Router
- **Local Storage**: Shared Preferences
- **HTTP Requests**: HTTP package
- **Date/Time**: Intl package

## 🚧 To-Do List

### 🔥 High Priority
- [ ] **Integrate USDA Food API** - Replace local food database with comprehensive USDA nutrition data
- [ ] **Add Edamam Nutrition API** - Alternative nutrition data source for better food coverage
- [ ] **Graph-based Sugar Counter** - Create interactive charts with hover capabilities for sugar tracking
- [ ] **Barcode Scanning** - Add ability to scan product barcodes for instant food logging
- [ ] **User Authentication** - Implement login/signup system
- [ ] **Data Persistence** - Save user data across app sessions

### 📊 Data & Analytics
- [ ] **Nutrition Charts** - Visualize macronutrient trends over time
- [ ] **Health Score Algorithm** - Calculate and display overall health score
- [ ] **Goal Setting** - Allow users to set and track health goals
- [ ] **Progress Reports** - Generate weekly/monthly health reports
- [ ] **Export Data** - Allow users to export their health data

### 🎨 UI/UX Improvements
- [ ] **Dark Mode** - Add dark theme support
- [ ] **Customizable Dashboard** - Let users personalize their home screen
- [ ] **Food Photos** - Add ability to take photos of meals
- [ ] **Meal Planning** - Plan meals in advance
- [ ] **Recipe Integration** - Add recipe suggestions based on nutrition goals

### 🔧 Technical Enhancements
- [ ] **Offline Support** - Cache data for offline usage
- [ ] **Push Notifications** - Remind users to log meals
- [ ] **Data Backup** - Cloud backup and sync
- [ ] **Performance Optimization** - Improve app loading times
- [ ] **Unit Tests** - Add comprehensive test coverage

### 🌐 API Integrations
- [ ] **Fitness Trackers** - Connect with Fitbit, Apple Health, Google Fit
- [ ] **Grocery Stores** - Integration with grocery store APIs
- [ ] **Restaurant Menus** - Add restaurant nutrition data
- [ ] **Weather API** - Consider weather impact on health goals

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Chrome browser (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/PalateHealth.git
   cd PalateHealth
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web (Chrome)
   flutter run -d chrome --web-port=8080
   
   # For mobile (requires device/emulator)
   flutter run
   
   # For desktop
   flutter run -d macos  # or windows/linux
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── food_entry.dart      # Food entry model
│   └── food_database.dart   # Local food database
├── providers/                # State management
│   └── health_provider.dart # Health data provider
└── screens/                  # UI screens
    ├── home_screen.dart     # Main dashboard
    ├── nutrition_screen.dart # Nutrition overview
    ├── health_tracking_screen.dart # Health metrics
    ├── profile_screen.dart  # User profile
    └── food_logging_screen.dart # Food logging
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- USDA for providing comprehensive nutrition data
- Edamam for nutrition API services
- Open source community for various packages and tools