import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  FirebaseStorage? _storage;

  FirebaseStorage get storage {
    _storage ??= FirebaseStorage.instance;
    return _storage!;
  }

  FirebaseStorageService({FirebaseStorage? storage}) {
    _storage = storage;
  }

  /// Upload a file to Firebase Storage
  Future<String> uploadFile({
    required File file,
    required String folder,
    String? fileName,
  }) async {
    try {
      // Generate filename if not provided
      fileName = fileName ??
          '${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}';

      // Create full path
      String filePath = '$folder/$fileName';

      // Upload file
      final ref = storage.ref().child(filePath);
      final uploadTask = ref.putFile(file);

      // Wait for upload to complete
      final snapshot = await uploadTask.whenComplete(() => null);

      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }

  /// Upload receipt image
  Future<String> uploadReceipt({
    required File receiptImage,
    required String userId,
    String? customFileName,
  }) async {
    String fileName = customFileName ??
        'receipt_${DateTime.now().millisecondsSinceEpoch}${path.extension(receiptImage.path)}';

    return await uploadFile(
      file: receiptImage,
      folder: 'receipts/$userId',
      fileName: fileName,
    );
  }

  /// Upload user profile picture
  Future<String> uploadUserProfilePicture({
    required File profilePicture,
    required String userId,
  }) async {
    String fileName =
        'profile_${DateTime.now().millisecondsSinceEpoch}${path.extension(profilePicture.path)}';

    return await uploadFile(
      file: profilePicture,
      folder: 'profiles/$userId',
      fileName: fileName,
    );
  }

  /// Delete a file from Firebase Storage
  Future<void> deleteFile(String filePath) async {
    try {
      final ref = storage.ref().child(filePath);
      await ref.delete();
    } catch (e) {
      throw Exception('Delete failed: $e');
    }
  }

  /// Get download URL for a file
  Future<String> getDownloadUrl(String filePath) async {
    try {
      final ref = storage.ref().child(filePath);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Getting download URL failed: $e');
    }
  }

  /// Check if file exists
  Future<bool> fileExists(String filePath) async {
    try {
      final ref = storage.ref().child(filePath);
      final metadata = await ref.getMetadata();
      // ignore: unnecessary_null_comparison
      return metadata != null;
    } catch (e) {
      // If getting metadata fails, the file probably doesn't exist
      return false;
    }
  }

  /// Get file metadata
  Future<Map<String, dynamic>> getFileMetadata(String filePath) async {
    try {
      final ref = storage.ref().child(filePath);
      final metadata = await ref.getMetadata();

      return {
        'name': metadata.name,
        'bucket': metadata.bucket,
        'contentType': metadata.contentType,
        'size': metadata.size,
        'timeCreated': metadata.timeCreated?.toIso8601String(),
        'updated': metadata.updated?.toIso8601String(),
      };
    } catch (e) {
      throw Exception('Getting metadata failed: $e');
    }
  }

  /// List files in a folder
  Future<List<String>> listFiles(String folderPath) async {
    try {
      final ref = storage.ref().child(folderPath);
      final result = await ref.listAll();

      return result.items.map((item) => item.fullPath).toList();
    } catch (e) {
      throw Exception('Listing files failed: $e');
    }
  }
}
