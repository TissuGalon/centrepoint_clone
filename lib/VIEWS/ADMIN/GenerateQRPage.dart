import 'dart:math';

import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/LoginPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/PROFILPAGE/EditProfilPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/level_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {
  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  bool isLoading = false;
  String qrData = '1234567890';

  Future<void> generateQR() async {
    setState(() {
      isLoading = true;
    });

    // Delay selama 2 detik untuk menunjukkan efek shimmer loading
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      qrData = generateRandomData();
      isLoading = false;
    });
  }

  String generateRandomData() {
    final random = Random();
    const length = 10;
    return List.generate(length, (index) => random.nextInt(10).toString())
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BG,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: const [
          Text(
            'GENERATE QR',
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
      body: ListView(
        children: [
          isLoading
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: buildShimmerWidget(200, 200),
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                ),
          Container(
            margin: EdgeInsets.all(5),
            child: TextButton(
              onPressed: generateQR,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Warna.Primary),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text(
                'Generate QR Code',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width, // Lebar sama dengan layar
        height: 50, // Sesuaikan tinggi sesuai kebutuhan
        margin: EdgeInsets.symmetric(
            horizontal: 10), // Jarak margin dari tepi layar
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilPage(),
              ),
            );
          },
          label: Row(
            children: [
              Icon(
                TablerIcons.pencil,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'EDIT PROFIL',
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Container buildUserTile({
  required BuildContext context,
  required Icon iconn,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(255, 235, 235, 235),
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      onTap: onTap,
      leading: iconn,
      title: Text(
        title,
        style: TextStyle(
          color: Warna.TextBold,
          fontFamily: 'Graphik',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Warna.TextBold,
          fontFamily: 'Graphik',
          fontSize: 14,
        ),
      ),
      tileColor: Warna.BG,
    ),
  );
}
