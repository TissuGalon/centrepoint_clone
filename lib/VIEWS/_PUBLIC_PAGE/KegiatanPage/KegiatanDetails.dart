import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/BrowserOpener.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/MembersPage/members_detail.dart';

class KegiatanDetails extends StatefulWidget {
  @override
  _KegiatanDetailsState createState() => _KegiatanDetailsState();
}

class _KegiatanDetailsState extends State<KegiatanDetails> {
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
            'DETAIL KEGIATAN',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        /* 'https://cdn.inflact.com/media/460813122_1369742997763244_3057270999102729179_n.jpg?url=https%3A%2F%2Fscontent.cdninstagram.com%2Fv%2Ft51.29350-15%2F460813122_1369742997763244_3057270999102729179_n.jpg%3Fstp%3Ddst-jpg_e35_p1080x1080%26_nc_ht%3Dscontent.cdninstagram.com%26_nc_cat%3D108%26_nc_ohc%3DthOILNsU4OcQ7kNvgEkeJpf%26_nc_gid%3D5ddeb8d249ed40a38e8d837f1c74c7ea%26edm%3DAPs17CUBAAAA%26ccb%3D7-5%26ig_cache_key%3DMzQ2NDc5NDczMzYwNzMwMjU2NA%253D%253D.3-ccb7-5%26oh%3D00_AYBxuLwugy5_SAunjeVZ6f4ULxM_BadJGPudOOzYyPrlgw%26oe%3D67148C5F%26_nc_sid%3D10d13b&time=1729011600&key=6a7ecd38773fe743fd0b445a7a47c4db', */
                        'https://ftp.ukmpolicy.org/wp-content/uploads/2024/08/cropped-ICON-bg.png',
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 50,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => buildShimmerAvatar(50),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Festival Technology Policy 2 (FTP 2)',
                          style: TextStyle(
                              color: Warna.TextBold,
                              fontFamily: 'Graphik',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 12, top: 3, bottom: 3, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Rapat',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        /* BADGE 2 */
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Panitia',
                                    style: TextStyle(
                                        color: Warna.TextBold,
                                        fontFamily: 'Graphik',
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '20',
                                    style: TextStyle(
                                        color: Warna.Primary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Graphik',
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                height: 20,
                                width: 1,
                                color: const Color.fromARGB(255, 232, 232, 232),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Peserta',
                                    style: TextStyle(
                                        color: Warna.TextBold,
                                        fontFamily: 'Graphik',
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '80',
                                    style: TextStyle(
                                        color: Warna.Primary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Graphik',
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /* DESKRIPSI */
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ExpansionTile(
                textColor: Warna.Primary,
                title: Text('Deskripsi'.toUpperCase()),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text('Deskripsi'.toUpperCase()),
                        Divider(),
                        Text(
                            'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad sunt voluptates dolorem nobis distinctio molestiae mollitia omnis deserunt, voluptatum laborum, quibusdam, quis atque debitis illo voluptate recusandae sequi praesentium. Ab!'),
                        SizedBox(
                          height: 25,
                        ),
                        Text('Tautan'.toUpperCase()),
                        Divider(),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                tileColor: Warna.BG,
                                title: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.white),
                                    foregroundColor:
                                        WidgetStatePropertyAll(Warna.TextBold),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BrowserOpener(
                                          url:
                                              'https://docs.google.com/document/d/1ReQ2rQlA7_ONurZEOxcFSDD7AOicwd6PIlkzdnxR-qU/edit?usp=sharing',
                                        ),
                                      ),
                                    );
                                  },
                                  label: Text('Rab Sie Pubdok'),
                                  icon: Icon(TablerIcons.link),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            /* DESKRIPSI */
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Warna.Primary,
                      indicatorColor: Warna.Primary,
                      tabs: [
                        Tab(
                          icon: Icon(TablerIcons.users),
                          text: 'PANITIA',
                        ),
                        Tab(
                          icon: Icon(TablerIcons.checklist),
                          text: 'KEHADIRAN',
                        ),
                        Tab(
                          icon: Icon(TablerIcons.calendar_clock),
                          text: 'SCHEDULE',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.5,
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return buildMemberCard(
                                name: 'Members Name',
                                badgeIcon: TablerIcons.user,
                                badgeText: 'Member',
                                imagePath: 'assets/images/me.jpeg',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MembersDetail(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          /* ISI KEHADIRAN */
                          DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(
                                  labelColor: Warna.Success,
                                  indicatorColor: Warna.Success,
                                  tabs: [
                                    Tab(
                                      icon: Icon(TablerIcons.users),
                                      text: 'PANITIA',
                                    ),
                                    Tab(
                                      icon: Icon(TablerIcons.checklist),
                                      text: 'PESERTA',
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      ListView.builder(
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return buildMemberCard(
                                            name: 'Members Name',
                                            badgeIcon: TablerIcons.user,
                                            badgeText: 'Member',
                                            imagePath: 'assets/images/me.jpeg',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MembersDetail(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      ListView.builder(
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return buildMemberCard(
                                            name: 'Members Name',
                                            badgeIcon: TablerIcons.user,
                                            badgeText: 'Member',
                                            imagePath: 'assets/images/me.jpeg',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MembersDetail(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /* ISI KEHADIRAN */
                          ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ScheduleCard(
                                time: '08:00 - 09:00',
                                event: 'Pembukaan',
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
          ],
        ),
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

class ScheduleCard extends StatelessWidget {
  final String time;
  final String event;

  ScheduleCard({required this.time, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        leading: Icon(Icons.access_time),
        title: Text(event,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle:
            Text(time, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
      ),
    );
  }
}

Widget buildMemberCard({
  required String name,
  required String imagePath,
  required String badgeText,
  required IconData badgeIcon,
  required VoidCallback onPressed,
  Color badgeColor = Colors.blueGrey,
  Color badgeTextColor = Colors.white,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              CachedNetworkImage(
                imageUrl: '',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 25,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => buildShimmerAvatar(25),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/icon/man.png'),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toUpperCase(),
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontFamily: 'Graphik',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeColor, // Warna badge dinamis
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          badgeIcon,
                          color: badgeTextColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          badgeText,
                          style: TextStyle(
                            color: badgeTextColor,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 3),
            child: Icon(TablerIcons.chevron_right),
          )
        ],
      ),
    ),
  );
}
