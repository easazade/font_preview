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
                  text: 'Flutter is Great',
                  fonts: [
                    FontDetails.fromFontFamily('Poppins'),
                    FontDetails.fromBuilder(
                      (fontSize, fontWeight, fontStyle) => GoogleFonts.raleway(
                        fontSize: fontSize,
                        fontStyle: fontStyle,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ],
                  fontStyles: [FontStyle.normal],
                );
              },
              child: Text('Preview Single Font'),
            ),
          ],
        ),
      ),
    );
  }
}
