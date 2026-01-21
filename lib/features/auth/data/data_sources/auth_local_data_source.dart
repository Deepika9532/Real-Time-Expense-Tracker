import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  UserModel? _cachedUser;

  @override
  Future<UserModel?> getUser() async => _cachedUser;

  @override
  Future<void> saveUser(UserModel user) async {
    _cachedUser = user;
  }

  @override
  Future<void> clearUser() async {
    _cachedUser = null;
  }
}
