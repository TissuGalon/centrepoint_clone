import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Simpan data sesi pengguna setelah login
  void saveUserSession(
      String authToken, String uid, Map<String, dynamic> all) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', authToken);
    prefs.setString('uid', uid);

    final jsonData = jsonEncode(all);
    prefs.setString('allUserData', jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: const [
          Text(
            'Ubah Kata Sandi',
            style: TextStyle(
                color: Color(0xFF222222),
                fontFamily: 'URW',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            width: 15,
          )
        ],
        iconTheme: IconThemeData(
          color: Warna.TextBold, // Change the drawer icon color here
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ubah Kata Sandi',
                    style: TextStyle(
                      fontFamily: 'URW',
                      fontSize: 35,
                      color: Colors.black, // Replace with Warna.TextBold
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Masukkan kata sandi baru Anda!',
                    style: TextStyle(
                      fontFamily: 'URW',
                      fontSize: 16,
                      color: Colors.black, // Replace with Warna.TextBold
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Kata sandi baru ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                        ), // Warna border saat tidak aktif
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Warna.Primary,
                        ), // Warna border saat aktif (focus)
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: 'Masukkan kata sandi baru ',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Warna.Primary, // Replace with Warna.Primary
                      ),
                      labelStyle: TextStyle(
                        color: Warna.Primary, // Replace with Warna.Primary
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5, left: 5, right: 5, bottom: 25),
                    child: Text(
                      '*Kata sandi harus mengandung setidaknya satu huruf, satu angka, dan satu karakter khusus.',
                      style: TextStyle(color: Warna.TextNormal),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Warna.Primary, // Replace with Warna.Primary
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            11.0), // Set the border radius to make it rounded
                      ),
                      minimumSize:
                          Size(double.infinity, 48.0), // Set full width
                    ),
                    child: Text(
                      'Simpan Sandi Baru',
                      style: TextStyle(
                          fontSize:
                              22.0, // Set the font size of the button text
                          fontWeight: FontWeight.bold,
                          fontFamily: 'URW',
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
