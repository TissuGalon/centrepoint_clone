import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/component.dart';
import 'package:policy_centrepoint/COMPONENT/sidebar.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/CONTROLLER/PointController.dart';
import 'package:policy_centrepoint/SQLiteTEST/SQLiteTEST.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/APPSPAGE/AppsPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/LoginPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AbsensiPAge/AbsensiPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/BeritaPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/homepage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/PROFILPAGE/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POLICY - CENTREPOINT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Warna.Primary),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  String _role = 'anggota'; // Set default role
  Map<String, String?>? userData;
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
  }

  Future<void> _checkLoginStatus() async {
    _isLoggedIn = await isLogin();
    if (_isLoggedIn) {
      final userData = await getLoginInfo();
      /* --- */

      /* --- */
      setState(() {
        _role = userData['role_name'] ?? 'anggota';
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  final List<Widget> _umumPages = [
    HomePage(),
    BeritaPage(),
    AbsensiPage(),
    AppsPage(),
    ProfilPage(),
  ];

  final List<Widget> _harianPages = [
    HomePage(),
    BeritaPage(),
    AbsensiPage(),
    AppsPage(),
    ProfilPage(),
  ];

  final List<Widget> _kabidPages = [
    HomePage(),
    BeritaPage(),
    AbsensiPage(),
    AppsPage(),
    ProfilPage(),
  ];

  final List<Widget> _anggotaPages = [
    HomePage(),
    BeritaPage(),
    AbsensiPage(),
    AppsPage(),
    ProfilPage(),
  ];

  void _updateRole(String role) {
    setState(() {
      _role = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages;
    final List<Widget> _navItems;

    switch (_role) {
      case 'umum':
        _pages = _umumPages;
        _navItems = [
          Icon(TablerIcons.home, size: 30),
          Icon(TablerIcons.news, size: 30),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Warna.Primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              TablerIcons.qrcode,
              size: 30,
              color: Colors.white,
            ),
          ),
          Icon(TablerIcons.apps, size: 30),
          Icon(TablerIcons.user, size: 30),
        ];
        break;
      case 'harian':
        _pages = _harianPages;
        _navItems = [
          Icon(TablerIcons.home, size: 30),
          Icon(TablerIcons.news, size: 30),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Warna.Primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              TablerIcons.qrcode,
              size: 30,
              color: Colors.white,
            ),
          ),
          Icon(TablerIcons.apps, size: 30),
          Icon(TablerIcons.user, size: 30),
        ];
        break;
      case 'kabid':
        _pages = _kabidPages;
        _navItems = [
          Icon(TablerIcons.home, size: 30),
          Icon(TablerIcons.news, size: 30),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Warna.Primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              TablerIcons.qrcode,
              size: 30,
              color: Colors.white,
            ),
          ),
          Icon(TablerIcons.apps, size: 30),
          Icon(TablerIcons.user, size: 30),
        ];
        break;
      case 'anggota':
        _pages = _anggotaPages;
        _navItems = [
          Icon(TablerIcons.home, size: 30),
          Icon(TablerIcons.news, size: 30),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Warna.Primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              TablerIcons.qrcode,
              size: 30,
              color: Colors.white,
            ),
          ),
          Icon(TablerIcons.apps, size: 30),
          Icon(TablerIcons.user, size: 30),
        ];
        break;
      default:
        _pages = _umumPages;
        _navItems = [
          Icon(TablerIcons.home, size: 30),
          Icon(TablerIcons.news, size: 30),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Warna.Primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              TablerIcons.qrcode,
              size: 30,
              color: Colors.white,
            ),
          ),
          Icon(TablerIcons.apps, size: 30),
          Icon(TablerIcons.user, size: 30),
        ];
        break;
    }

    return Scaffold(
      appBar: HeaderMain(),
      drawer: SideBar(
        role: 'umum',
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Warna.BG,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 60,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navItems,
      ),
      /*   floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateRole(_role == 'umum' ? 'kabid' : 'umum'); // Toggle role
        },
        child: Icon(Icons.switch_account),
      ), */
    );
  }
}
