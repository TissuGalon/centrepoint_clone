import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/LoginPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/PROFILPAGE/MyProfile.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/level_page.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool isLoadingProfil = false;
  bool isLoading = false;
  Map<String, String?>? userData;

  Future<void> _loadUserData() async {
    setState(() {
      isLoadingProfil = true;
    });
    userData = await getLoginInfo();
    setState(() {
      isLoadingProfil = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  //IMAGE URL
  final List<String> imageUrls = [
    'assets/images/welcome_page/welcome.png',
    'assets/images/welcome_page/welcome(1).png',
    'assets/images/welcome_page/welcome(2).png',
    // Add more image URLs here
  ];
  //IMAGE URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BG,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isLoadingProfil
                      ? buildShimmerAvatar(50)
                      : CircleAvatar(
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
                        isLoadingProfil
                            ? buildShimmerWidget(double.infinity, 25)
                            : Text(
                                '${userData!['username']}'.toUpperCase(),
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
                        isLoadingProfil
                            ? buildShimmerWidget(double.infinity, 25)
                            : Container(
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
                        /* FOLLOW */
                        /*  Container(
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
                        ), */
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            /* ITEM */
            Column(
              children: [
                /* ITEM 1 */
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfilPage()),
                    );
                  },
                  leading: Icon(
                    TablerIcons.user,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    'Profil Saya',
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
                Divider(
                  color: const Color.fromARGB(255, 232, 232, 232),
                  thickness: 1,
                  height: 1,
                ),
                /* ITEM 2 */
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LevelPage()),
                    );
                  },
                  leading: Icon(
                    TablerIcons.rosette_discount_check_filled,
                    color: Colors.orange,
                  ),
                  title: Text(
                    'Level Anda',
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
                Divider(
                  color: const Color.fromARGB(255, 232, 232, 232),
                  thickness: 1,
                  height: 1,
                ),
                /*  ListTile(
                  onTap: () {},
                  leading: Icon(
                    TablerIcons.settings,
                    color: Colors.green,
                  ),
                  title: Text(
                    'Pengaturan',
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
                Divider(
                  color: const Color.fromARGB(255, 232, 232, 232),
                  thickness: 1,
                  height: 1,
                ), */
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                email: 'parzivalxdd@gmail.com',
                              )),
                    );
                  },
                  leading: Icon(
                    TablerIcons.logout,
                    color: Warna.Primary,
                  ),
                  title: Text(
                    'Logout',
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
                Divider(
                  color: const Color.fromARGB(255, 232, 232, 232),
                  thickness: 1,
                  height: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
