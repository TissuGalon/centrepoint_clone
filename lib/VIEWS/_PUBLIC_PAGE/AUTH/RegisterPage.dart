import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:policy_centrepoint/COMPONENT/component.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/AUTH/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
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
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah data yang diisi sudah benar?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cek Kembali'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey, // Warna tombol batal
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog tanpa aksi
              },
            ),
            TextButton(
              child: Text('Sudah'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                _submitForm(); // Melanjutkan ke submit form
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Melakukan proses register dan menangkap response message
      await registerProcess(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      );

      // Menampilkan dialog success
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registrasi Berhasil'),
            content: Text('Silahkan Login untuk menggunakan aplikasi'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        email: _emailController.text,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ).then(
        (_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(
                email: _emailController.text,
              ),
            ), // Halaman yang baru akan dituju
            (Route<dynamic> route) =>
                false, // Menghapus semua halaman sebelumnya
          );
        },
      );
    } catch (e) {
      // Jika gagal, ambil pesan error dari response dan tampilkan di dialog
      final errorMessage =
          (e is Exception) ? e.toString() : 'Terjadi kesalahan';

      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registrasi Gagal'),
            content: Text(
                errorMessage), // Menampilkan isi dari exception yang ditangkap
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

  void validateAndSubmit() {
    setState(() {
      _isLoading = true;
    });
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lengkapi Data'),
            content: Text('Pastikan seluruh kolom terisi'),
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
      ).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sandi tidak sama'),
            content: Text('Pastikan kembali sandi yang anda gunakan'),
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
      ).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      _showConfirmationDialog();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool isPassword = false,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Warna.Primary),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        hintText: 'Enter your $labelText'.toLowerCase(),
        prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Daftar Akun',
          style: TextStyle(
            color: Color(0xFF222222),
            fontFamily: 'URW',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: Warna.TextBold),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Daftar Akun',
                        style: TextStyle(
                          fontFamily: 'URW',
                          fontSize: 35,
                          color: Warna.TextBold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      _buildTextField(
                        controller: _usernameController,
                        labelText: 'Username',
                        icon: TablerIcons.user,
                      ),
                      SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        icon: TablerIcons.mail,
                      ),
                      SizedBox(height: 10.0),
                      Divider(),
                      SizedBox(height: 10.0),
                      _buildTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        icon: TablerIcons.lock,
                        isPassword: true,
                      ),
                      SizedBox(height: 20.0),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        labelText: 'Konfirmasi Password',
                        icon: TablerIcons.lock_filled,
                        isPassword: true,
                      ),
                      SizedBox(height: 25.0),
                      ElevatedButton(
                        onPressed: validateAndSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.Primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          minimumSize: Size(double.infinity, 48.0),
                        ),
                        child: _isLoading
                            ? CentrepointLoading()
                            : Text(
                                'Daftar',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'URW',
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
