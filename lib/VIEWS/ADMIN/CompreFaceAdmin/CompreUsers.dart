import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/CompreAddUsers.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/CompreUserDetail.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/Service/CompreUserService.dart';

class CompreUsersScreen extends StatefulWidget {
  @override
  _CompreUsersScreenState createState() => _CompreUsersScreenState();
}

class _CompreUsersScreenState extends State<CompreUsersScreen> {
  final UserService _userService = UserService();
  late Future<List<String>> _users;
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeUserService();
  }

  Future<void> _initializeUserService() async {
    await _userService.initialize();
    _fetchUsers();
  }

  void _fetchUsers() {
    setState(() {
      _users = _userService.fetchUsers();
    });
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
            'COMPREFACE USERS',
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
      body: FutureBuilder<void>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Initialization Error: ${snapshot.error}'),
            );
          } else {
            return FutureBuilder<List<String>>(
              future: _users,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load users: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No users found'));
                } else {
                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: ListTile(
                          leading: Icon(TablerIcons.user),
                          title: Text(users[index]),
                          trailing: IconButton(
                              onPressed: () {}, icon: Icon(TablerIcons.trash)),
                          onTap: () => _navigateToUserDetails(users[index]),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Jarak kiri dan kanan
        child: SizedBox(
          width: double.infinity, // Lebar penuh layar
          child: ElevatedButton(
            onPressed: _navigateToAddUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: Warna.Primary, // Warna tombol
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Radius sudut
              ),
              padding: EdgeInsets.symmetric(vertical: 16), // Tinggi tombol
            ),
            child: Text(
              'TAMBAH USER',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'URW',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _navigateToAddUser() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CompreAddUserScreen(userService: _userService)),
    );
    _fetchUsers(); // Refresh user list after adding a user
  }

  void _navigateToUserDetails(String username) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CompreUserDetailsScreen(
              username: username, userService: _userService)),
    );
  }
}
