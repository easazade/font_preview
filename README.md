### What is it?
font_preview is helper a package to inspect, compare & preview fonts that are being used in Flutter apps

<img src="flutter_01.png" width="200"> <img src="flutter_02.png" width="200"> <img src="flutter_03.png" width="200">

### When do you need it?

- When you want to make sure you're custom font is loaded and being used
- When you want to make sure the google font you're using is downloaded and being used

NOTE: when you're font is not loaded `font_preview` uses `BungeeShade-Regular` as the fallback font so if your font is not loaded on your texts, they will look like this. 
<img src="https://user-images.githubusercontent.com/38987302/211726606-43de100f-4117-4fed-adc6-adb3b19bf7d0.png" width="200">
this way you can easily recognize this issue.

- when you simply need to see how the font looks like across different font-weights and font-styles 
- when you want to compare fonts together
- when you need to make sure all font-weights and font-styles for your custom fonts are loaded correctly. 
- when you want to check for faux styles. for example whether flutter is using a faux bold for w700 font weight or the font you specified.




### How to use it?

Add it as a `dev_dependency`

```yaml
dev_dependencies:
  font_preview: $latest-version
```

Run the following code. it will navigates to a new screen to preview the fonts

```dart
FontPreview.previewFonts(
  context,
  previewText: 'Flutter is Great',
  fonts: [
    // if you have custom fonts in your assets you can use its 
    // font family name
    FontProvider.fromFontFamily('Ubuntu'),
  ],
);
```

You can provide multiple fonts and compare them side by side for each font-weight and font-style


```dart
FontPreview.previewFonts(
  context,
  previewText: 'Flutter is Great',
  fonts: [
    FontProvider.fromFontFamily('Ubuntu'),    

    // If you are using google_fonts package for loading fonts 
    // provide your fonts for previewing like this
    FontProvider.fromBuilder(
      (fontSize, fontWeight, fontStyle) => GoogleFonts.raleway(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
    ),

    FontProvider.fromBuilder(
      (fontSize, fontWeight, fontStyle) => GoogleFonts.roboto(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
    ),

  ],
  fontStyles: [FontStyle.normal],
);
```


And you can specify what styles, weights & sizes you want your font to be previewed in

```dart
FontPreview.previewFonts(
  context,
  previewText: 'Flutter is Great',
  fonts: [
    FontProvider.fromFontFamily('Ubuntu'),
  ],
  fontStyles: [FontStyle.normal],
  fontWeights: [FontWeight.w400, FontWeight.w700],
  previewSizes: [11.0, 12.0, 14.0, 16.0, 18.0, 22.0],
);

```