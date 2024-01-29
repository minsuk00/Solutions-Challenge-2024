import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:test/backend/cloud_functions/pamphlets.dart';

class PdfViewPage extends StatefulWidget {
  final url;
  const PdfViewPage({super.key, required this.url});

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  String? localPath;

  @override
  void initState() {
    getPamphletPdf(widget.url).then((value) {
      setState(() {
        localPath = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: localPath != null
          ? Expanded(
              child: PDFView(
                filePath: localPath,
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
