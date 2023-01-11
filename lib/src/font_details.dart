import 'package:flutter/widgets.dart';

typedef TextStyleBuilder = TextStyle Function(
  double fontSize,
  FontWeight fontWeight,
  FontStyle fontStyle,
);

class FontProvider {
  FontProvider._({required this.styleBuilder});

  final TextStyleBuilder styleBuilder;

  factory FontProvider.fromBuilder(TextStyleBuilder builder) =>
      FontProvider._(styleBuilder: builder);

  factory FontProvider.fromFontFamily(String fontFamily) => FontProvider._(
        styleBuilder: (fontSize, fontWeight, fontStyle) => TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        ),
      );
}
