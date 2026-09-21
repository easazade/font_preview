import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_preview/font_preview.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUp(() {
    // Keep smoke tests independent of network access.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  tearDown(() {
    GoogleFonts.config.allowRuntimeFetching = true;
  });

  testWidgets('example shows all preview actions', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Font Preview Example'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(4));
    expect(find.text('Compare Fonts'), findsOneWidget);
  });

  testWidgets('bundled custom font preview opens and closes', (tester) async {
    await tester.pumpWidget(const App());
    await tester.tap(find.text('Preview Single custom font (ubuntu)'));
    await tester.pumpAndSettle();

    expect(find.byType(FontPreviewList), findsOneWidget);
    expect(find.text('Flutter is Great'), findsWidgets);
    expect(tester.takeException(), isNull);

    Navigator.of(tester.element(find.byType(FontPreviewList))).pop();
    await tester.pumpAndSettle();
    expect(find.text('Font Preview Example'), findsOneWidget);
  });
}
