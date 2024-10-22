import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';

class ComingSoon extends StatefulWidget {
  @override
  _ComingSoon createState() => _ComingSoon();
}

class _ComingSoon extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BG,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            'assets/icon/coming-soon2.png',
            scale: 3,
          ),
        ),
      ),
    );
  }
}
