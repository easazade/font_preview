import 'package:flutter/material.dart';
import 'package:font_preview/src/constants.dart';
import 'package:font_preview/src/font_details.dart';
import 'package:font_preview/src/widget/preview_list.dart';

class FontPreview {
  static void previewFonts(
    BuildContext context, {
    required String previewText,
    required List<FontProvider> fonts,
    List<double> previewSizes = kPreviewFontSizes,
    List<FontWeight> fontWeights = FontWeight.values,
    List<FontStyle> fontStyles = FontStyle.values,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Material(
          child: FontPreviewList(
            text: previewText,
            fonts: fonts,
            previewSizes: previewSizes,
            fontWeights: fontWeights,
            fontStyles: fontStyles,
          ),
        ),
      ),
    );
  }
}
