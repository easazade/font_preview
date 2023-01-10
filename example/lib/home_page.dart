import 'package:flutter/material.dart';
import 'package:font_preview/font_preview.dart';
import 'package:google_fonts/google_fonts.dart'; // Raleway fonts are included

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
              child: Text('Preview Single font'),
            ),
            ElevatedButton(
              onPressed: () {
                FontPreview.previewFonts(
                  context,
                  previewText: 'Google Font without all font style files - (acme)',
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
              child: Text('Preview Single font'),
            ),
          ],
        ),
      ),
    );
  }
}
