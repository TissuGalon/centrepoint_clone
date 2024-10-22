import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/CHATPAGES/ChatPage.dart';

/* HEADER MAIN */
class HeaderMain extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/policy2.png',
            width: 30,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'UKM-POLICY',
              style: TextStyle(
                  color: Warna.Primary,
                  fontFamily: 'URW',
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
        ],
      ),
      actions: [
        /*  IconButton(
          onPressed: () {},
          icon: const Icon(
            TablerIcons.bell,
          ),
        ), */
        /*   IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage()),
            );
          },
          icon: const Icon(
            TablerIcons.message,
          ),
        ), */
      ],
      iconTheme: IconThemeData(
        color: Warna.TextBold, // Change the drawer icon color here
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
/* HEADER MAIN */

/* __________________________________________________________________ */

/* LOADING */
class CentrepointLoading extends StatelessWidget {
  final Color color;
  final double size;

  const CentrepointLoading(
      {Key? key, this.color = Colors.white, this.size = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.progressiveDots(
          color: this.color, size: this.size),
    );
  }
}
/* LOADING */

/* CARD ROUNDED */
Widget ContainerSaya({
  required Widget child,
  double borderRadius = 16.0,
  double marginH = 8.0,
  double marginV = 5.0,
  double padding = 16.0,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: marginH, vertical: marginV),
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: child,
  );
}

/* CARD ROUNDED */