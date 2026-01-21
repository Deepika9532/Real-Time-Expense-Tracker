// File: lib/data/repositories/auth_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/local/hive_service.dart';
import '../data_sources/remote/firebase_service.dart';
import '../models/user_model.dart' as data;

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final FirebaseService firebaseService;
  final HiveService hiveService;
  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.firebaseService,
    required this.hiveService,
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  // ========================================================================
  // MAPPING METHODS
  // ========================================================================

  domain.User _mapUserModelToEntity(data.UserModel model) {
    return domain.User(
      id: model.id,
      email: model.email,
      name: model.name,
      phoneNumber: model.phoneNumber,
      profilePicture: model.profilePicture,
      // ignore: dead_null_aware_expression
      currency: model.currency ?? 'USD',
      // ignore: dead_null_aware_expression
      language: model.language ?? 'en',
      preferences: model.preferences != null
          ? _convertToDomainPreferences(model.preferences!)
          : null,
      // ignore: dead_null_aware_expression
      isPremium: model.isPremium ?? false,
      premiumExpiresAt: model.premiumExpiresAt,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      lastLoginAt: model.lastLoginAt,
      // ignore: dead_null_aware_expression
      isEmailVerified: model.isEmailVerified ?? false,
      metadata: model.metadata,
    );
  }

  data.UserModel _mapEntityToUserModel(domain.User entity) {
    return data.UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      profilePicture: entity.profilePicture,
      currency: entity.currency,
      language: entity.language,
      preferences: _convertFromDomainPreferences(entity.preferences),
      isPremium: entity.isPremium,
      premiumExpiresAt: entity.premiumExpiresAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      lastLoginAt: entity.lastLoginAt,
      isEmailVerified: entity.isEmailVerified,
      metadata: entity.metadata,
    );
  }

  domain.User _mapFirebaseUserToEntity(firebase_auth.User firebaseUser) {
    return domain.User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      profilePicture: firebaseUser.photoURL,
      isEmailVerified: firebaseUser.emailVerified,
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
      lastLoginAt: firebaseUser.metadata.lastSignInTime ?? DateTime.now(),
      updatedAt: DateTime.now(),
      currency: 'USD',
      language: 'en',
      isPremium: false,
    );
  }

  // ========================================================================
  // PREFERENCE CONVERSION METHODS
  // ========================================================================

  domain.UserPreferences? _convertToDomainPreferences(
      data.UserPreferences prefs) {
    return domain.UserPreferences(
      enableNotifications: prefs.enableNotifications,
      enableBudgetAlerts: prefs.enableBudgetAlerts,
      enableDailyReminders: prefs.enableDailyReminders,
      enableSyncOnWifi: prefs.enableSyncOnWifi,
      enableBiometricAuth: prefs.enableBiometricAuth,
      themeMode: _convertThemeModeToDomain(prefs.themeMode),
      dateFormat: prefs.dateFormat,
      startDayOfWeek: prefs.startDayOfWeek,
      startDayOfMonth: prefs.startDayOfMonth,
      showDecimals: prefs.showDecimals,
      categorySortBy: _convertCategorySortByToDomain(prefs.categorySortBy),
      expenseSortBy: _convertExpenseSortByToDomain(prefs.expenseSortBy),
    );
  }

  data.UserPreferences? _convertFromDomainPreferences(
      domain.UserPreferences? prefs) {
    if (prefs == null) return null;
    return data.UserPreferences(
      enableNotifications: prefs.enableNotifications,
      enableBudgetAlerts: prefs.enableBudgetAlerts,
      enableDailyReminders: prefs.enableDailyReminders,
      enableSyncOnWifi: prefs.enableSyncOnWifi,
      enableBiometricAuth: prefs.enableBiometricAuth,
      themeMode: _convertThemeModeFromDomain(prefs.themeMode),
      dateFormat: prefs.dateFormat,
      startDayOfWeek: prefs.startDayOfWeek,
      startDayOfMonth: prefs.startDayOfMonth,
      showDecimals: prefs.showDecimals,
      categorySortBy: _convertCategorySortByFromDomain(prefs.categorySortBy),
      expenseSortBy: _convertExpenseSortByFromDomain(prefs.expenseSortBy),
    );
  }

  domain.ThemeMode _convertThemeModeToDomain(data.ThemeMode dataThemeMode) {
    switch (dataThemeMode) {
      case data.ThemeMode.system:
        return domain.ThemeMode.system;
      case data.ThemeMode.light:
        return domain.ThemeMode.light;
      case data.ThemeMode.dark:
        return domain.ThemeMode.dark;
    }
  }

  data.ThemeMode _convertThemeModeFromDomain(domain.ThemeMode domainThemeMode) {
    switch (domainThemeMode) {
      case domain.ThemeMode.system:
        return data.ThemeMode.system;
      case domain.ThemeMode.light:
        return data.ThemeMode.light;
      case domain.ThemeMode.dark:
        return data.ThemeMode.dark;
    }
  }

  domain.CategorySortBy _convertCategorySortByToDomain(
      data.CategorySortBy dataCategorySortBy) {
    switch (dataCategorySortBy) {
      case data.CategorySortBy.name:
        return domain.CategorySortBy.name;
      case data.CategorySortBy.usage:
        return domain.CategorySortBy.usage;
      case data.CategorySortBy.amount:
        return domain.CategorySortBy.amount;
      case data.CategorySortBy.custom:
        return domain.CategorySortBy.custom;
    }
  }

  data.CategorySortBy _convertCategorySortByFromDomain(
      domain.CategorySortBy domainCategorySortBy) {
    switch (domainCategorySortBy) {
      case domain.CategorySortBy.name:
        return data.CategorySortBy.name;
      case domain.CategorySortBy.usage:
        return data.CategorySortBy.usage;
      case domain.CategorySortBy.amount:
        return data.CategorySortBy.amount;
      case domain.CategorySortBy.custom:
        return data.CategorySortBy.custom;
    }
  }

  domain.ExpenseSortBy _convertExpenseSortByToDomain(
      data.ExpenseSortBy dataExpenseSortBy) {
    switch (dataExpenseSortBy) {
      case data.ExpenseSortBy.date:
        return domain.ExpenseSortBy.date;
      case data.ExpenseSortBy.amount:
        return domain.ExpenseSortBy.amount;
      case data.ExpenseSortBy.category:
        return domain.ExpenseSortBy.category;
      case data.ExpenseSortBy.title:
        return domain.ExpenseSortBy.title;
    }
  }

  data.ExpenseSortBy _convertExpenseSortByFromDomain(
      domain.ExpenseSortBy domainExpenseSortBy) {
    switch (domainExpenseSortBy) {
      case domain.ExpenseSortBy.date:
        return data.ExpenseSortBy.date;
      case domain.ExpenseSortBy.amount:
        return data.ExpenseSortBy.amount;
      case domain.ExpenseSortBy.category:
        return data.ExpenseSortBy.category;
      case domain.ExpenseSortBy.title:
        return data.ExpenseSortBy.title;
    }
  }

  // ========================================================================
  // AUTHENTICATION METHODS
  // ========================================================================

  @override
  Future<Either<Failure, domain.User>> login(
    String email,
    String password,
  ) async {
    try {
      // Check network connection
      final hasConnection = await networkInfo.isConnected;
      if (!hasConnection) {
        return Left(NetworkFailure(message: 'No internet connection'));
      }

      // Authenticate with Firebase
      final userModel = await firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Convert to domain entity
      // ignore: unused_local_variable
      final userEntity = _mapUserModelToEntity(userModel);

      // Update last login timestamp
      final updatedUserModel = userModel.copyWith(lastLoginAt: DateTime.now());
      final updatedUserEntity = _mapUserModelToEntity(updatedUserModel);

      // Save user locally
      await hiveService.saveUser(updatedUserModel);

      return Right(updatedUserEntity);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } on InvalidCredentialsException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on ConnectionException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.User>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      // Check network connection
      final hasConnection = await networkInfo.isConnected;
      if (!hasConnection) {
        return Left(NetworkFailure(message: 'No internet connection'));
      }

      // Create user with Firebase
      final userModel = await firebaseService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      // Convert to domain entity
      final userEntity = _mapUserModelToEntity(userModel);

      // Save user locally
      await hiveService.saveUser(userModel);

      // Send email verification
      await firebaseAuth.currentUser?.sendEmailVerification();

      return Right(userEntity);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } on InvalidCredentialsException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on ConnectionException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message, errors: e.errors));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await firebaseService.signOut();
      await firebaseAuth.signOut();
      await hiveService.clearUser();
      await hiveService.clearAllData();

      return const Right(null);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.User>> getCurrentUser() async {
    try {
      // Try to get from local storage first
      final localUserModel = await hiveService.getUser();
      if (localUserModel != null) {
        final localUserEntity = _mapUserModelToEntity(localUserModel);
        return Right(localUserEntity);
      }

      // If not in local storage, get from Firebase
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        final userEntity = _mapFirebaseUserToEntity(currentUser);
        return Right(userEntity);
      }

      // Try remote service as fallback
      final remoteUserModel = await firebaseService.getCurrentUser();
      if (remoteUserModel != null) {
        await hiveService.saveUser(remoteUserModel);
        final remoteUserEntity = _mapUserModelToEntity(remoteUserModel);
        return Right(remoteUserEntity);
      }

      return Left(UnauthorizedFailure(message: 'No user logged in'));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      // Check network connection
      final hasConnection = await networkInfo.isConnected;
      if (!hasConnection) {
        return Left(NetworkFailure(message: 'No internet connection'));
      }

      await firebaseService.sendPasswordResetEmail(email: email);
      await firebaseAuth.sendPasswordResetEmail(email: email);

      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } on InvalidCredentialsException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on ConnectionException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.User>> updateProfile(domain.User user) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        return Left(AuthFailure(message: 'User not logged in'));
      }

      // Update Firebase Auth profile
      if (user.name != null && user.name!.isNotEmpty) {
        await currentUser.updateDisplayName(user.name);
      }

      if (user.profilePicture != null && user.profilePicture!.isNotEmpty) {
        await currentUser.updatePhotoURL(user.profilePicture);
      }

      // Update full user profile
      final userModel = _mapEntityToUserModel(user);
      try {
        final updatedUserModel =
            await firebaseService.updateUserProfile(userModel);
        await hiveService.saveUser(updatedUserModel);
        final updatedUserEntity = _mapUserModelToEntity(updatedUserModel);
        return Right(updatedUserEntity);
      } on ConnectionException {
        // Save locally even if remote fails
        await hiveService.saveUser(userModel);
        return Right(user);
      }
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on ConnectionException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail(String code) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        return Left(AuthFailure(message: 'User not logged in'));
      }

      // Note: Standard Firebase email verification doesn't use a code parameter
      // This implementation assumes the code is handled elsewhere
      await currentUser.sendEmailVerification();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailVerified() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        return const Right(false);
      }

      await currentUser.reload();
      return Right(firebaseAuth.currentUser?.emailVerified ?? false);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      await firebaseService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return const Right(null);
    } on InvalidCredentialsException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on ConnectionException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await firebaseService.deleteAccount();
      await firebaseAuth.currentUser?.delete();
      await hiveService.clearUser();
      await hiveService.clearAllData();

      return const Right(null);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } on ConnectionException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final user = await hiveService.getUser();
      final firebaseUser = firebaseAuth.currentUser;
      return Right(user != null || firebaseUser != null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailRegistered(String email) async {
    try {
      final methods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      return Right(methods.isNotEmpty);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerificationEmail() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        return Left(AuthFailure(message: 'User not logged in'));
      }

      await currentUser.sendEmailVerification();
      return const Right(null);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.User>> signInWithGoogle() async {
    try {
      // TODO: Implement Google sign in
      return Left(UnknownFailure(message: 'Google sign in not implemented'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.User>> signInWithApple() async {
    try {
      // TODO: Implement Apple sign in
      return Left(UnknownFailure(message: 'Apple sign in not implemented'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.User>> updatePreferences(
      domain.UserPreferences preferences) async {
    try {
      // Get current user
      final currentUserResult = await getCurrentUser();

      return currentUserResult.fold(
        (failure) => Left(AuthFailure(message: 'User not logged in')),
        (currentUser) async {
          // Update user with new preferences
          final updatedUser = domain.User(
            id: currentUser.id,
            email: currentUser.email,
            name: currentUser.name,
            phoneNumber: currentUser.phoneNumber,
            profilePicture: currentUser.profilePicture,
            currency: currentUser.currency,
            language: currentUser.language,
            preferences: preferences,
            isPremium: currentUser.isPremium,
            premiumExpiresAt: currentUser.premiumExpiresAt,
            createdAt: currentUser.createdAt,
            updatedAt: DateTime.now(),
            lastLoginAt: currentUser.lastLoginAt,
            isEmailVerified: currentUser.isEmailVerified,
            metadata: currentUser.metadata,
          );

          return await updateProfile(updatedUser);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmailWithCode(String code) async {
    try {
      // TODO: Implement email verification with code
      return const Right(null);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // ========================================================================
  // HELPER METHODS
  // ========================================================================

  Failure _handleFirebaseAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthFailure(
          message: 'No user found with this email',
          code: e.code,
        );
      case 'wrong-password':
        return AuthFailure(
          message: 'Incorrect password',
          code: e.code,
        );
      case 'email-already-in-use':
        return AuthFailure(
          message: 'Email is already registered',
          code: e.code,
        );
      case 'invalid-email':
        return ValidationFailure(message: 'Invalid email address');
      case 'weak-password':
        return ValidationFailure(message: 'Password is too weak');
      case 'user-disabled':
        return AuthFailure(
          message: 'This account has been disabled',
          code: e.code,
        );
      case 'too-many-requests':
        return AuthFailure(
          message: 'Too many attempts. Please try again later',
          code: e.code,
        );
      case 'operation-not-allowed':
        return AuthFailure(
          message: 'This operation is not allowed',
          code: e.code,
        );
      case 'invalid-credential':
        return AuthFailure(
          message: 'Invalid credentials provided',
          code: e.code,
        );
      default:
        return AuthFailure(
          message: e.message ?? 'Authentication failed',
          code: e.code,
        );
    }
  }
}
