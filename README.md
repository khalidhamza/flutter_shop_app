# Shop App

A Flutter-based e-commerce application with onboarding, authentication, and theming support. The app uses BLoC for state management and local storage for persisting user preferences and authentication tokens.

## Features

- Onboarding flow for new users
- User authentication (login)
- Home layout for authenticated users
- Light and dark theme support
- State management using BLoC
- Persistent storage using shared preferences

## Project Structure

- `lib/main.dart`: App entry point, theme and navigation logic
- `lib/layout/home_layout.dart`: Main app layout after login
- `lib/modules/auth/login_screen.dart`: Login screen
- `lib/modules/onboarding/onboarding_screen.dart`: Onboarding flow
- `lib/shared/cubit/`: BLoC Cubit and states
- `lib/shared/constants.dart`: App-wide constants
- `lib/shared/styles/themes.dart`: Light and dark theme definitions
- `lib/network/local/local_storage.dart`: Local storage helper

## App Logic

1. **Initialization**:  
   - Ensures Flutter bindings are initialized.
   - Sets up BLoC observer.
   - Initializes local storage.

2. **Startup Flow**:  
   - Checks if onboarding is completed.
   - Checks for a saved user token.
   - Navigates to:
     - Onboarding screen (if not seen)
     - Login screen (if onboarding seen but not logged in)
     - Home layout (if logged in)

3. **Theming**:  
   - Reads theme preference from local storage.
   - Supports dynamic switching between light and dark themes via BLoC.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

```sh
git clone https://github.com/khalidhamza/flutter_shop_app.git
cd shop_app
flutter pub get
```

### Running

```sh
flutter run
```

## Dependencies

- `flutter_bloc`
- `shared_preferences`
- `flutter`

## License

This project is licensed under the MIT License.
