import 'package:policy_centrepoint/CONTROLLER/API_Setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> registerProcess({
  required String username,
  required String email,
  required String password,
}) async {
  final url = Uri.parse('${centrepoint_api.endpoint}/register');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['status'] == 'success') {
        print(responseData['message']);
        // Lanjutkan proses setelah registrasi sukses jika perlu
      } else {
        throw Exception('Registration failed: ${responseData['message']}');
      }
    } else if (response.statusCode == 409) {
      final responseData = jsonDecode(response.body);
      // Jangan melempar exception lagi, cukup tangani di sini
      throw ('${responseData['message']}');
    } else {
      // Tangani error berdasarkan status code lain
      throw Exception(
          'Failed to register with status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('$e');
  }
}

/* ------------- LOGIN ------------- */

Future<void> loginProcess(String email, String password) async {
  final url = Uri.parse(
      '${centrepoint_api.endpoint}/login'); // Sesuaikan dengan endpoint API Anda
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Jika server mengembalikan status 200 OK, simpan data respons ke shared preferences
      final responseData = jsonDecode(response.body);

      if (responseData['status'] == 'success' && responseData['user'] != null) {
        final user = responseData['user'];
        final token = responseData['token'] ?? '';
        final role = user['role']; // Menangkap informasi role

        // Simpan informasi user dari respons yang baru
        await saveLoginInfo(
          userId: user['user_id'].toString(),
          username: user['username'] ?? '',
          fullname: user['fullname'] ?? '',
          email: user['email'] ?? '',
          roleId: user['role_id'].toString(),
          profilePhoto: user['profile_photo'] ?? '',
          token: token,
          createdAt: user['created_at'] ?? '',
          updatedAt: user['updated_at'] ?? '',
          points: user['points'].toString(),
          roleName: role['role_name'] ?? '', // Menyimpan role_name
          resetToken: user['reset_token'] ?? '', // Menyimpan reset_token
        );
      } else {
        throw Exception('Failed to parse login response');
      }
      // Navigasi atau tindakan lain setelah login berhasil
    } else {
      // Jika server tidak mengembalikan status 200, lempar exception
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Tangani error yang terjadi selama proses login
    print('Error during login: $e');
    throw Exception('Failed to login: $e');
  }
}

Future<void> saveLoginInfo({
  required String userId,
  required String username,
  required String fullname,
  required String email,
  required String roleId,
  required String profilePhoto,
  required String token,
  required String createdAt,
  required String updatedAt,
  required String points,
  required String roleName, // Menambahkan parameter roleName
  required String resetToken, // Menambahkan parameter resetToken
}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_id', userId);
  await prefs.setString('username', username);
  await prefs.setString('fullname', fullname);
  await prefs.setString('email', email);
  await prefs.setString('role_id', roleId);
  await prefs.setString('role_name', roleName); // Menyimpan role_name
  await prefs.setString('profile_photo', profilePhoto);
  await prefs.setString('token', token);
  await prefs.setString('reset_token', resetToken); // Menyimpan reset_token
  await prefs.setString('created_at', createdAt);
  await prefs.setString('updated_at', updatedAt);
  await prefs.setString('points', points);
}

Future<Map<String, String?>> getLoginInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('user_id');
  final username = prefs.getString('username');
  final fullname = prefs.getString('fullname');
  final email = prefs.getString('email');
  final roleId = prefs.getString('role_id');
  final roleName = prefs.getString('role_name'); // Mengambil role_name
  final profilePhoto = prefs.getString('profile_photo');
  final token = prefs.getString('token');
  final resetToken = prefs.getString('reset_token'); // Mengambil reset_token
  final createdAt = prefs.getString('created_at');
  final updatedAt = prefs.getString('updated_at');
  final points = prefs.getString('points');

  return {
    'user_id': userId,
    'username': username,
    'fullname': fullname,
    'email': email,
    'role_id': roleId,
    'role_name': roleName, // Menambahkan role_name
    'profile_photo': profilePhoto,
    'token': token,
    'reset_token': resetToken, // Menambahkan reset_token
    'created_at': createdAt,
    'updated_at': updatedAt,
    'points': points,
  };
}

Future<void> clearLoginInfo() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_id');
  await prefs.remove('username');
  await prefs.remove('fullname');
  await prefs.remove('email');
  await prefs.remove('role_id');
  await prefs.remove('role_name'); // Menghapus role_name
  await prefs.remove('profile_photo');
  await prefs.remove('token');
  await prefs.remove('reset_token'); // Menghapus reset_token
  await prefs.remove('created_at');
  await prefs.remove('updated_at');
  await prefs.remove('points');
}

Future<bool> isLogin() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token != null && token.isNotEmpty;
}

Future<String> roleCheck() async {
  final prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('role_id');

  if (role != null && role.isNotEmpty) {
    return role;
  } else {
    return 'anggota'; // Default role jika tidak ditemukan
  }
}

/* UNTUK PROFIL */
Future<Map<String, dynamic>?> getUserData(String userId) async {
  final url = Uri.parse('${centrepoint_api.endpoint}/users/$userId');
  try {
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData['data']; // Mengembalikan data pengguna
      } else {
        throw Exception('Failed to get user data: ${responseData['message']}');
      }
    } else {
      throw Exception('Failed to get user data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error during getting user data: $e');
    throw Exception('Failed to get user data: $e');
  }
}

/* ------------- VERIFICATION ------------- */

Future<String> emailVerification(String email, String pin) async {
  try {
    Map<String, dynamic> body = {
      'email': email,
      'otp': pin,
    };
    Map<String, String?> userData = await getLoginInfo();
    final response = await http.post(
      Uri.parse('${centrepoint_api.endpoint}/auth/email/verify'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userData['token']}',
      },
      body: json.encode(body),
    );

    print(userData['token']);

    if (response.statusCode == 200) {
      print('Email verification successful');
      return json.decode(response.body)[
          'status']; // assuming the response has a 'status' field
    } else {
      print('Failed to verify email: ${response.statusCode}');
      return json.decode(response.body)['status'];
    }
  } catch (e) {
    print('Error: $e');
    return 'An error occurred';
  }
}

/* ------------- REQUEST RESET PASSWORD ------------- */

Future<Map<String, dynamic>> sendResetPasswordRequest(String email) async {
  final url = Uri.parse(
      '${centrepoint_api.endpoint}/forgot-password'); // Sesuaikan dengan endpoint API Anda
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Mengembalikan respons jika statusnya 'success'
      if (responseData['status'] == 'success') {
        return responseData; // Kembalikan seluruh data respons
      } else {
        throw Exception(
            'Failed to send password reset link: ${responseData['message']}');
      }
    } else {
      throw Exception('Failed to send request: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error during sending password reset request: $e');
    throw Exception('Failed to send reset password request: $e');
  }
}

/* ------------- REQUEST RESET PASSWORD ------------- */

Future<void> resetPassword(String token, String newPassword) async {
  final url = Uri.parse(
      '${centrepoint_api.endpoint}/reset-password'); // Sesuaikan dengan endpoint API Anda
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': token,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['status'] == 'success') {
        print(responseData['message']);
      } else {
        throw Exception('Failed to reset password');
      }
    } else {
      throw Exception('Failed to reset password: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error during resetting password: $e');
    throw Exception('Failed to reset password: $e');
  }
}
