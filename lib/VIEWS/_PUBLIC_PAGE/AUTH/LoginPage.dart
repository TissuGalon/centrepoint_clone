import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:policy_centrepoint/COMPONENT/component.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/ForgotPasswordPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/RegisterPage.dart';
import 'package:policy_centrepoint/main.dart';

class LoginPage extends StatefulWidget {
  final String? email; // Email menjadi opsional

  LoginPage({this.email}); // Tidak perlu 'required' karena opsional

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Jika widget.email ada (tidak null), masukkan ke dalam _emailController
    if (widget.email != null) {
      _emailController.text = widget.email!;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /* LOGIN PROSES */
  Future<void> _login() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Pastikan _emailController.text dan _passwordController.text tidak null
      String email = _emailController.text;
      String password = _passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        // Tampilkan dialog untuk input yang kosong
        await CustomDialog.showEmptyFieldsDialog(context);
        setState(() {
          _isLoading = false;
        });
        return; // Keluar dari fungsi jika ada input kosong
      }

      // Proses login
      await loginProcess(email, password);

      // Ambil informasi login yang tersimpan
      final loginInfo = await getLoginInfo();

      if (loginInfo['role_id'] != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp()), // Halaman yang baru akan dituju
          (Route<dynamic> route) => false, // Menghapus semua halaman sebelumnya
        );

        // Tampilkan dialog sukses dan navigasi ke halaman berikutnya
        /*  await CustomDialog.showSuccessDialog(
          context,
          'Login berhasil! Anda akan diarahkan ke halaman utama.',
          MyApp(),
        ); */
      } else {
        // Jika tidak ada role_id, tampilkan dialog error
        await CustomDialog.showErrorDialog(
          context,
          'Login gagal. Silakan cek kembali email dan password anda.',
        );
      }
    } catch (e) {
      // Tampilkan dialog error
      await CustomDialog.showErrorDialog(
        context,
        'Login gagal. Silakan cek kembali email dan password anda.',
      );
    } finally {
      // Pastikan loading state di-reset
      setState(() {
        _isLoading = false;
      });
    }
  }

  /* LOGIN PROSES */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Image.asset('assets/images/loginscreen_logo.png'),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MASUK',
                        style: TextStyle(
                          fontFamily: 'URW',
                          fontSize: 35,
                          color: Colors.black, // Replace with Warna.TextBold
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Silahkan masuk untuk melanjutkan',
                        style: TextStyle(
                          fontFamily: 'URW',
                          fontSize: 16,
                          color: Colors.black, // Replace with Warna.TextBold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
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
                          hintText: 'Enter your email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Warna.Primary, // Replace with Warna.Primary
                          ),
                          labelStyle: TextStyle(
                            color: Warna.Primary, // Replace with Warna.Primary
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                          hintText: 'Enter your password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Warna.Primary, // Replace with Warna.Primary
                          ),
                          labelStyle: TextStyle(
                            color:
                                Warna.Primary, // Warna label saat aktif (focus)
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Warna.Primary, // Replace with Warna.Primary
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Set the border radius to make it rounded
                          ),
                          minimumSize:
                              Size(double.infinity, 48.0), // Set full width
                        ),
                        child: _isLoading
                            ? CentrepointLoading()
                            : Text(
                                'MASUK',
                                style: TextStyle(
                                    fontSize:
                                        24.0, // Set the font size of the button text
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'URW',
                                    color: Colors.white),
                              ),
                      ),
                      /* TEST */
                      /*  SizedBox(height: 25.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => MyApp()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Warna.Secondary, // Replace with Warna.Primary
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Set the border radius to make it rounded
                          ),
                          minimumSize:
                              Size(double.infinity, 48.0), // Set full width
                        ),
                        child: Text(
                          'TEST',
                          style: TextStyle(
                              fontSize:
                                  24.0, // Set the font size of the button text
                              fontWeight: FontWeight.bold,
                              fontFamily: 'URW',
                              color: Colors.white),
                        ),
                      ), */
                      /* TEST */
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => ForgotPasswordPage()),
                        ),
                        child: Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'URW',
                            color: Warna.Primary, // Replace with Warna.Primary
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tidak punya akun ?',
                        style: TextStyle(fontSize: 17, fontFamily: 'URW'),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => RegisterPage()),
                        ),
                        child: Text(
                          'BUAT AKUN',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'URW',
                            color: Warna.Primary, // Replace with Warna.Primary
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* DIALOG STATUS */
class CustomDialog {
  // Menampilkan dialog dengan pesan error
  static Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Menampilkan dialog dengan pesan sukses
  static Future<void> showSuccessDialog(
      BuildContext context, String successMessage, Widget nextPage) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Berhasil'),
          content: Text(successMessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          nextPage), // Navigasi ke halaman berikutnya
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Menampilkan dialog untuk input kosong (Email atau password tidak boleh kosong)
  static Future<void> showEmptyFieldsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kesalahan Input'),
          content: Text('Email atau password tidak boleh kosong.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
          ],
        );
      },
    );
  }
}


/* DIALOG STATUS */