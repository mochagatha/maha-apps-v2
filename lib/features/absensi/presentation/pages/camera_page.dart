import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../shared/theme/app_theme.dart';

class CameraPage extends StatefulWidget {
  final int status; // 1: clock-in, 2: clock-out, 3: break
  final Function(String photoPath, String location) onPhotoTaken;

  const CameraPage({
    super.key,
    required this.status,
    required this.onPhotoTaken,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isLoadingLocation = true;
  Position? _currentPosition;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCameraAndLocation();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCameraAndLocation() async {
    await _requestPermissions();
    await _initializeCamera();
    await _getCurrentLocation();
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.location.request();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => _cameras!.first,
        ),
        ResolutionPreset.medium,
      );
      await _cameraController!.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _isLoadingLocation = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled')),
        );
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _isLoadingLocation = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')),
          );
        }
        return;
      }
    }

    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to get location: $e')));
      }
    }

    setState(() => _isLoadingLocation = false);
  }

  Future<void> _takePicture() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final XFile file = await _cameraController!.takePicture();
        setState(() {
          _imagePath = file.path;
        });
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to take picture: $e')));
      }
    }
  }

  void _switchCamera() {
    if (_cameras != null && _cameras!.length > 1) {
      final lensDirection = _cameraController!.description.lensDirection;
      CameraDescription newDescription;
      if (lensDirection == CameraLensDirection.front) {
        newDescription = _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
        );
      } else {
        newDescription = _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
        );
      }
      _cameraController = CameraController(
        newDescription,
        ResolutionPreset.medium,
      );
      _cameraController!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  void _submitAttendance() {
    if (_imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please take a photo first')),
      );
      return;
    }

    if (_currentPosition == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Location not available')));
      return;
    }

    final location =
        '${_currentPosition!.latitude},${_currentPosition!.longitude}';
    widget.onPhotoTaken(_imagePath!, location);
    Navigator.of(context).pop();
  }

  String _getTitle() {
    switch (widget.status) {
      case 1:
        return 'Absen Masuk';
      case 2:
        return 'Absen Pulang';
      case 3:
        return 'Absen Istirahat';
      default:
        return 'E-Presensi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        centerTitle: true,
        actions: [
          if (_cameras != null && _cameras!.length > 1)
            IconButton(
              icon: const Icon(Icons.cameraswitch),
              onPressed: _switchCamera,
            ),
        ],
      ),
      body: Column(
        children: [
          // Camera Preview
          Expanded(
            flex: 3,
            child: _isCameraInitialized
                ? Stack(
                    children: [
                      if (_imagePath != null)
                        Image.file(
                          File(_imagePath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      else
                        CameraPreview(_cameraController!),
                    ],
                  )
                : const Center(
                    child: SpinKitThreeBounce(
                      color: AppColors.primary,
                      size: 24.0,
                    ),
                  ),
          ),

          // Location Info
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: _isLoadingLocation
                  ? const Center(
                      child: SpinKitThreeBounce(
                        color: AppColors.primary,
                        size: 50.0,
                      ),
                    )
                  : _currentPosition != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Lat: ${_currentPosition!.latitude.toStringAsFixed(6)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Long: ${_currentPosition!.longitude.toStringAsFixed(6)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_off, color: Colors.grey),
                        const SizedBox(height: 8),
                        const Text('Location not available'),
                        TextButton(
                          onPressed: _getCurrentLocation,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_imagePath != null)
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _imagePath = null);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retake'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Capture'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),

            if (_imagePath != null)
              ElevatedButton.icon(
                onPressed: _submitAttendance,
                icon: const Icon(Icons.check),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
