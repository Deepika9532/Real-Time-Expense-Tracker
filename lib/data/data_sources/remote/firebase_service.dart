import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../../core/errors/exceptions.dart';
import '../../models/user_model.dart';

class FirebaseService {
  firebase_auth.FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;

  firebase_auth.FirebaseAuth get auth {
    _auth ??= firebase_auth.FirebaseAuth.instance;
    return _auth!;
  }

  FirebaseFirestore get firestore {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

  FirebaseService({
    firebase_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) {
    _auth = auth;
    _firestore = firestore;
  }

  // Get current Firebase user
  firebase_auth.User? get currentUser => auth.currentUser;

  // Auth operations
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw InvalidCredentialsException(message: 'Sign in failed');
      }

      return await _getUserFromFirestore(credential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw InvalidCredentialsException(
          message: _getAuthErrorMessage(e.code), code: e.code);
    } catch (e) {
      throw InvalidCredentialsException(
          message: 'Sign in failed: ${e.toString()}');
    }
  }

  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw InvalidCredentialsException(message: 'Registration failed');
      }

      // Update display name
      await credential.user!.updateDisplayName(name);

      // Create user document in Firestore
      final user = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        isEmailVerified: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _createUserInFirestore(user);

      // Send verification email
      await credential.user!.sendEmailVerification();

      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw InvalidCredentialsException(
          message: _getAuthErrorMessage(e.code), code: e.code);
    } catch (e) {
      throw InvalidCredentialsException(
          message: 'Registration failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw UnauthorizedException(message: 'Sign out failed: ${e.toString()}');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user == null) return null;

      return await _getUserFromFirestore(user.uid);
    } catch (e) {
      return null;
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw InvalidCredentialsException(
          message: _getAuthErrorMessage(e.code), code: e.code);
    } catch (e) {
      throw InvalidCredentialsException(
          message: 'Password reset failed: ${e.toString()}');
    }
  }

  Future<UserModel> updateUserProfile(UserModel user) async {
    try {
      final firebaseUser = auth.currentUser;
      if (firebaseUser == null) {
        throw UnauthorizedException(message: 'No user signed in');
      }

      // Update display name and photo URL in Firebase Auth
      if (user.name != null) {
        await firebaseUser.updateDisplayName(user.name);
      }
      if (user.profilePicture != null) {
        await firebaseUser.updatePhotoURL(user.profilePicture);
      }

      // Update user document in Firestore
      final updatedUser = user.copyWith(updatedAt: DateTime.now());
      await _updateUserInFirestore(updatedUser);

      return updatedUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw UnauthorizedException(
          message: _getAuthErrorMessage(e.code), code: e.code);
    } catch (e) {
      throw UnauthorizedException(
          message: 'Profile update failed: ${e.toString()}');
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null || user.email == null) {
        throw UnauthorizedException(message: 'No user signed in');
      }

      // Re-authenticate user
      final credential = firebase_auth.EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw InvalidCredentialsException(
          message: _getAuthErrorMessage(e.code), code: e.code);
    } catch (e) {
      throw InvalidCredentialsException(
          message: 'Password change failed: ${e.toString()}');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        throw UnauthorizedException(message: 'No user signed in');
      }

      // Delete user document from Firestore
      await _deleteUserFromFirestore(user.uid);

      // Delete user from Firebase Auth
      await user.delete();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw UnauthorizedException(
          message: _getAuthErrorMessage(e.code), code: e.code);
    } catch (e) {
      throw UnauthorizedException(
          message: 'Account deletion failed: ${e.toString()}');
    }
  }

  // Firestore operations
  Future<UserModel> _getUserFromFirestore(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        throw NotFoundException(message: 'User not found');
      }

      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ParseException(message: 'Failed to get user: ${e.toString()}');
    }
  }

  Future<void> _createUserInFirestore(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to create user: ${e.toString()}');
    }
  }

  Future<void> _updateUserInFirestore(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.id).update(user.toJson());
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to update user: ${e.toString()}');
    }
  }

  Future<void> _deleteUserFromFirestore(String uid) async {
    try {
      await firestore.collection('users').doc(uid).delete();
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to delete user: ${e.toString()}');
    }
  }

  // Helper method to get user-friendly error messages
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Invalid password';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'requires-recent-login':
        return 'Please sign in again to continue';
      default:
        return 'Authentication error: $code';
    }
  }
}
