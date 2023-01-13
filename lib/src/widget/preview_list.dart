import 'package:flutter/material.dart';
import 'package:font_preview/src/constants.dart';
import 'package:font_preview/src/font_details.dart';
import 'package:font_preview/src/widget/preview_item.dart';

class FontPreviewList extends StatelessWidget {
  FontPreviewList({
    required this.text,
    required List<FontProvider> fonts,
    required List<double> previewSizes,
    required List<FontWeight> fontWeights,
    required List<FontStyle> fontStyles,
  }) {
    for (var size in previewSizes) {
      for (var weight in fontWeights) {
        for (var style in fontStyles) {
          List<TextStyle> styles = [];
          for (var font in fonts) {
            styles.add(font
                .styleBuilder(size, weight, style)
                .copyWith(fontFamilyFallback: [kFallbackFont]));
          }
          _textStyles.add(styles);
        }
      }
    }
  }

  final String text;
  final List<List<TextStyle>> _textStyles = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final styles = _textStyles[index];
        if (styles.length == 1)
          return FontPreviewItem(text, styles.first);
        else
          return CompareFontsItem(text, styles);
      },
      itemCount: _textStyles.length,
    );
  }
}
