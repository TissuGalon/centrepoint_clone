import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';

class DocumentScannerPage extends StatefulWidget {
  @override
  _DocumentScannerPageState createState() => _DocumentScannerPageState();
}

class _DocumentScannerPageState extends State<DocumentScannerPage> {
  bool isLoading = false;
  String scannedText = '';
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer();

  Future<void> scanTextFromImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      final inputImage = InputImage.fromFile(File(pickedFile.path));

      try {
        final RecognizedText recognizedText =
            await _textRecognizer.processImage(inputImage);
        setState(() {
          scannedText = recognizedText.text;
        });
      } catch (e) {
        setState(() {
          scannedText = 'Error: $e';
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: const [
          Text(
            'DOCUMENT SCANNER',
            style: TextStyle(
                color: Color(0xFF222222),
                fontFamily: 'URW',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            width: 10,
          )
        ],
        iconTheme: IconThemeData(
          color: Warna.TextBold, // Mengubah warna ikon drawer
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: scannedText.isEmpty
                        ? Text("Scan an image to extract text")
                        : SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                scannedText,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width:
                  MediaQuery.of(context).size.width, // Lebar sama dengan layar
              height: 50, // Sesuaikan tinggi sesuai kebutuhan
              margin: EdgeInsets.symmetric(
                  horizontal: 10), // Jarak margin dari tepi layar
              child: FloatingActionButton.extended(
                onPressed: scanTextFromImage,
                label: Row(
                  children: [
                    Icon(
                      TablerIcons.scan,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'SCAN DOCUMENT',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'URW',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                backgroundColor: Warna.Primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
