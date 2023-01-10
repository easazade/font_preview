import 'package:flutter/material.dart';
import 'package:font_preview/src/constants.dart';
import 'package:font_preview/src/font_details.dart';
import 'package:font_preview/src/widget/preview_item.dart';

class FontPreviewList extends StatelessWidget {
  FontPreviewList({
    super.key,
    required this.text,
    required List<FontDetails> fonts,
    required List<double> previewSizes,
    required List<FontWeight> fontWeights,
    required List<FontStyle> fontStyles,
  }) {
    for (var font in fonts) {
      for (var size in previewSizes) {
        for (var weight in fontWeights) {
          for (var style in fontStyles) {
            _textStyles.add(font.styleBuilder(size, weight, style).copyWith(fontFamilyFallback: [kFallbackFont]));
          }
        }
      }
    }
  }

  final String text;
  final List<TextStyle> _textStyles = [];

  @override
  Widget build(BuildContext context) {
    print(_textStyles.length);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final textStyle = _textStyles[index];
        return FontPreviewSingleItem(text, textStyle);
      },
      itemCount: _textStyles.length,
    );
  }
}
