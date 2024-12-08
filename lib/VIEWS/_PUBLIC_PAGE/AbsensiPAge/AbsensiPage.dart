import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:flutter/material.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AbsensiPAge/AbsenCepat.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AbsensiPAge/AbsensiListPage.dart';

class AbsensiPage extends StatefulWidget {
  @override
  _AbsensiPageState createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  bool isLoadingProfil = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BG,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(8),
        child: ListView(
          children: [
            Column(
              children: [
                /* -- */
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AbsensiListPage()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/icon/3d-conference.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                'Absensi Rapat'.toUpperCase(),
                                style: TextStyle(
                                    color: Warna.TextBold,
                                    fontFamily: 'URW',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/icon/3d-tasks.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              'Absensi Kegiatan'.toUpperCase(),
                              style: TextStyle(
                                  color: Warna.TextBold,
                                  fontFamily: 'URW',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/icon/3d-house.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'ABSENSI SEKRET'.toUpperCase(),
                          style: TextStyle(
                              color: Warna.TextBold,
                              fontFamily: 'URW',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),

                /* -- */
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width, // Lebar sama dengan layar
        height: 70, // Sesuaikan tinggi sesuai kebutuhan
        margin: EdgeInsets.symmetric(
            horizontal: 10), // Jarak margin dari tepi layar
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AbsenCepat(),
              ),
            );
          },
          label: Row(
            children: [
              Icon(
                TablerIcons.qrcode,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'ABSEN CEPAT',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'URW',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
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
