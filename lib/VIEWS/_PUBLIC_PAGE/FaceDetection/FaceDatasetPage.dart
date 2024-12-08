import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FaceDatasetPage extends StatefulWidget {
  @override
  _FaceDatasetPageState createState() => _FaceDatasetPageState();
}

class _FaceDatasetPageState extends State<FaceDatasetPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool _isDetecting = false;
  String _result = '';
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _startCamera(cameras!.first);
    }
  }

  void _startCamera(CameraDescription camera) {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {}); // To trigger a rebuild when the camera is initialized
  }

  Future<void> _captureAndDetectFace() async {
    if (_isDetecting) return;

    setState(() {
      _isDetecting = true;
      _result = 'Detecting...';
    });

    try {
      await _initializeControllerFuture;

      final image = await _cameraController.takePicture();
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/face_image.jpg');
      await tempFile.writeAsBytes(await image.readAsBytes());

      final response = await _detectFace(tempFile);

      setState(() {
        _result = response ?? 'No face detected or error.';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    } finally {
      setState(() {
        _isDetecting = false;
      });
    }
  }

  Future<String?> _detectFace(File imageFile) async {
    final baseUrl = '';
    final apiKey = '';
    final url = Uri.parse(
        '${baseUrl}/api/v1/recognition/recognize?limit=1&det_prob_threshold=0.8&prediction_count=1');
    final request = http.MultipartRequest('POST', url);
    request.headers['x-api-key'] = apiKey;
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);

      if (data['result'].isNotEmpty) {
        final result = data['result'][0]['subjects'][0];
        return 'Detected: ${result['subject']}';
      } else {
        return 'No face detected.';
      }
    } else {
      return 'API Error: ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Dataset'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _cameraController.value.isInitialized
                  ? CameraPreview(_cameraController)
                  : Center(child: CircularProgressIndicator()),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _result,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            onPressed: _captureAndDetectFace,
            label: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 5),
                Text('Ambil Dataset'),
              ],
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                _result = 'Testing dataset not implemented.';
              });
            },
            label: Row(
              children: [
                Icon(Icons.face),
                SizedBox(width: 5),
                Text('Test Dataset'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
