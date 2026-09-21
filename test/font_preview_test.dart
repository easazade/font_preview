import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_preview/font_preview.dart';

void main() {
  test('font family provider preserves the requested style', () {
    final style = FontProvider.fromFontFamily(
      'Ubuntu',
    ).styleBuilder(24, FontWeight.w700, FontStyle.italic);

    expect(style.fontFamily, 'Ubuntu');
    expect(style.fontSize, 24);
    expect(style.fontWeight, FontWeight.w700);
    expect(style.fontStyle, FontStyle.italic);
  });

  test('builder receives every size, weight and style combination', () {
    final calls = <(double, FontWeight, FontStyle)>[];
    final provider = FontProvider.fromBuilder((size, weight, style) {
      calls.add((size, weight, style));
      return TextStyle(fontSize: size, fontWeight: weight, fontStyle: style);
    });

    FontPreviewList(
      text: 'Preview',
      fonts: [provider],
      previewSizes: const [16, 24],
      fontWeights: const [FontWeight.w400, FontWeight.w700],
      fontStyles: FontStyle.values,
    );

    expect(calls, [
      for (final size in [16.0, 24.0])
        for (final weight in [FontWeight.w400, FontWeight.w700])
          for (final style in FontStyle.values) (size, weight, style),
    ]);
  });

  testWidgets('single font renders its metadata and diagnostic fallback', (
    tester,
  ) async {
    const key = ValueKey('preview');
    await tester.pumpWidget(
      MaterialApp(
        home: FontPreviewList(
          key: key,
          text: 'Preview',
          fonts: [FontProvider.fromFontFamily('Ubuntu')],
          previewSizes: const [24],
          fontWeights: const [FontWeight.w700],
          fontStyles: const [FontStyle.italic],
        ),
      ),
    );

    expect(find.byKey(key), findsOneWidget);
    expect(find.byType(FontPreviewItem), findsOneWidget);
    expect(find.byType(CompareFontsItem), findsNothing);
    expect(find.text('Ubuntu - 24.0 - italic - w700'), findsOneWidget);
    final text = tester.widget<Text>(find.text('Preview'));
    expect(text.style!.fontFamily, 'Ubuntu');
    expect(text.style!.fontFamilyFallback, [kFallbackFont]);
  });

  testWidgets('multiple fonts render together for comparison', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FontPreviewList(
          text: 'Compare',
          fonts: [
            FontProvider.fromFontFamily('Ubuntu'),
            FontProvider.fromBuilder(
              (size, weight, style) => TextStyle(
                fontFamily: 'Raleway',
                fontSize: size,
                fontWeight: weight,
                fontStyle: style,
              ),
            ),
          ],
          previewSizes: const [16],
          fontWeights: const [FontWeight.w400],
          fontStyles: const [FontStyle.normal],
        ),
      ),
    );

    expect(find.byType(CompareFontsItem), findsOneWidget);
    expect(find.byType(FontPreviewItem), findsNothing);
    expect(find.text('Compare'), findsNWidgets(2));
    final texts = tester.widgetList<Text>(find.text('Compare')).toList();
    expect(texts.map((text) => text.style!.fontFamily), ['Ubuntu', 'Raleway']);
    for (final text in texts) {
      expect(text.style!.fontFamilyFallback, [kFallbackFont]);
    }
  });

  testWidgets('previewFonts pushes a route with default style combinations', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => FontPreview.previewFonts(
              context,
              previewText: 'Preview',
              fonts: [FontProvider.fromFontFamily('Ubuntu')],
            ),
            child: const Text('Open preview'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open preview'));
    await tester.pumpAndSettle();

    expect(find.byType(FontPreviewList), findsOneWidget);
    final list = tester.widget<ListView>(find.byType(ListView));
    expect(
      list.childrenDelegate.estimatedChildCount,
      kPreviewFontSizes.length *
          FontWeight.values.length *
          FontStyle.values.length,
    );

    Navigator.of(tester.element(find.byType(FontPreviewList))).pop();
    await tester.pumpAndSettle();
    expect(find.text('Open preview'), findsOneWidget);
    expect(find.byType(FontPreviewList), findsNothing);
  });

  testWidgets('fallback font is bundled with the package', (tester) async {
    final font = await rootBundle.load(
      'packages/font_preview/lib/src/assets/fallback_font/BungeeShade-Regular.ttf',
    );
    expect(font.lengthInBytes, greaterThan(0));
  });
}
