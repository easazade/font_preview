# font_preview

Inspect, compare, and preview fonts in your Flutter app across different sizes, weights, and styles.

Use it to visually check custom fonts, compare font families, and investigate missing font assets or synthesized bold and italic styles. Each preview displays the font family, size, style, and weight alongside your sample text.

<img src="https://user-images.githubusercontent.com/38987302/211730377-a6820e24-f995-4528-a30b-a93925323f20.png" width="200" alt="Font preview screen"> <img src="https://user-images.githubusercontent.com/38987302/211730436-957e0686-6da3-4144-8549-462071a2b233.png" width="200" alt="Font comparison screen"> <img src="https://user-images.githubusercontent.com/38987302/211730519-a8028096-da2c-467e-9574-b34d6b263fa1.png" width="200" alt="Font size and style previews">

## Installation

```sh
flutter pub add font_preview
```

Use a regular dependency when importing the package from `lib/`. If you only use it in separate development tooling or tests, use `flutter pub add --dev font_preview` instead.

## Preview a custom font

Register your font assets in your app's `pubspec.yaml`. The family name must match the name passed to `FontProvider.fromFontFamily`:

```yaml
flutter:
  fonts:
    - family: Ubuntu
      fonts:
        - asset: assets/fonts/Ubuntu-Regular.ttf
          weight: 400
        - asset: assets/fonts/Ubuntu-Bold.ttf
          weight: 700
```

Replace these paths with your own font files. See the [example configuration](example/pubspec.yaml) for additional weights and italic styles.

Import the package and call `FontPreview.previewFonts` from a context beneath a `MaterialApp`, such as a button in your home page:

```dart
import 'package:flutter/material.dart';
import 'package:font_preview/font_preview.dart';

class PreviewButton extends StatelessWidget {
  const PreviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FontPreview.previewFonts(
          context,
          previewText: 'Flutter is Great',
          fonts: [FontProvider.fromFontFamily('Ubuntu')],
          fontStyles: [FontStyle.normal],
          fontWeights: [FontWeight.w400, FontWeight.w700],
        );
      },
      child: const Text('Preview Ubuntu'),
    );
  }
}
```

The helper pushes a new route containing a scrollable preview list. It does not register or download font assets itself.

## Compare fonts with google_fonts

Add [google_fonts](https://pub.dev/packages/google_fonts) to your app if you want to use its font loaders:

```sh
flutter pub add google_fonts
```

In addition to the imports above, add:

```dart
import 'package:google_fonts/google_fonts.dart';
```

Wrap each font's style builder with `FontProvider.fromBuilder`, forwarding the requested size, weight, and style:

```dart
FontPreview.previewFonts(
  context,
  previewText: 'Flutter is Great',
  fonts: [
    FontProvider.fromFontFamily('Ubuntu'),
    FontProvider.fromBuilder(
      (fontSize, fontWeight, fontStyle) => GoogleFonts.raleway(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    ),
    FontProvider.fromBuilder(
      (fontSize, fontWeight, fontStyle) => GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    ),
  ],
  fontStyles: [FontStyle.normal],
);
```

For each size, weight, and style combination, the fonts appear together in a vertically stacked comparison group. `FontProvider.fromBuilder` accepts any callback that returns a `TextStyle`, not just Google Fonts builders.

Font downloads and asset loading remain the responsibility of `google_fonts` or your own loader. Follow its setup instructions for bundled assets or runtime fetching.

## Customize sizes, weights, and styles

`FontPreview.previewFonts` requires `previewText` and `fonts`. Its optional parameters default to:

| Parameter      | Default                                                       |
| -------------- | ------------------------------------------------------------- |
| `previewSizes` | `[16.0]` (`kPreviewFontSizes`)                                |
| `fontWeights`  | All nine weights, `FontWeight.w100` through `FontWeight.w900` |
| `fontStyles`   | Normal and italic (`FontStyle.values`)                        |

Every combination is previewed, ordered by size, then weight, then style. To limit the preview to specific variants:

```dart
FontPreview.previewFonts(
  context,
  previewText: 'Flutter is Great',
  fonts: [FontProvider.fromFontFamily('Ubuntu')],
  fontStyles: [FontStyle.normal, FontStyle.italic],
  fontWeights: [FontWeight.w400, FontWeight.w700],
  previewSizes: [11.0, 12.0, 14.0, 16.0, 18.0, 22.0],
);
```

### Embed a preview in your own screen

Use `FontPreviewList` directly instead of opening a route. Unlike the navigation helper, its constructor requires all three variant lists:

```dart
Scaffold(
  appBar: AppBar(title: const Text('Font preview')),
  body: FontPreviewList(
    text: 'Flutter is Great',
    fonts: [FontProvider.fromFontFamily('Ubuntu')],
    previewSizes: kPreviewFontSizes,
    fontWeights: FontWeight.values,
    fontStyles: FontStyle.values,
  ),
);
```

The widget contains a `ListView`; give it bounded height, for example with `Expanded` when placing it inside a `Column`.

## Recognize fallback rendering

The preview list sets the bundled **BungeeShade-Regular** font as its font-family fallback, replacing any fallback list supplied by your style builder. Its distinctive appearance helps reveal when the requested font cannot render your text:

<img src="https://user-images.githubusercontent.com/38987302/211726606-43de100f-4117-4fed-adc6-adb3b19bf7d0.png" width="200" alt="Text rendered with the distinctive Bungee Shade fallback font">

This is a visual aid, not an automated font-loading check:

- Missing glyphs can trigger fallback even when the primary font is loaded.
- If neither font supports a glyph, Flutter may use another fallback.
- Missing weight or style assets may cause Flutter to select another face or synthesize a style rather than show Bungee Shade.
- Preview labels describe the requested `TextStyle`, not the actual font face used by the renderer.

## Run the example

The [example app](example/lib/main.dart) demonstrates custom Ubuntu assets, Google Fonts, comparisons, and an intentionally unknown font family to show fallback rendering.

From a checkout of this repository:

```sh
cd example
flutter pub get
flutter run
```

See the [changelog](CHANGELOG.md) for release history.
