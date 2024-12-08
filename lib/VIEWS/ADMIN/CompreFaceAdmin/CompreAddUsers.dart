import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/Service/CompreUserService.dart';

class CompreAddUserScreen extends StatefulWidget {
  final UserService userService;

  CompreAddUserScreen({required this.userService});

  @override
  _CompreAddUserScreenState createState() => _CompreAddUserScreenState();
}

class _CompreAddUserScreenState extends State<CompreAddUserScreen> {
  final TextEditingController _usernameController = TextEditingController();

  Future<void> _addUser() async {
    final username = _usernameController.text;
    if (username.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter a username')));
      return;
    }

    await widget.userService.addUser(username);
    Navigator.pop(context); // Return to user list screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Text(
            'ADD USERS',
            style: TextStyle(
                color: Color(0xFF222222),
                fontFamily: 'URW',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        iconTheme: IconThemeData(
          color: Warna.TextBold, // Mengubah warna ikon drawer
        ),
      ),
      backgroundColor: Warna.BG,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addUser,
                child: Text(
                  "ADD USER",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'URW',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Warna.Primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
