import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/component.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:modular_ui/modular_ui.dart'; // Import modular_ui

class UangKhasPage extends StatefulWidget {
  @override
  _UangKhasPageState createState() => _UangKhasPageState();
}

class _UangKhasPageState extends State<UangKhasPage> {
  bool isLoading = false;

  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
  }

  Map<int, List<UangKhas>> uangKhasDataByYear = {
    2023: [
      UangKhas(
          bulan: 'Januari',
          sudahBayar: true,
          tanggalBayar: DateTime(2023, 1, 10)),
      UangKhas(
          bulan: 'Februari',
          sudahBayar: true,
          tanggalBayar: DateTime(2023, 2, 15)),
      UangKhas(bulan: 'Maret', sudahBayar: false),
    ],
    2024: [
      UangKhas(
          bulan: 'Januari',
          sudahBayar: true,
          tanggalBayar: DateTime(2024, 1, 15)),
      UangKhas(
          bulan: 'Februari',
          sudahBayar: true,
          tanggalBayar: DateTime(2024, 2, 10)),
      UangKhas(bulan: 'Maret', sudahBayar: false),
      UangKhas(bulan: 'April', sudahBayar: false),
      UangKhas(
          bulan: 'Mei', sudahBayar: true, tanggalBayar: DateTime(2024, 5, 5)),
    ]
  };

  double getTotalBayarForYear(int year) {
    List<UangKhas> list = uangKhasDataByYear[year] ?? [];
    return list.where((e) => e.sudahBayar).length * 50000;
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
        title: Text(
          'UANG KHAS',
          style: TextStyle(
              color: Color(0xFF222222),
              fontFamily: 'URW',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        iconTheme: IconThemeData(
          color: Warna.TextBold,
        ),
      ),
      backgroundColor: Warna.BG,
      body: Column(
        children: [
          SizedBox(height: 0),
          /* DROPDOWN */
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400, width: 1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedYear,
                  hint: Text(
                    'Pilih Tahun',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: tahunOptions.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('Tahun $value'),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedYear = newValue;
                      });
                    }
                  },
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          /* DROPDOWN */

          ContainerSaya(
            borderRadius: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Uang Khas Dibayar - $selectedYear'),
                    Icon(TablerIcons.moneybag),
                  ],
                ),
                Text(
                  '${formatRupiah(getTotalBayarForYear(selectedYear))}',
                  style: TextStyle(
                      fontFamily: 'URW',
                      fontSize: 26,
                      color: Warna.Primary,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // List bulan dan status pembayaran

          Expanded(
            child: ContainerSaya(
              padding: 5,
              child: ListView.builder(
                itemCount: uangKhasDataByYear[selectedYear]?.length ?? 0,
                itemBuilder: (context, index) {
                  UangKhas item = uangKhasDataByYear[selectedYear]![index];
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
                              item.bulan,
                              style: TextStyle(
                                  fontFamily: 'URW',
                                  fontSize: 18,
                                  color: Warna.Primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.sudahBayar
                                  ? 'Sudah dibayar ()'
                                  : 'Belum dibayar',
                            ),
                          ],
                        ),
                        Text(item.sudahBayar
                            ? '${timeago.format(item.tanggalBayar!)}'
                            : '')
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

class UangKhas {
  final String bulan;
  final bool sudahBayar;
  final DateTime? tanggalBayar;

  UangKhas({
    required this.bulan,
    required this.sudahBayar,
    this.tanggalBayar,
  });
}
