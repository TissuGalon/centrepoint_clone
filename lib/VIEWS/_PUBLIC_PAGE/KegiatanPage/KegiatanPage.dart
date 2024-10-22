import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/KegiatanPage/KegiatanDetails.dart';

class KegiatanPage extends StatefulWidget {
  @override
  _KegiatanPageState createState() => _KegiatanPageState();
}

class _KegiatanPageState extends State<KegiatanPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Text(
            'KEGIATAN',
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
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Warna.Primary,
                      indicatorColor: Warna.Primary,
                      tabs: [
                        Tab(
                          icon: Icon(TablerIcons.hourglass),
                          text: 'BERLANGSUNG',
                        ),
                        Tab(
                          icon: Icon(TablerIcons.list_check),
                          text: 'SELESAI',
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return buildKegiatanCard(
                                imageUrl:
                                    'https://ftp.ukmpolicy.org/wp-content/uploads/2024/08/cropped-ICON-bg.png',
                                title: 'FTP (Festival Technology POLICY)',
                                context: context,
                                destinationPage: KegiatanDetails(),
                              );
                            },
                          ),
                          /* ------------ */
                          ListView.builder(
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return buildKegiatanCard(
                                imageUrl:
                                    'https://ftp.ukmpolicy.org/wp-content/uploads/2024/08/cropped-ICON-bg.png',
                                title: 'FTP (Festival Technology POLICY)',
                                context: context,
                                destinationPage: KegiatanDetails(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildKegiatanCard({
  required String imageUrl,
  required String title,
  required BuildContext context,
  required Widget destinationPage,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationPage),
      );
    },
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 246, 246, 246),
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      buildShimmerWidget(double.infinity, double.infinity),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'AwanZaman',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '08 Oktober 2024',
                  style: TextStyle(
                      color: Warna.TextBold, fontFamily: 'URW', fontSize: 12),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Warna.Primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Sedang Berlangsung',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'URW', fontSize: 9),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(TablerIcons.chevron_right),
          ),
        ],
      ),
    ),
  );
}
