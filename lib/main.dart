import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _scannedDocuments;

  Future<void> scanDocument() async {
    dynamic scannedDocuments;
    try {
      scannedDocuments = await FlutterDocScanner().getScanDocuments() ??
          'Unknown platform documents';
    } on PlatformException {
      scannedDocuments = 'Failed to get scanned documents.';
    }
    print(scannedDocuments.toString());
    if (!mounted) return;
    setState(() {
      _scannedDocuments = scannedDocuments;
    });
  }

  Future<void> scanDocumentUri() async {
    dynamic scannedDocuments;
    try {
      scannedDocuments = await FlutterDocScanner().getScanDocumentsUri() ??
          'Unknown platform documents';
    } on PlatformException {
      scannedDocuments = 'Failed to get scanned documents.';
    }
    print(scannedDocuments.toString());
    if (!mounted) return;
    setState(() {
      _scannedDocuments = scannedDocuments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Document Scanner example app'),
        ),
        body: Center(
          child: Column(
            children: [
              _scannedDocuments != null
                  ? Text(_scannedDocuments.toString())
                  : const Text("No Documents Scanned"),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    scanDocument();
                  },
                  child: const Text("Scan Documents"),
                ),
              ),
Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    scanDocumentUri();
                  },
                  child: const Text("Get Scan Documents URI"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
