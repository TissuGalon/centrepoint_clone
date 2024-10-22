import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:policy_centrepoint/COMPONENT/component.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/ChangePasswordPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:timer_count_down/timer_count_down.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  bool terkirim = false;
  bool _isLoading = false;

  Future<void> _sendResetRequest() async {
    String email = _emailController.text;

    try {
      setState(() {
        _isLoading = true; // Mengatur loading sebelum request
      });

      // Panggil API dan dapatkan respons
      final responseData = await sendResetPasswordRequest(email);

      // Ambil status dan message dari respons
      String status = responseData['status'];
      String message = responseData['message'];

      // Tampilkan dialog dengan status dan message dari respons
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(status == 'success' ? 'Berhasil' : 'Gagal'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      if (status == 'success') {
        setState(() {
          terkirim = true; // Mengupdate state jika pengiriman berhasil
        });

        // Mulai countdown timer selama 1 menit
        await Future.delayed(Duration(minutes: 1));
        setState(() {
          terkirim = false; // Reset state terkirim setelah delay
        });
      }
    } catch (e) {
      // Tangani error dan tampilkan dalam dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false; // Mengatur loading ke false setelah selesai
      });
    }
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
            'Lupa Kata Sandi',
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
          color: Warna.TextBold,
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
                    'Lupa Kata Sandi?',
                    style: TextStyle(
                      fontFamily: 'URW',
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Masukkan Email anda untuk ubah kata sandi',
                    style: TextStyle(
                      fontFamily: 'URW',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              if (terkirim)
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(45, 13, 202, 240),
                  ),
                  child: Text(
                    'Kami sudah mengirim email yang berisi tautan untuk mereset kata sandi Anda!',
                    style: TextStyle(
                      color: Color(0xff0dcaf0),
                    ),
                  ),
                ),
              SizedBox(height: 15),
              Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Warna.Primary,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: 'Masukkan email Anda',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Warna.Primary,
                      ),
                      labelStyle: TextStyle(
                        color: Warna.Primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  ElevatedButton(
                    onPressed: terkirim ? null : _sendResetRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.Primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      minimumSize: ui.Size(double.infinity, 48.0),
                    ),
                    child: _isLoading
                        ? CentrepointLoading()
                        : Text(
                            'Kirim',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'URW',
                              color: Colors.white,
                            ),
                          ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              if (terkirim)
                Countdown(
                  seconds: 60,
                  build: (BuildContext context, double time) => Text(
                    'Tunggu $time detik sebelum mengirim ulang.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  interval: Duration(milliseconds: 100),
                  onFinished: () {
                    setState(() {
                      terkirim = false; // Reset after countdown finishes
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
