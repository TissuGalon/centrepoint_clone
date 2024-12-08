import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/BrowserOpener.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/CompreSetting.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/DocumentScanner.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/ManageKegiatanPage.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/GenerateQRPage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AdminAppsPage extends StatefulWidget {
  @override
  _AdminAppsPageState createState() => _AdminAppsPageState();
}

class _AdminAppsPageState extends State<AdminAppsPage> {
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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                /* ITEM */
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompreFaceAdmin(),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.face_id,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'CompreFace Admin',
                    style: TextStyle(
                      color: Warna.TextBold,
                      fontFamily: 'Graphik',
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    TablerIcons.chevron_right,
                    color: Warna.TextBold,
                  ),
                  tileColor: Warna.BG,
                ),
                /* ITEM */
                /* ITEM */
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageKegiatanPage(),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.qrcode,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'Generate Absen',
                    style: TextStyle(
                      color: Warna.TextBold,
                      fontFamily: 'Graphik',
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    TablerIcons.chevron_right,
                    color: Warna.TextBold,
                  ),
                  tileColor: Warna.BG,
                ),
                /* ITEM */
                /* ITEM */
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenerateQRPage(),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.qrcode,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'Generate QR',
                    style: TextStyle(
                      color: Warna.TextBold,
                      fontFamily: 'Graphik',
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    TablerIcons.chevron_right,
                    color: Warna.TextBold,
                  ),
                  tileColor: Warna.BG,
                ),
                /* ITEM */
                /* ITEM */
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentScannerPage(),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.scan,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'Document Scanner',
                    style: TextStyle(
                      color: Warna.TextBold,
                      fontFamily: 'Graphik',
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    TablerIcons.chevron_right,
                    color: Warna.TextBold,
                  ),
                  tileColor: Warna.BG,
                ),
                /* ITEM */
                /* ITEM */
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrowserOpener(
                          url: 'https://chatgpt.com/',
                        ),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.ai,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'ChatGPT',
                    style: TextStyle(
                      color: Warna.TextBold,
                      fontFamily: 'Graphik',
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    TablerIcons.chevron_right,
                    color: Warna.TextBold,
                  ),
                  tileColor: Warna.BG,
                ),
                /* ITEM */

                Divider(
                  color: const Color.fromARGB(255, 232, 232, 232),
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
