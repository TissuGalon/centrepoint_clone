import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageKegiatanPage extends StatefulWidget {
  @override
  _ManageKegiatanPageState createState() => _ManageKegiatanPageState();
}

class _ManageKegiatanPageState extends State<ManageKegiatanPage> {
  List<Map<String, dynamic>> activities = [];
  List<Map<String, dynamic>> attendanceCodes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    String? activitiesJson = prefs.getString('activities');
    String? attendanceJson = prefs.getString('attendanceCodes');

    // Data Awal jika SharedPreferences kosong
    if (activitiesJson == null && attendanceJson == null) {
      activities = [
        {
          "activity_id": "1",
          "name": "Rapat Bulanan wew",
          "date-start": "2024-11-22 04:03:00",
          "date-end": "2024-11-23 04:10:32",
          "jumlah_hari": null,
          "location": "Ruang Rapat A wew",
          "type": "rapat",
          "description": "Rapat bulanan untuk evaluasi kinerja. wew",
          "image": "",
          "status": "selesai",
          "created_by": "1",
          "created_at": "2024-10-19 18:41:19",
          "deleted_at": "2024-11-23 04:10:32",
          "view": "0"
        },
        {
          "activity_id": "2",
          "name": "Pelatihan Anggota Baru",
          "date-start": "2024-10-18 00:16:34",
          "date-end": "2024-11-23 04:11:18",
          "jumlah_hari": null,
          "location": "Ruang Pelatihan B",
          "type": "acara",
          "description": "Pelatihan untuk anggota baru.",
          "image": null,
          "status": "berlangsung",
          "created_by": "2",
          "created_at": "2024-10-19 18:41:19",
          "deleted_at": "2024-11-23 04:11:18",
          "view": "1"
        },
        {
          "activity_id": "3",
          "name": "Workshop Pemrograman",
          "date-start": "2024-10-18 00:16:34",
          "date-end": "2024-11-23 04:11:21",
          "jumlah_hari": null,
          "location": "Online",
          "type": "acara",
          "description": "Workshop tentang pemrograman terbaru.",
          "image": null,
          "status": "berlangsung",
          "created_by": "3",
          "created_at": "2024-10-19 18:41:19",
          "deleted_at": "2024-11-23 04:11:21",
          "view": "0"
        },
        {
          "activity_id": "4",
          "name": "Seminar Jaringan Komputer",
          "date-start": "2024-10-18 00:16:34",
          "date-end": "2024-11-23 04:11:23",
          "jumlah_hari": null,
          "location": "Ruang Seminar C",
          "type": "acara",
          "description": "Seminar tentang jaringan komputer.",
          "image": null,
          "status": "berlangsung",
          "created_by": "4",
          "created_at": "2024-10-19 18:41:19",
          "deleted_at": "2024-11-23 04:11:23",
          "view": "0"
        },
        {
          "activity_id": "5",
          "name": "Musyawarah Besar XII",
          "date-start": "2024-11-22 09:00:00",
          "date-end": "2024-11-24 17:00:00",
          "jumlah_hari": "3",
          "location": "Lt 3 Gedung Bisnis",
          "type": "acara",
          "description": "",
          "image": "",
          "status": "berlangsung",
          "created_by": "1",
          "created_at": "2024-11-23 03:42:06",
          "deleted_at": null,
          "view": "0"
        },
        {
          "activity_id": "6",
          "name": "Festival Technology Policy II",
          "date-start": "2024-09-28 08:44:00",
          "date-end": "2024-09-29 17:00:00",
          "jumlah_hari": "1",
          "location": "Gedung Utama",
          "type": "acara",
          "description": "",
          "image": "activity_6740f3cfaf485.png",
          "status": "selesai",
          "created_by": "1",
          "created_at": "2024-11-23 03:45:25",
          "deleted_at": null,
          "view": "0"
        },
        {
          "activity_id": "7",
          "name": "Test",
          "date-start": "2024-11-23 04:26:00",
          "date-end": "2024-11-23 04:35:38",
          "jumlah_hari": "4",
          "location": "",
          "type": "acara",
          "description": "test",
          "image": "",
          "status": "berlangsung",
          "created_by": "1",
          "created_at": "2024-11-23 04:26:19",
          "deleted_at": "2024-11-23 04:35:38",
          "view": "0"
        }
      ];
      attendanceCodes = [
        {
          "code_id": "1",
          "code": "ABC123",
          "activity_id": "1",
          "generated_by": "1",
          "created_at": "2024-10-20 08:00:00",
          "expires_at": "2024-10-21 10:00:00",
          "updated_at": null
        },
        {
          "code_id": "2",
          "code": "XYZ789",
          "activity_id": "2",
          "generated_by": "2",
          "created_at": "2024-10-22 08:00:00",
          "expires_at": "2024-10-22 10:30:00",
          "updated_at": null
        }
      ];
      await _saveData(); // Simpan data awal ke SharedPreferences
    } else {
      setState(() {
        activities = activitiesJson != null
            ? List<Map<String, dynamic>>.from(jsonDecode(activitiesJson))
            : [];
        attendanceCodes = attendanceJson != null
            ? List<Map<String, dynamic>>.from(jsonDecode(attendanceJson))
            : [];
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('activities', jsonEncode(activities));
    await prefs.setString('attendanceCodes', jsonEncode(attendanceCodes));
  }

  String? _getAttendanceCode(String activityId) {
    final code = attendanceCodes.firstWhere(
      (code) => code['activity_id'] == activityId,
      orElse: () => {},
    );
    return code.isNotEmpty ? code['code'] : null;
  }

  void _generateAttendanceCode(String activityId) async {
    final String newCode = 'CODE-${Random().nextInt(10000)}';
    setState(() {
      attendanceCodes.add({
        'code_id': Random().nextInt(10000).toString(),
        'code': newCode,
        'activity_id': activityId,
      });
    });
    await _saveData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kode absensi berhasil dibuat: $newCode'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showAddActivityModal() {
    String name = '';
    String dateStart = '';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nama Kegiatan'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: 'Tanggal Mulai (YYYY-MM-DD)'),
                onChanged: (value) {
                  dateStart = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    activities.add({
                      'activity_id': Random().nextInt(10000).toString(),
                      'name': name,
                      'date_start': dateStart,
                    });
                  });
                  await _saveData();
                  Navigator.pop(context);
                },
                child: Text('Tambah Kegiatan'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'MANAGE KEGIATAN',
          style: TextStyle(color: Color(0xFF222222)),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            final activityId = activity['activity_id'];
            final code = _getAttendanceCode(activityId);

            return Card(
              color: Colors.white,
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ExpansionTile(
                leading: Icon(TablerIcons.file),
                title: Text(activity['name'] ?? 'No Title'),
                subtitle: Text(activity['date_start'] ?? ''),
                children: [
                  if (code != null)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          QrImageView(
                            data: code,
                            version: QrVersions.auto,
                            size: 150.0,
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Tidak ada kode absensi",
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () =>
                                _generateAttendanceCode(activityId),
                            child: Text('Generate Code Baru'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddActivityModal,
        label: Row(
          children: [
            Icon(TablerIcons.plus, color: Colors.white),
            SizedBox(width: 5),
            Text('Tambah Kegiatan'),
          ],
        ),
        backgroundColor: Warna.Primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
