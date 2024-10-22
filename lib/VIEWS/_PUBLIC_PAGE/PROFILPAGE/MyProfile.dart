import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/LoginPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/PROFILPAGE/EditProfilPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/level_page.dart';

class MyProfilPage extends StatefulWidget {
  @override
  _MyProfilPageState createState() => _MyProfilPageState();
}

class _MyProfilPageState extends State<MyProfilPage> {
  bool isLoadingProfil = false;
  bool isLoading = false;
  Map<String, String?>? userData;

  Future<void> _loadUserData() async {
    setState(() {
      isLoadingProfil = true;
    });
    userData = await getLoginInfo(); // Memuat data user dari AuthProcess.dart
    setState(() {
      isLoadingProfil = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
            'MY PROFILE',
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
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // User Profile Container
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
                          backgroundImage: AssetImage('assets/icon/man.png')
                              as ImageProvider,
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
                                '${userData!['username'] ?? 'Unknown User'}'
                                    .toUpperCase(),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            // ListView.builder
            Expanded(
              child: ListView(
                children: [
                  /* ITEM */
                  buildUserTile(
                    context: context,
                    title: 'Username',
                    subtitle: userData!['username'] ?? '-',
                    iconn: Icon(
                      TablerIcons.user,
                      color: Warna.Primary,
                    ),
                    onTap: () {},
                  ),
                  /* ITEM */
                  /* ITEM */
                  buildUserTile(
                    context: context,
                    title: 'Fullname',
                    subtitle: userData!['fullname'] ?? '-',
                    iconn: Icon(
                      TablerIcons.user,
                      color: Warna.Primary,
                    ),
                    onTap: () {},
                  ),
                  /* ITEM */
                  /* ITEM */
                  buildUserTile(
                    context: context,
                    title: 'Email',
                    subtitle: userData!['email'] ?? '-',
                    iconn: Icon(
                      TablerIcons.mail,
                      color: Warna.Primary,
                    ),
                    onTap: () {},
                  ),
                  /* ITEM */
                  /* ITEM */
                  buildUserTile(
                    context: context,
                    title: 'Gender',
                    subtitle: userData!['gender'] ?? '-',
                    iconn: Icon(
                      TablerIcons.gender_male,
                      color: Warna.Primary,
                    ),
                    onTap: () {},
                  ),
                  /* ITEM */
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width, // Lebar sama dengan layar
        height: 50, // Sesuaikan tinggi sesuai kebutuhan
        margin: EdgeInsets.symmetric(
            horizontal: 10), // Jarak margin dari tepi layar
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilPage(),
              ),
            );
          },
          label: Row(
            children: [
              Icon(
                TablerIcons.pencil,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'EDIT PROFIL',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'URW',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
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

Container buildUserTile({
  required BuildContext context,
  required Icon iconn,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(255, 235, 235, 235),
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      onTap: onTap,
      leading: iconn,
      title: Text(
        title,
        style: TextStyle(
          color: Warna.TextBold,
          fontFamily: 'Graphik',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Warna.TextBold,
          fontFamily: 'Graphik',
          fontSize: 14,
        ),
      ),
      tileColor: Warna.BG,
    ),
  );
}
