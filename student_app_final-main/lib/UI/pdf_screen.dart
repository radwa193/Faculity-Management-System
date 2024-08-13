import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatefulWidget {
  final String filePath;

  const PdfViewerScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: const Color(0xffEF7505),
      ),
      body: PDFView(
        filePath: widget.filePath,
        onViewCreated: (PDFViewController controller) {
          _pdfViewController = controller;
        },
        onPageChanged: (int? page, int? total) {
          print('page change: $page/$total');
        },
        onError: (error) {
          print('Error displaying PDF: $error');
        },
      ),
    );
  }
}
