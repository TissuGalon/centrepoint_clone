import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/BrowserOpener.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/CompreDetect.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/CompreLogs.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/CompreSetting.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/CompreUSers.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/DocumentScanner.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/ManageKegiatanPage.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/GenerateQRPage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CompreFaceAdmin extends StatefulWidget {
  @override
  _CompreFaceAdminState createState() => _CompreFaceAdminState();
}

class _CompreFaceAdminState extends State<CompreFaceAdmin> {
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
            'COMPREFACE ADMIN',
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
                        builder: (context) => CompreUsersScreen(),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.users,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'CompreFace Users',
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
                        builder: (context) => CompreDetect(),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.face_id,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'CompreFace Detect',
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
                        builder: (context) => Comprelogs(),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.logs,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'CompreFace Logs',
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
                        builder: (context) => CompreSettingPage(),
                      ),
                    );
                  },
                  leading: Icon(
                    TablerIcons.settings,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'CompreFace Setting',
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
