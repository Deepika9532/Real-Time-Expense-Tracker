import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;

  AuthProvider({required AuthRepository repository})
      : _repository = repository {
    _checkAuthStatus();
  }

  // State
  AuthStatus _status = AuthStatus.initial;
  User? _currentUser;
  Failure? _failure;
  String? _errorMessage;
  String? _authToken;
  bool _rememberMe = false;

  // Getters
  AuthStatus get status => _status;
  User? get currentUser => _currentUser;
  Failure? get failure => _failure;
  String? get errorMessage => _errorMessage;
  String? get authToken => _authToken;
  bool get rememberMe => _rememberMe;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.loading;
  bool get hasError => _status == AuthStatus.error;

  // Check initial auth status
  Future<void> _checkAuthStatus() async {
    _setStatus(AuthStatus.loading);

    final result = await _repository.getCurrentUser();

    result.fold((failure) => _setStatus(AuthStatus.unauthenticated), (user) {
      _currentUser = user;
      _setStatus(AuthStatus.authenticated);
    });
  }

  // Login
  Future<bool> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    _setStatus(AuthStatus.loading);
    _rememberMe = rememberMe;

    // Changed to positional parameters as expected by repository
    final result = await _repository.login(email, password);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (user) {
        // Assuming repository returns a User object directly
        _currentUser = user;
        // If your User entity has a token property, uncomment this:
        // _authToken = user.token;
        _setStatus(AuthStatus.authenticated);
        return true;
      },
    );
  }

  // Register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setStatus(AuthStatus.loading);

    // Changed to positional parameters as expected by repository
    final result = await _repository.register(name, email, password);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (user) {
        // Assuming repository returns a User object directly
        _currentUser = user;
        // If your User entity has a token property, uncomment this:
        // _authToken = user.token;
        _setStatus(AuthStatus.authenticated);
        return true;
      },
    );
  }

  // Logout
  Future<void> logout() async {
    _setStatus(AuthStatus.loading);

    final result = await _repository.logout();

    result.fold((failure) => _handleFailure(failure), (_) {
      _currentUser = null;
      _authToken = null;
      _rememberMe = false;
      _setStatus(AuthStatus.unauthenticated);
    });
  }

  // Update profile
  Future<bool> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
  }) async {
    if (_currentUser == null) return false;

    _setStatus(AuthStatus.loading);

    final updatedUser = _currentUser!.copyWith(
      name: name ?? _currentUser!.name,
      email: email ?? _currentUser!.email,
      phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
      // Only include avatarUrl if your User entity has this property
      // avatarUrl: avatarUrl ?? _currentUser!.avatarUrl,
    );

    final result = await _repository.updateProfile(updatedUser);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (user) {
        _currentUser = user;
        _setStatus(AuthStatus.authenticated);
        return true;
      },
    );
  }

  // Change password
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _setStatus(AuthStatus.loading);

    // Changed to positional parameters as expected by repository
    final result =
        await _repository.changePassword(currentPassword, newPassword);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        _setStatus(AuthStatus.authenticated);
        return true;
      },
    );
  }

  // Forgot password - This method might not exist in repository
  Future<bool> forgotPassword({required String email}) async {
    _setStatus(AuthStatus.loading);

    // If forgotPassword doesn't exist in AuthRepository, you need to add it
    // or remove this method from AuthProvider
    try {
      // Temporarily commented out - uncomment if method exists in repository
      // final result = await _repository.forgotPassword(email);

      // For now, return error with ServerFailure (concrete implementation)
      _handleFailure(ServerFailure(message: 'Forgot password not implemented'));
      return false;

      /* Uncomment when repository method exists:
      return result.fold(
        (failure) {
          _handleFailure(failure);
          return false;
        },
        (_) {
          _setStatus(AuthStatus.unauthenticated);
          return true;
        },
      );
      */
    } catch (e) {
      _handleFailure(ServerFailure(message: e.toString()));
      return false;
    }
  }

  // Reset password
  Future<bool> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    _setStatus(AuthStatus.loading);

    // Changed to positional parameter as expected by repository
    final result = await _repository.resetPassword(token);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        _setStatus(AuthStatus.unauthenticated);
        return true;
      },
    );
  }

  // Verify email
  Future<bool> verifyEmail({required String token}) async {
    _setStatus(AuthStatus.loading);

    // Changed to positional parameter as expected by repository
    final result = await _repository.verifyEmail(token);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        // Assuming verifyEmail returns void, not User
        // If it returns User, change (_) to (user) and set _currentUser = user
        _setStatus(AuthStatus.authenticated);
        return true;
      },
    );
  }

  // Resend verification email
  Future<bool> resendVerificationEmail() async {
    if (_currentUser == null) return false;

    _setStatus(AuthStatus.loading);

    // Repository method expects no parameters (0 positional arguments)
    final result = await _repository.resendVerificationEmail();

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        _setStatus(AuthStatus.authenticated);
        return true;
      },
    );
  }

  // Delete account
  Future<bool> deleteAccount({required String password}) async {
    _setStatus(AuthStatus.loading);

    // Repository method expects no parameters (0 positional arguments)
    // Note: You're accepting password in the method signature but not using it
    // This might be intentional for your use case
    final result = await _repository.deleteAccount();

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        _currentUser = null;
        _authToken = null;
        _setStatus(AuthStatus.unauthenticated);
        return true;
      },
    );
  }

  // Refresh token - This method might not exist in repository
  Future<void> refreshToken() async {
    if (_authToken == null) return;

    // If refreshToken doesn't exist in AuthRepository, you need to add it
    // or remove this method from AuthProvider
    try {
      // Temporarily commented out - uncomment if method exists in repository
      // final result = await _repository.refreshToken(_authToken!);

      // For now, do nothing
      return;

      /* Uncomment when repository method exists:
      result.fold((failure) => _handleFailure(failure), (newToken) {
        _authToken = newToken;
        notifyListeners();
      });
      */
    } catch (e) {
      _handleFailure(ServerFailure(message: e.toString()));
    }
  }

  // Update user preferences
  Future<bool> updateUserPreferences(UserPreferences preferences) async {
    if (_currentUser == null) return false;

    final updatedUser = _currentUser!.copyWith(preferences: preferences);
    _currentUser = updatedUser;

    final result = await _repository.updateProfile(updatedUser);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (user) {
        _currentUser = user;
        notifyListeners();
        return true;
      },
    );
  }

  // Get user preferences
  UserPreferences? getUserPreferences() {
    return _currentUser?.preferences;
  }

  // Private methods
  void _setStatus(AuthStatus status) {
    _status = status;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    _failure = failure;
    _errorMessage = failure.message;
    _setStatus(AuthStatus.error);
  }

  // Clear error
  void clearError() {
    _failure = null;
    _errorMessage = null;
    if (_status == AuthStatus.error) {
      _setStatus(
        _currentUser != null
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
      );
    }
  }

  // Stream for authentication state
  Stream<Object?> get authState {
    // Return a stream that emits the current user when the auth status changes
    return Stream.fromFuture(Future.value(_currentUser));
  }
}
