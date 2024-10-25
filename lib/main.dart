import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResumeScreen(),
    );
  }
}

class ResumeScreen extends StatelessWidget {
  Future<Uint8List> generateResume(PdfPageFormat format) async {
    final pdf = pw.Document();
    // final profileImage = pw.MemoryImage(
    //   (await rootBundle.load('assets/profile.jpg')).buffer.asUint8List(),
    // );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: format,
          margin: pw.EdgeInsets.all(32),
          theme: pw.ThemeData.withFont(
            base: await PdfGoogleFonts.openSansRegular(),
            bold: await PdfGoogleFonts.openSansBold(),
          ),
        ),
        build: (pw.Context context) => [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 100,
                height: 100,
                // child: pw.ClipOval(child: pw.Image(profileImage)),
              ),
              pw.SizedBox(width: 20),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Parnella Charlesbois',
                      style: pw.TextStyle(
                          fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Electrotyper', style: pw.TextStyle(fontSize: 18)),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      '568 Port Washington Road, Nordegg, AB T0M 2H0, Canada'),
                  pw.Text('+1 403-721-6898'),
                  pw.UrlLink(
                    destination: 'mailto:p.charlesbois@yahoo.com',
                    child: pw.Text('p.charlesbois@yahoo.com'),
                  ),
                  pw.UrlLink(
                    destination: 'https://wholeprices.ca',
                    child: pw.Text('wholeprices.ca'),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          _buildCategory('Work Experience'),
          _buildWorkBlock('Tour bus driver',
              'Laboris nostrud consectetur culpa labore magna adipiscing minim aute dolore. Dolore est nostrud sit dolore aute laboris exercitation enim, excepteur.'),
          _buildWorkBlock('Logging equipment operator',
              'Laboris nostrud consectetur culpa labore magna adipiscing minim aute dolore. Dolore est nostrud sit dolore aute laboris exercitation enim, excepteur.'),
          _buildWorkBlock('Foot doctor',
              'Laboris nostrud consectetur culpa labore magna adipiscing minim aute dolore. Dolore est nostrud sit dolore aute laboris exercitation enim, excepteur.'),
          _buildWorkBlock('Unicorn trainer',
              'Laboris nostrud consectetur culpa labore magna adipiscing minim aute dolore. Dolore est nostrud sit dolore aute laboris exercitation enim, excepteur.'),
          _buildWorkBlock('Chief chatter',
              'Laboris nostrud consectetur culpa labore magna adipiscing minim aute dolore. Dolore est nostrud sit dolore aute laboris exercitation enim, excepteur.'),
          pw.SizedBox(height: 20),
          _buildCategory('Education'),
          _buildEducationBlock(
              'Bachelor of Commerce', 'Details of education and achievements'),
          _buildEducationBlock('Bachelor Interior Design',
              'Details of education and achievements'),
        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildCategory(String title) {
    return pw.Container(
      padding: pw.EdgeInsets.symmetric(vertical: 8),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 20,
          color: PdfColors.green,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _buildWorkBlock(String title, String description) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Container(
              width: 6,
              height: 6,
              decoration: pw.BoxDecoration(
                color: PdfColors.green,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.SizedBox(width: 8),
            pw.Text(title,
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 14, top: 4),
          child: pw.Text(description, style: pw.TextStyle(fontSize: 12)),
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  pw.Widget _buildEducationBlock(String title, String details) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Container(
              width: 6,
              height: 6,
              decoration: pw.BoxDecoration(
                color: PdfColors.green,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.SizedBox(width: 8),
            pw.Text(title,
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 14, top: 4),
          child: pw.Text(details, style: pw.TextStyle(fontSize: 12)),
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Resume'),
      ),
      body: PdfPreview(
        build: (format) => generateResume(format),
      ),
    );
  }
}
