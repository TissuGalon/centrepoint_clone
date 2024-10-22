import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';

class AbsenCepat extends StatefulWidget {
  @override
  _AbsenCepatState createState() => _AbsenCepatState();
}

class _AbsenCepatState extends State<AbsenCepat> {
  String qrText = "Scan QR Code untuk absen";
  bool isLoading = false;

  void _onDetect(BarcodeCapture barcode) {
    if (barcode.barcodes.isNotEmpty) {
      final String code =
          barcode.barcodes.first.rawValue ?? "QR Code tidak valid";
      setState(() {
        qrText = code;
        // Proses absensi
        _prosesAbsen(code);
      });
    }
  }

  void _prosesAbsen(String qrCode) {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        /* qrText = "Absensi berhasil!"; */
        qrText = qrCode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BG,
      appBar: AppBar(
        title: Text('Absen QR Code'),
        backgroundColor: Warna.Primary,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: MobileScanner(
              onDetect: _onDetect,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      qrText,
                      style: TextStyle(fontSize: 18, color: Warna.TextBold),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
