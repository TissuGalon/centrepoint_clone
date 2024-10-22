import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:policy_centrepoint/CONTROLLER/API_Setting.dart';

Future<void> addPoints(String userId, int points, String reason) async {
  final url = Uri.parse('${centrepoint_api.endpoint}/points/add');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'points': points,
        'reason': reason,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        // Berhasil menambah poin
        print('Points added successfully');
      } else {
        throw Exception('Failed to add points: ${responseData['message']}');
      }
    } else {
      throw Exception('Failed to add points: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error during adding points: $e');
    throw Exception('Failed to add points: $e');
  }
}

Future<void> deductPoints(String userId, int points, String reason) async {
  final url = Uri.parse('${centrepoint_api.endpoint}/points/deduct');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'points': points,
        'reason': reason,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        // Berhasil mengurangi poin
        print('Points deducted successfully');
      } else {
        throw Exception('Failed to deduct points: ${responseData['message']}');
      }
    } else {
      throw Exception('Failed to deduct points: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error during deducting points: $e');
    throw Exception('Failed to deduct points: $e');
  }
}

Future<int?> getUserPoints(String userId) async {
  final url = Uri.parse('${centrepoint_api.endpoint}/points/$userId');
  try {
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData['data']['points'];
      } else {
        throw Exception(
            'Failed to get user points: ${responseData['message']}');
      }
    } else {
      throw Exception('Failed to get user points: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error during getting user points: $e');
    throw Exception('Failed to get user points: $e');
  }
}

// Fungsi untuk mengambil riwayat poin pengguna
Future<List<dynamic>?> getUserPointsHistory(String userId) async {
  final url = Uri.parse('${centrepoint_api.endpoint}/points/history/$userId');
  try {
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData['data']; // Mengembalikan daftar riwayat poin
      } else {
        throw Exception(
            'Failed to get user points history: ${responseData['message']}');
      }
    } else {
      throw Exception(
          'Failed to get user points history: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error during getting user points history: $e');
    throw Exception('Failed to get user points history: $e');
  }
}
