import 'package:flutter/material.dart';

class FontPreviewItem extends StatelessWidget {
  FontPreviewItem(
    this.text,
    this.textStyle, {
    super.key,
  }) : _styleInfo =
            '${textStyle.fontFamily} - ${textStyle.fontStyle?.name} - ${textStyle.fontWeight.toString().split('.').last}';

  final String text;

  final TextStyle textStyle;

  final String _styleInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey[200]!, width: 1)),
      child: FontViewAndInfo(
          text: text, styleInfo: _styleInfo, textStyle: textStyle),
    );
  }
}

class CompareFontsItem extends StatelessWidget {
  CompareFontsItem(
    this.text,
    this.textStyles, {
    super.key,
  }) : _styleInfos = textStyles
            .map((textStyle) =>
                '${textStyle.fontFamily} - ${textStyle.fontStyle?.name} - ${textStyle.fontWeight.toString().split('.').last}')
            .toList();

  final String text;

  final List<TextStyle> textStyles;

  final List<String> _styleInfos;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!, width: 1),
        color: Colors.grey[200],
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < textStyles.length; i++)
              FontViewAndInfo(
                  text: text,
                  styleInfo: _styleInfos[i],
                  textStyle: textStyles[i]),
          ],
        ),
      ),
    );
  }
}

class FontViewAndInfo extends StatelessWidget {
  const FontViewAndInfo({
    super.key,
    required this.text,
    required this.styleInfo,
    required this.textStyle,
  });

  final String text;
  final String styleInfo;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(text, style: textStyle),
        SizedBox(width: 3),
        Text(
          styleInfo,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).primaryColor.withOpacity(.40),
          ),
        ),
      ],
    );
  }
}
