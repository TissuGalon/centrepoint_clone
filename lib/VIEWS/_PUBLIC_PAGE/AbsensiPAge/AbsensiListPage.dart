import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/component.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:modular_ui/modular_ui.dart'; // Import modular_ui

class AbsensiListPage extends StatefulWidget {
  @override
  _AbsensiListPageState createState() => _AbsensiListPageState();
}

class _AbsensiListPageState extends State<AbsensiListPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> tahunOptions = List.generate(
      DateTime.now().year - 2023 + 1,
      (index) => 2023 + index,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Text(
            'List Absensi Rapat'.toUpperCase(),
            style: TextStyle(
                color: Color(0xFF222222),
                fontFamily: 'URW',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        iconTheme: IconThemeData(
          color: Warna.TextBold,
        ),
      ),
      backgroundColor: Warna.BG,
      body: Column(
        children: [
          ContainerSaya(
            child: Row(
              children: [Text('Absensi')],
            ),
          ),
          SizedBox(height: 0),
          Expanded(
            child: ContainerSaya(
              padding: 5,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromARGB(255, 230, 230, 230),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ttle',
                              style: TextStyle(
                                  fontFamily: 'URW',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontFamily: 'URW',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text('12/12/24')
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
