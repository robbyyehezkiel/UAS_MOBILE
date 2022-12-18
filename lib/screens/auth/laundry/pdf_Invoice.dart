// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:laundry_admin/screens/auth/laundry/pdf_Api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(data) async {
    final myTheme = ThemeData.withFont(
      base: Font.ttf(
          await rootBundle.load("assets/OpenSans/OpenSans-Regular.ttf")),
      bold:
          Font.ttf(await rootBundle.load("assets/OpenSans/OpenSans-Bold.ttf")),
      italic: Font.ttf(
          await rootBundle.load("assets/OpenSans/OpenSans-Italic.ttf")),
      boldItalic: Font.ttf(
          await rootBundle.load("assets/OpenSans/OpenSans-BoldItalic.ttf")),
    );

    final pdf = Document(
      theme: myTheme,
    );

    // final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(data),
        ],
      ),
    );

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.mm),
        ],
      );
}
