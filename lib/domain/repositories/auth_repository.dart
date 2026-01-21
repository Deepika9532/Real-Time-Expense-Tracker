import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../core/errors/failures.dart';

abstract class AuthRepository {
  /// Sign in with email and password
  Future<Either<Failure, User>> login(String email, String password);

  /// Register a new user
  Future<Either<Failure, User>> register(
    String email,
    String password,
    String name,
  );

  /// Sign out the current user
  Future<Either<Failure, void>> logout();

  /// Get the currently logged-in user
  Future<Either<Failure, User>> getCurrentUser();

  /// Send password reset email
  Future<Either<Failure, void>> resetPassword(String email);

  /// Update user profile
  Future<Either<Failure, User>> updateProfile(User user);

  /// Change user password
  Future<Either<Failure, void>> changePassword(
    String oldPassword,
    String newPassword,
  );

  /// Delete user account
  Future<Either<Failure, void>> deleteAccount();

  /// Check if user is logged in
  Future<Either<Failure, bool>> isLoggedIn();

  /// Verify email address
  Future<Either<Failure, void>> verifyEmail(String code);

  /// Resend verification email
  Future<Either<Failure, void>> resendVerificationEmail();

  /// Update user preferences
  Future<Either<Failure, User>> updatePreferences(UserPreferences preferences);

  /// Sign in with Google (optional)
  Future<Either<Failure, User>> signInWithGoogle();

  /// Sign in with Apple (optional)
  Future<Either<Failure, User>> signInWithApple();

  /// Check if email is already registered
  Future<Either<Failure, bool>> isEmailRegistered(String email);

  /// Check if user's email is verified
  Future<Either<Failure, bool>> isEmailVerified();

  /// Verify email address with code
  Future<Either<Failure, void>> verifyEmailWithCode(String code);
}
