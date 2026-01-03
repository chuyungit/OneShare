# OneShare Context

## Project Overview

OneShare is a cross-platform Flutter application designed for file sharing and transfer. It targets Android, iOS, Windows, Linux, and macOS. The application aims to facilitate file transfers using various protocols and includes a responsive UI that adapts to mobile and desktop layouts.

## Technical Architecture

*   **Framework:** Flutter (Dart)
*   **State Management:** `provider` (MultiProvider setup in `main.dart`)
*   **Navigation:** Custom responsive navigation using `NavigationBar` (Mobile) and `NavigationRail` (Desktop).
*   **UI/UX:** Material 3 Design, Custom Fonts (MiSans, HarmonyOS Sans SC, etc.), SVG Icons.
*   **Networking:**
    *   `TransferService`: Custom TCP-based transfer implementation.
    *   **Protocols:** WebDAV (`webdav_client`), SSH/SFTP (`dartssh2`), SMB (`smb_connect`).

## Key Directories

*   **`lib/`**: Source code.
    *   `main.dart`: Application entry point and main layout (`MainPage`).
    *   `models/`: Data models and State Notifiers (`ShareModel`, `SettingsModel`, etc.).
    *   `pages/`: Main application screens (`Share`, `Web`, `Downloading`, `Settings`).
    *   `services/`: Core logic (`TransferService`, `DiscoveryService`, `FileSystem`).
    *   `widgets/`: Reusable UI components.
*   **`assets/`**: Static assets.
    *   `audio/`: Notification sounds.
    *   `fonts/`: Custom font files.
    *   `images/`: UI assets (SVGs, icons).
*   **`android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/`**: Platform-specific build configurations.

## Development & Building

**Prerequisites:**
*   Flutter SDK (Environment sdk: `^3.10.1`)

**Running the App:**
```bash
# Run on connected device (auto-detects platform)
flutter run

# Run specifically for a platform
flutter run -d windows
flutter run -d linux
flutter run -d android
```

**Testing:**
```bash
# Run unit/widget tests
flutter test
```

**Linting:**
```bash
# Analyze code
flutter analyze
```

## Code Conventions

*   **Style:** Follows standard Flutter/Dart guidelines.
*   **Linting:** Uses `flutter_lints` version `^5.0.0` (as per `analysis_options.yaml`).
*   **Imports:** Prefer absolute imports or consistent relative imports within modules.
*   **Assets:** Accessed via `assets/...` paths defined in `pubspec.yaml`.
*   **Responsiveness:** Use `LayoutBuilder` to distinguish between mobile (< 600px) and desktop layouts.

## Current State & Notes

*   The `TransferService` implements a basic TCP server/client but notes indicate it needs a more robust protocol/state machine for reliable file transfer.
*   The project uses `flutter_svg` heavily for navigation icons.
*   Theme logic is centralized in `ThemeModel`.
