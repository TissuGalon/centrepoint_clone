import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/component.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:policy_centrepoint/CONTROLLER/PointController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:convert';

class LevelPage extends StatefulWidget {
  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  bool isLoading = true;
  int totalPoints = 0; // Variabel untuk menyimpan total poin
  List<dynamic> pointsHistory = []; // Variabel untuk menyimpan riwayat poin

  @override
  void initState() {
    super.initState();
    fetchUserPoints(); // Panggil fungsi untuk mengambil total poin dan riwayat poin
  }

  Future<void> fetchUserPoints() async {
    setState(() {
      isLoading =
          true; // Set loading menjadi true saat memulai pengambilan data
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId =
          prefs.getString('user_id'); // Ambil user_id dari shared preferences

      if (userId != null) {
        totalPoints = await getUserPoints(userId) ?? 0; // Ambil total poin
        pointsHistory =
            await getUserPointsHistory(userId) ?? []; // Ambil riwayat poin
      } else {
        print('User ID is null.'); // Handle kasus jika userId tidak ditemukan
      }
    } catch (e) {
      print('Error fetching user points: $e');
    } finally {
      setState(() {
        isLoading =
            false; // Set loading menjadi false setelah data diambil atau jika ada error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Text(
            'LEVEL SAYA',
            style: TextStyle(
                color: Color(0xFF222222),
                fontFamily: 'URW',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(width: 10),
        ],
        iconTheme: IconThemeData(
          color: Warna.TextBold, // Change the drawer icon color here
        ),
      ),
      backgroundColor: Warna.BG,
      body: isLoading
          ? CentrepointLoading(
              color: Warna.Primary,
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: EdgeInsets.only(left: 8, right: 8, top: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'POIN SAYA',
                        style: TextStyle(
                            color: Color(0xFF222222),
                            fontFamily: 'URW',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Row(
                        children: [
                          Icon(
                            TablerIcons.carambola_filled,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 5),
                          Text(
                            ' $totalPoints',
                            style: TextStyle(
                                color: Warna.Primary,
                                fontFamily: 'URW',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            ' POIN',
                            style: TextStyle(
                                color: Color(0xFF222222),
                                fontFamily: 'URW',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.all(8),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Riwayat Poin Anda',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'Graphik',
                            fontSize: 14),
                      ),
                      Icon(
                        TablerIcons.chevrons_down,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListView.builder(
                      itemCount: pointsHistory.length,
                      itemBuilder: (context, index) {
                        final historyItem = pointsHistory[index];
                        return Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color.fromARGB(255, 234, 238, 240),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    TablerIcons.carambola_filled,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        historyItem[
                                            'reason'], // Ambil alasan dari riwayat
                                        style: TextStyle(
                                          color: Color(0xFF222222),
                                          fontFamily: 'Graphik',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${historyItem['points_change']} Poin', // Ambil poin dari riwayat
                                        style: TextStyle(
                                          color: historyItem['change_type'] ==
                                                  'tambah'
                                              ? Colors.green
                                              : Colors
                                                  .red, // Ubah warna berdasarkan change_type
                                          fontFamily: 'Graphik',
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                '${timeago.format(DateTime.parse(historyItem['created_at']), locale: 'en_short')}', // Format tanggal dari riwayat
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontFamily: 'URW',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
