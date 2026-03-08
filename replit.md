# Clinc App

A Flutter mobile/web application for a clinic management system. This is a healthcare app that supports Arabic and English localization.

## Tech Stack

- **Framework**: Flutter (v3.32.0 / Dart 3.8.0)
- **State Management**: GetX (get package)
- **Routing**: GetX routes (AppPages/AppRoutes)
- **Localization**: easy_localization (Arabic + English)
- **Storage**: get_storage
- **Charts**: fl_chart (v0.68.0)
- **SVG**: flutter_svg (replacing vector_graphics due to native binary limitations)
- **Other**: lottie animations, carousel_slider, fl_chart, pinput, file_picker, etc.

## Project Structure

```
lib/
├── app/
│   ├── bindings/       # GetX dependency injection bindings
│   ├── controllers/    # App-level controllers
│   ├── core/           # Constants, theme, utilities, widgets
│   ├── data/           # Data models
│   ├── extension/      # Dart extensions
│   ├── routes/         # App navigation routes
│   └── services/       # App services
├── generated/          # Auto-generated localization files
├── modules/            # Feature modules (splash, auth, home, etc.)
└── main.dart           # App entry point
assets/
├── icons/              # SVG icons
├── images/             # PNG images
├── lottie/             # Lottie animation files
└── translations/       # ar.json, en.json
web/                    # Flutter web platform files
```

## Workflow

- **Start application**: `flutter run -d web-server --web-port=5000 --web-hostname=0.0.0.0`
- Runs on port 5000 (web preview)

## Deployment

- **Target**: Static site
- **Build command**: `flutter build web --release`
- **Public directory**: `build/web`

## Setup Notes

- Flutter installed via Nix system dependencies (flutter package)
- SDK constraint relaxed to `^3.8.0` to match installed Flutter (3.32.0 / Dart 3.8.0)
- Replaced `vector_graphics`/`vector_graphics_compiler` with `flutter_svg` (native binary `libpath_ops.so` not available in Nix environment)
- `fl_chart` pinned to `^0.68.0` for compatibility with `vector_math 2.1.4`
- Removed `activeThumbColor` from `Switch.adaptive` (removed in Flutter 3.32)
- Web platform created with `flutter create --platforms=web .`
