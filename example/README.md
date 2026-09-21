# font_preview example

This is the demo app for the Flutter package in the parent directory. It is not
published to pub.dev. Requires Dart 3.10+ / Flutter 3.38+ for `google_fonts` 8.

From this directory:

```sh
flutter pub get
flutter run -d chrome
```

Ubuntu and Raleway fonts are bundled. Other Google Fonts are downloaded at
runtime and require internet access.

## Checks

```sh
flutter analyze
flutter test
flutter build web
```

For Android, install JDK 17+ and the Android SDK required by your Flutter version
(SDK 36 for Flutter 3.41). The example uses the declarative Flutter Gradle plugins.
Apple deployment targets are iOS 13 and macOS 10.15.
