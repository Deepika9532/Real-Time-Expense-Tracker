# Real Time Expense Tracker

A comprehensive expense tracking application built with Flutter and Firebase. This app allows users to monitor their spending in real-time, categorize expenses, set budgets, and visualize their financial data through intuitive charts and analytics.

## Features

- **Real-time Expense Tracking**: Instantly record and categorize expenses as they occur
- **User Authentication**: Secure login/signup with Firebase Authentication
- **Data Synchronization**: Sync expense data across devices using Firestore
- **Receipt Management**: Upload and store receipt images using Firebase Cloud Storage
- **Budget Planning**: Set monthly budgets and track spending against them
- **Analytics Dashboard**: Visualize spending patterns with interactive charts
- **Expense Categories**: Predefined and custom categories for better organization
- **Multi-platform Support**: Works on iOS, Android, and web platforms
- **Offline Support**: Works offline with data syncing when connection is restored
- **Secure Storage**: Encrypted local storage with Hive for sensitive data

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Authentication, Firestore, Cloud Storage, Analytics)
- **Architecture**: Clean Architecture with Repository Pattern
- **State Management**: Provider and BLoC
- **Database**: Firestore (remote), Hive (local)
- **Data Modeling**: Freezed for immutable data classes
- **Dependency Injection**: GetIt
- **Networking**: Dio with interceptors
- **UI Components**: Material Design with custom theming

## Firebase Integration

The app leverages multiple Firebase services:

- **Authentication**: Email/password, Google, and Apple sign-in
- **Firestore**: Secure real-time database for expense data
- **Storage**: Cloud storage for receipt images and user avatars
- **Analytics**: Usage analytics and crash reporting
- **Security Rules**: Custom rules for data protection

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd real_time_expense_tracker
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add your platform (Android/iOS/Web) to the project
   - Download the configuration files (`google-services.json`, `GoogleService-Info.plist`, etc.)
   - Place them in the appropriate directories
   - Run `flutterfire configure` to generate `firebase_options.dart`

4. Run the application:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── network/
│   ├── routes/
│   ├── theme/
│   ├── usecases/
│   └── utils/
├── data/
│   ├── data_sources/
│   ├── dto/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── features/
│   ├── auth/
│   ├── expenses/
│   └── profile/
├── presentation/
│   ├── cubits/
│   ├── pages/
│   ├── providers/
│   ├── screens/
│   └── widgets/
├── services/
├── app.dart
└── main.dart
```

## Environment Variables

Create a `.env` file in the project root with the following variables:

```env
JWT_SECRET=your_jwt_secret
OPENROUTER_API_KEY=your_openrouter_api_key
NODE_ENV=development
```

## Firebase Security Rules

The project includes comprehensive security rules for both Firestore and Storage:

- **Firestore Rules**: Users can only access their own data
- **Storage Rules**: Users can only upload/read their own files

## Running Tests

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test --run-widget-tests

# Run integration tests
flutter test integration_test/
```

## Building for Production

```bash
# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release

# Build for Web
flutter build web
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have questions, please file an issue in the repository or contact the development team.
"# Real-Time-Expense-Tracker" 
