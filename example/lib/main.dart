import 'package:flutter/material.dart';
import 'package:font_preview/font_preview.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Font Preview',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Font Preview Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                FontPreview.previewFonts(
                  context,
                  previewText: 'Flutter is Great',
                  fonts: [
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
                    FontProvider.fromFontFamily('Unknown Font'),
                  ],
                  fontStyles: [FontStyle.normal],
                );
              },
              child: const Text('Compare Fonts'),
            ),
            ElevatedButton(
              onPressed: () {
                FontPreview.previewFonts(
                  context,
                  previewText: 'Flutter is Great',
                  fonts: [
                    FontProvider.fromBuilder(
                      (fontSize, fontWeight, fontStyle) => GoogleFonts.poppins(
                        fontSize: fontSize,
                        fontStyle: fontStyle,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ],
                  fontStyles: [FontStyle.normal],
                );
              },
              child: const Text('Preview Single google font (poppins)'),
            ),
            ElevatedButton(
              onPressed: () {
                FontPreview.previewFonts(
                  context,
                  previewText: 'Flutter is Great',
                  fonts: [FontProvider.fromFontFamily('Ubuntu')],
                  fontStyles: [FontStyle.normal],
                  fontWeights: [FontWeight.w400, FontWeight.w700],
                  previewSizes: [11.0, 12.0, 14.0, 16.0, 18.0, 22.0],
                );
              },
              child: const Text('Preview Single custom font (ubuntu)'),
            ),
            ElevatedButton(
              onPressed: () {
                FontPreview.previewFonts(
                  context,
                  previewText:
                      'Google Font without all font style files - (acme)',
                  fonts: [
                    FontProvider.fromBuilder(
                      (fontSize, fontWeight, fontStyle) => GoogleFonts.acme(
                        fontSize: fontSize,
                        fontStyle: fontStyle,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ],
                  fontStyles: [FontStyle.normal],
                );
              },
              child: const Text('Google Fonts acme'),
            ),
          ],
        ),
      ),
    );
  }
}
