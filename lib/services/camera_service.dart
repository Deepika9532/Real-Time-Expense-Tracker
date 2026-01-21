import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

enum CameraMode { photo, video, scan }

class CameraService {
  static final CameraService _instance = CameraService._internal();
  factory CameraService() => _instance;
  CameraService._internal();

  late CameraController _cameraController;
  List<CameraDescription>? _cameras;
  CameraMode _currentMode = CameraMode.photo;
  bool _isInitialized = false;
  bool _isRecording = false;
  Timer? _recordingTimer;
  double _currentZoomLevel = 1.0; // Track zoom level manually

  // Text recognition
  final TextRecognizer _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  // Getter for camera controller
  CameraController get cameraController => _cameraController;

  // Initialize camera service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();

      if (_cameras!.isEmpty) {
        throw Exception('No cameras found');
      }

      // Use back camera by default
      final backCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController.initialize();
      _isInitialized = true;

      if (kDebugMode) {
        print('Camera service initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Camera initialization failed: $e');
      }
      rethrow;
    }
  }

  // Switch camera
  Future<void> switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      throw Exception('No other camera available');
    }

    final currentLens = _cameraController.description.lensDirection;
    CameraDescription newCamera;

    if (currentLens == CameraLensDirection.back) {
      newCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );
    } else {
      newCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first,
      );
    }

    await _cameraController.dispose();
    _cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await _cameraController.initialize();
    _currentZoomLevel = 1.0; // Reset zoom
  }

  // Take photo
  Future<File?> takePhoto() async {
    if (!_isInitialized) {
      throw Exception('Camera not initialized');
    }

    try {
      final XFile xfile = await _cameraController.takePicture();
      final File file = File(xfile.path);

      // Process image (compress and rotate if needed)
      final processedFile = await _processImage(file);
      return processedFile;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to take photo: $e');
      }
      return null;
    }
  }

  // Start recording video
  Future<void> startRecording() async {
    if (!_isInitialized || _isRecording) return;

    try {
      await _cameraController.startVideoRecording();
      _isRecording = true;

      // Start recording timer
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // You can update UI with recording duration here
      });

      if (kDebugMode) {
        print('Recording started');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to start recording: $e');
      }
    }
  }

  // Stop recording video
  Future<File?> stopRecording() async {
    if (!_isRecording) return null;

    try {
      final XFile xfile = await _cameraController.stopVideoRecording();
      _isRecording = false;
      _recordingTimer?.cancel();
      _recordingTimer = null;

      final File file = File(xfile.path);

      if (kDebugMode) {
        print('Recording stopped: ${file.path}');
      }

      return file;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to stop recording: $e');
      }
      return null;
    }
  }

  // Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xfile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (xfile != null) {
        final File file = File(xfile.path);
        final processedFile = await _processImage(file);
        return processedFile;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
      return null;
    }
  }

  // Pick multiple images
  Future<List<File>> pickMultipleImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> xfiles = await picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      final List<File> files = [];
      for (final xfile in xfiles) {
        final file = File(xfile.path);
        final processedFile = await _processImage(file);
        files.add(processedFile);
      }

      return files;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to pick multiple images: $e');
      }
      return [];
    }
  }

  // Process image (compress, rotate, etc.)
  Future<File> _processImage(File originalFile) async {
    try {
      // Read image
      final imageBytes = await originalFile.readAsBytes();
      final originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        throw Exception('Failed to decode image');
      }

      // Resize if too large
      const maxSize = 1920;
      img.Image resizedImage = originalImage;
      if (originalImage.width > maxSize || originalImage.height > maxSize) {
        resizedImage = img.copyResize(
          originalImage,
          width: maxSize,
          height: maxSize,
          maintainAspect: true,
        );
      }

      // Convert to JPEG and compress
      final compressedBytes = img.encodeJpg(resizedImage, quality: 85);

      // Save to temporary directory
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final processedPath = '${tempDir.path}/processed_$timestamp.jpg';
      final processedFile = File(processedPath);
      await processedFile.writeAsBytes(compressedBytes);

      // Delete original file if it's a temporary camera file
      if (originalFile.path.contains('cache')) {
        await originalFile.delete();
      }

      return processedFile;
    } catch (e) {
      if (kDebugMode) {
        print('Image processing failed: $e');
      }
      return originalFile;
    }
  }

  // Scan receipt and extract text
  Future<Map<String, dynamic>> scanReceipt(File imageFile) async {
    try {
      final inputImage = InputImage.fromFilePath(imageFile.path);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      final extractedData = _parseReceiptText(recognizedText.text);

      if (kDebugMode) {
        print('Receipt scanned: ${extractedData.length} items found');
      }

      return extractedData;
    } catch (e) {
      if (kDebugMode) {
        print('Receipt scanning failed: $e');
      }
      return {};
    }
  }

  // Parse receipt text to extract structured data
  Map<String, dynamic> _parseReceiptText(String text) {
    final lines = text.split('\n');
    final items = <Map<String, dynamic>>[];
    double total = 0.0;
    String? date;
    String? merchant;

    // Common patterns
    final datePattern = RegExp(r'(\d{1,2}[/-]\d{1,2}[/-]\d{2,4})');
    final totalPattern = RegExp(r'Total.*?(\d+\.?\d*)', caseSensitive: false);
    final pricePattern = RegExp(r'(\d+\.?\d{2})');
    final itemPattern = RegExp(r'([A-Za-z\s]+)\s+(\d+\.?\d{2})');

    for (final line in lines) {
      final trimmedLine = line.trim();

      // Extract date
      if (date == null) {
        final dateMatch = datePattern.firstMatch(trimmedLine);
        if (dateMatch != null) {
          date = dateMatch.group(1);
        }
      }

      // Extract merchant (usually first non-empty line without numbers)
      if (merchant == null &&
          trimmedLine.isNotEmpty &&
          !trimmedLine.contains(RegExp(r'\d')) &&
          trimmedLine.length < 50) {
        merchant = trimmedLine;
      }

      // Extract total
      final totalMatch = totalPattern.firstMatch(trimmedLine);
      if (totalMatch != null) {
        final totalString = totalMatch.group(1);
        if (totalString != null) {
          total = double.tryParse(totalString) ?? 0.0;
        }
      }

      // Extract items
      final itemMatch = itemPattern.firstMatch(trimmedLine);
      if (itemMatch != null) {
        final itemName = itemMatch.group(1)?.trim() ?? '';
        final itemPrice = itemMatch.group(2) ?? '0.00';
        final price = double.tryParse(itemPrice) ?? 0.0;

        if (itemName.isNotEmpty && price > 0) {
          items.add({'name': itemName, 'price': price, 'quantity': 1});
        }
      }
    }

    // If no structured items found, try to extract prices and create simple items
    if (items.isEmpty) {
      for (final line in lines) {
        final priceMatches = pricePattern.allMatches(line);
        for (final match in priceMatches) {
          final price = double.tryParse(match.group(1) ?? '0') ?? 0.0;
          if (price > 0) {
            items.add({
              'name': 'Item ${items.length + 1}',
              'price': price,
              'quantity': 1,
            });
          }
        }
      }
    }

    return {
      'merchant': merchant ?? 'Unknown Merchant',
      'date': date ?? DateTime.now().toIso8601String(),
      'total': total,
      'items': items,
      'rawText': text,
    };
  }

  // Scan multiple receipts
  Future<List<Map<String, dynamic>>> scanMultipleReceipts(
    List<File> imageFiles,
  ) async {
    final List<Map<String, dynamic>> results = [];
    for (final file in imageFiles) {
      final result = await scanReceipt(file);
      results.add(result);
    }
    return results;
  }

  // Set camera mode
  Future<void> setMode(CameraMode mode) async {
    _currentMode = mode;
    if (mode == CameraMode.scan) {
      // You can add scan-specific settings here
      await _cameraController.setFlashMode(FlashMode.torch);
    } else {
      await _cameraController.setFlashMode(FlashMode.off);
    }
  }

  // Toggle flash
  Future<void> toggleFlash() async {
    final currentFlash = _cameraController.value.flashMode;
    FlashMode newFlash;

    switch (currentFlash) {
      case FlashMode.off:
        newFlash = FlashMode.torch;
        break;
      case FlashMode.torch:
        newFlash = FlashMode.auto;
        break;
      case FlashMode.auto:
        newFlash = FlashMode.always;
        break;
      case FlashMode.always:
        newFlash = FlashMode.off;
        break;
    }

    await _cameraController.setFlashMode(newFlash);
  }

  // Zoom camera
  Future<void> zoom(double scale) async {
    final minZoom = await _cameraController.getMinZoomLevel();
    final maxZoom = await _cameraController.getMaxZoomLevel();
    _currentZoomLevel = _currentZoomLevel * scale;
    _currentZoomLevel = _currentZoomLevel.clamp(minZoom, maxZoom);
    await _cameraController.setZoomLevel(_currentZoomLevel);
  }

  // Get camera info
  Map<String, dynamic> getCameraInfo() {
    if (!_isInitialized) {
      return {'status': 'not_initialized'};
    }

    return {
      'status': 'initialized',
      'lensDirection': _cameraController.description.lensDirection.name,
      'isRecording': _isRecording,
      'mode': _currentMode.name,
      'flashMode': _cameraController.value.flashMode.name,
      'zoomLevel': _currentZoomLevel,
      'exposureMode': _cameraController.value.exposureMode.name,
    };
  }

  // Cleanup
  Future<void> dispose() async {
    _recordingTimer?.cancel();
    _recordingTimer = null;

    if (_isInitialized) {
      await _cameraController.dispose();
      await _textRecognizer.close();
      _isInitialized = false;
    }

    if (kDebugMode) {
      print('Camera service disposed');
    }
  }

  // Check permissions (you'll need to handle permissions in your app)
  Future<bool> checkPermissions() async {
    // Note: You need to implement permission checking based on your target platforms
    // This typically involves using permission_handler package
    return true;
  }
}
