import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:policy_centrepoint/CONTROLLER/API_Setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarouselService {
  // Endpoint API yang akan digunakan

  // Fungsi untuk mengambil semua URL gambar dari carousel
  static Future<List<String>> getAllCarousels() async {
    final url = Uri.parse('${centrepoint_api.endpoint}/carousels');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<String> imageUrls = [];

        for (var carousel in responseData) {
          // Ensure 'carousel' is a map and has the key 'image'
          if (carousel is Map<String, dynamic> &&
              carousel.containsKey('image')) {
            imageUrls.add(carousel['image']); // Extract the 'image' field
          }
        }

        return imageUrls;
      } else {
        throw Exception(
            'Failed to retrieve carousel images: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error during retrieving carousel images: $e');
      throw Exception('Failed to retrieve carousel images: $e');
    }
  }

  // Fungsi untuk mengambil carousel berdasarkan ID (jika diperlukan)
  Future<void> getCarouselById(String carouselId) async {
    final url = Uri.parse('${centrepoint_api.endpoint}/carousels/$carouselId');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          // Berhasil mengambil data carousel berdasarkan ID
          print('Carousel retrieved successfully');
          print(responseData[
              'data']); // Anda bisa memproses atau menyimpan data ini
        } else {
          throw Exception(
              'Failed to retrieve carousel: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to retrieve carousel: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error during retrieving carousel: $e');
      throw Exception('Failed to retrieve carousel: $e');
    }
  }

// Clear Homepage Image Cache
  Future<void> _clearCachedCarouselImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('carouselImages');
    print('Cached carousel images cleared');
  }
}
