# MAD In-Class Activity 13 – Interactive Flutter Signup Adventure

## Overview

This project is an interactive, multi-step signup experience in Flutter that goes beyond basic forms. Users enjoy animations, avatar selection, password strength feedback, and celebratory confetti when completing signup.

The goal is to enhance user experience through advanced Flutter widgets, animations, and state management.

## Features

### Core Features

* Multi-step signup form with validation
* Personalized welcome screen with animated greetings
* Avatar selection (5 fun avatars)
* Password strength validation
* Date of birth selection via calendar picker
* Real-time visual feedback during form completion
* Confetti celebration on successful signup

### Extra Features

* Animated buttons and form headers
* Fade-in and scale animations on welcome screen
* “More Celebration” button triggers confetti again
* Snackbars for invalid actions
* Custom error messages

## Project Structure

```
lib/
 ├─ main.dart                # Entry point
 ├─ screens/
 │   ├─ signup_screen.dart
 │   └─ success_screen.dart
 ├─ widgets/
 │   ├─ avatar_picker.dart
 │   └─ custom_textfield.dart
 └─ README.md
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  animated_text_kit: ^4.2.2
  confetti: ^0.7.0
```

Install packages:

```bash
flutter pub get
```

## Installation & Running

1. Clone the repository:

```bash
git clone https://github.com/bplpriya/MAD-Interactive-Flutter-Signup-Adventure.git
```

2. Navigate to the project directory:

```bash
cd signup_adventure
```

3. Fetch dependencies:

```bash
flutter pub get
```

4. Run the project:

```bash
flutter run
```

## Author

**Priya Koppuravuri**