import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/VIEWS/ADMIN/CompreFaceAdmin/Service/CompreUserService.dart';

class CompreUserDetailsScreen extends StatefulWidget {
  final String username;
  final UserService userService;

  CompreUserDetailsScreen({required this.username, required this.userService});

  @override
  _CompreUserDetailsScreenState createState() =>
      _CompreUserDetailsScreenState();
}

class _CompreUserDetailsScreenState extends State<CompreUserDetailsScreen> {
  File? _image;
  List<Map<String, dynamic>> _photos = [];
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false; // Add upload state flag

  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  Future<void> _fetchPhotos() async {
    try {
      final photos = await widget.userService.fetchUserPhotos(widget.username);
      setState(() {
        _photos = photos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load photos')));
    }
  }

  Future<void> _addPhoto() async {
    if (_image == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please take a photo first')));
      return;
    }

    setState(() {
      _isUploading = true; // Show loading indicator
    });

    try {
      await widget.userService.addPhoto(widget.username, _image!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Photo uploaded successfully')));
      _fetchPhotos(); // Refresh photo list
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload photo')));
    } finally {
      setState(() {
        _isUploading = false; // Hide loading indicator
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _addPhoto();
    }
  }

  Future<void> _deletePhoto(String imageId) async {
    try {
      await widget.userService.deletePhoto(imageId);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Photo deleted successfully')));
      _fetchPhotos();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to delete photo')));
    }
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
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed:
                _isUploading ? null : _takePhoto, // Disable button if uploading
          ),
        ],
        iconTheme: IconThemeData(
          color: Warna.TextBold, // Mengubah warna ikon drawer
        ),
      ),
      backgroundColor: Warna.BG,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isUploading) // Show loading indicator when uploading
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Uploading photo...')
                  ],
                ),
              ),
            Expanded(
              child: _photos.isEmpty
                  ? Center(child: Text('No photos found'))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _photos.length,
                      itemBuilder: (context, index) {
                        final photo = _photos[index];
                        final imageUrl = widget.userService
                            .getImageUrl(photo['image_id']); // URL gambar

                        return Stack(
                          children: [
                            Image.network(
                              imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _deletePhoto(photo['image_id']),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
