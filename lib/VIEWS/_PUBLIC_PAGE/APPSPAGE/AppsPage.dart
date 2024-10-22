import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';

class AppsPage extends StatefulWidget {
  @override
  _AppsPageState createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  // Simulasi data App
  final List<Map<String, dynamic>> products = [
    {
      'imageUrl':
          'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049601.jpg',
      'name': 'App 1',
      'price': 'Rp 100.000'
    },
    {
      'imageUrl':
          'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049601.jpg',
      'name': 'App 2',
      'price': 'Rp 200.000'
    },
    {
      'imageUrl':
          'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049601.jpg',
      'name': 'App 3',
      'price': 'Rp 300.000'
    },
    {
      'imageUrl':
          'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049601.jpg',
      'name': 'App 4',
      'price': 'Rp 400.000'
    },
    {
      'imageUrl':
          'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049601.jpg',
      'name': 'App 5',
      'price': 'Rp 500.000'
    },
    {
      'imageUrl':
          'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049601.jpg',
      'name': 'App 6',
      'price': 'Rp 600.000'
    },
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BG,
      /*  body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(8),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 2 kotak dalam 1 row
                  crossAxisSpacing: 10, // Jarak antar kotak horizontal
                  mainAxisSpacing: 10, // Jarak antar kotak vertikal
                  childAspectRatio: 3 / 4, // Rasio tinggi dan lebar kotak
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index]; // Data App
                  return buildProductCard(
                    product['imageUrl'],
                    product['name'],
                    product['price'],
                  );
                },
              ),
            ), */
      body: Center(
        child: Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            'assets/icon/coming-soon2.png',
            scale: 3,
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun card App dalam grid
  Widget buildProductCard(String imageUrl, String name, String price) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
