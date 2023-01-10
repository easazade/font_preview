import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_preview/font_preview.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Font Preview',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.ralewayTextTheme(),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Font Preview Example'),
      ),
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
              child: Text('Comapre Fonts'),
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
              child: Text('Preview Single google font (poppins)'),
            ),
            ElevatedButton(
              onPressed: () {
                FontPreview.previewFonts(
                  context,
                  previewText: 'Flutter is Great',
                  fonts: [
                    FontProvider.fromFontFamily('Ubuntu'),
                  ],
                  fontStyles: [FontStyle.normal],
                );
              },
              child: Text('Preview Single custom font (ubuntu)'),
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
              child: Text('Font without font files for different styles'),
            ),
          ],
        ),
      ),
    );
  }
}
