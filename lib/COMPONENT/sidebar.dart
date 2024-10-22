import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
/* import 'package:awesome_dialog/awesome_dialog.dart'; */
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/CONTROLLER/StyleController.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/LoginPage.dart';

class SideBar extends StatelessWidget {
  final String role;

  SideBar({required this.role});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Warna.Primary,
              ),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*   Container(
                      margin: const EdgeInsets.all(5),
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/me.jpeg'), // Replace with your image asset path
                      ),
                    ), */
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        color: Warna.Secondary,
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: _getMenuItemsByRole(role, screenHeight, context),
                ),
              ),
            ),
            const Divider(),
            // Footer item
            ListTile(
              title: const Text(
                'v Beta 0.0.1',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                // Handle footer item tap
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getMenuItemsByRole(
      String role, double screenHeight, BuildContext context) {
    switch (role) {
      case 'umum':
        return _masyarakatMenuItems(screenHeight, context);
      case 'instansi':
        return _instansiMenuItems(screenHeight, context);
      case 'petugas':
        return _petugasMenuItems(screenHeight, context);
      default:
        return [];
    }
  }

  List<Widget> _masyarakatMenuItems(double screenHeight, BuildContext context) {
    return [
      /*  _buildListTile(
        icon: TablerIcons.user,
        text: 'Profil Saya',
        onTap: () {},
        screenHeight: screenHeight,
      ), */
      const Divider(),
      _buildListTile(
        icon: Icons.logout,
        text: 'Keluar',
        onTap: () {
          showLogoutDialog(context);
        },
        screenHeight: screenHeight,
      ),
    ];
  }

  List<Widget> _instansiMenuItems(double screenHeight, BuildContext context) {
    return [
      /*  _buildListTile(
        icon: TablerIcons.user,
        text: 'Profil Saya',
        onTap: () {},
        screenHeight: screenHeight,
      ), */
      const Divider(),
      _buildListTile(
        icon: Icons.logout,
        text: 'Keluar',
        onTap: () {
          showLogoutDialog(context);
        },
        screenHeight: screenHeight,
      ),
    ];
  }

  List<Widget> _petugasMenuItems(double screenHeight, BuildContext context) {
    return [
      /*     _buildListTile(
        icon: TablerIcons.user,
        text: 'Profil Saya',
        onTap: () {},
        screenHeight: screenHeight,
      ), */
      const Divider(),
      _buildListTile(
        icon: Icons.logout,
        text: 'Keluar',
        onTap: () {
          showLogoutDialog(context);
        },
        screenHeight: screenHeight,
      ),
    ];
  }

  Widget _buildListTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required double screenHeight,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Warna.Primary,
        size: 28,
      ),
      title: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Warna.TextBold,
          fontFamily: 'URW',
          fontSize: screenHeight * 0.021,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  void showLogoutDialog(BuildContext context) {
    clearLoginInfo();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          email: '',
        ),
      ),
    );
  }
}
