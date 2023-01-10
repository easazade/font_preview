import 'package:flutter/widgets.dart';

typedef TextStyleBuilder = TextStyle Function(double fontSize, FontWeight fontWeight, FontStyle fontStyle);

class FontDetails {
  FontDetails._({required this.styleBuilder});

  final TextStyleBuilder styleBuilder;

  factory FontDetails.fromBuilder(TextStyleBuilder builder) => FontDetails._(styleBuilder: builder);

  factory FontDetails.fromFontFamily(String fontFamily) => FontDetails._(
        styleBuilder: (fontSize, fontWeight, fontStyle) => TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        ),
      );
}
