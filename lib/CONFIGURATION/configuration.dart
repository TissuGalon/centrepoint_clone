import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Warna {
  static var BG = Color(0xFFEFECEC);
  static var Primary = Color(0xFFDC3545);
  static var PrimaryDark = Color(0xFFCF264F);
  static var PrimaryHalf = Color.fromARGB(255, 248, 114, 148);
  static var Secondary = Color(0xFF27FAC7);
  static var TextBold = Color(0xFF222222);
  static var TextNormal = Color(0xFF7E7E7E);
  static var Success = Color(0xFF198754);
  static var SuccessHalf = Color.fromARGB(135, 25, 135, 84);
}

formatRupiah(double nominal) {
  double value = nominal;

  // Create a NumberFormat instance for currency formatting in Indonesian Rupiah
  NumberFormat rupiahFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0, // Display as whole numbers
  );

  String formattedValue = rupiahFormat.format(value);
  return formattedValue;
}

Future<Uint8List> loadImageAsUint8List(String imagePath) async {
  final ByteData data = await rootBundle.load(imagePath);
  return data.buffer.asUint8List();
}
