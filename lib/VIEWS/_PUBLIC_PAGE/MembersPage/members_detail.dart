import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:flutter/material.dart';

class MembersDetail extends StatefulWidget {
  @override
  _MembersDetailState createState() => _MembersDetailState();
}

class _MembersDetailState extends State<MembersDetail> {
  @override
  void initState() {
    super.initState();
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
            'MEMBERS DETAIL',
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*  CachedNetworkImage(
                    imageUrl:
                        'https://cdn3d.iconscout.com/3d/premium/thumb/newspaper-3d-icon-download-in-png-blend-fbx-gltf-file-formats--newsletter-news-press-media-entertainment-pack-multimedia-icons-4756479.png',
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 50,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => buildShimmerAvatar(50),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.error),
                    ),
                  ), */
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/icon/man.png'),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Member Name',
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
                        /* BADGE 1 */
                        Container(
                          padding: EdgeInsets.only(
                              left: 12, top: 3, bottom: 3, right: 3),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Member Silver',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                TablerIcons.chevron_right,
                                color: Colors.white,
                              )
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
                                    'Pengikut',
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
                                    '2',
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
                                    'Mengikuti',
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
                                    '2',
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
            Expanded(
              child: Container(
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
                            icon: Icon(TablerIcons.user),
                          ),
                          Tab(
                            icon: Icon(TablerIcons.badge),
                          ),
                          Tab(
                            icon: Icon(TablerIcons.list_check),
                          ),
                        ],
                      ),
                      Expanded(
                        // Tambahkan Expanded di sini
                        child: TabBarView(
                          children: [
                            Center(child: Text('Segera Hadir')),
                            Center(child: Text('Segera Hadir')),
                            Center(child: Text('Segera Hadir')),
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
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 25,
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
