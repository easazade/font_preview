import 'package:flutter/material.dart';

class FontPreviewSingleItem extends StatelessWidget {
  FontPreviewSingleItem(
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
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!, width: 1)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(text, style: textStyle),
          SizedBox(width: 3),
          Text(
            _styleInfo,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).primaryColor.withOpacity(.40),
            ),
          ),
        ],
      ),
    );
  }
}
