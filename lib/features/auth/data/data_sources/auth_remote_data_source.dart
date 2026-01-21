import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    return UserModel(id: '1', email: email, name: 'User');
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    return UserModel(id: '1', email: email, name: name);
  }
}
