import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.remote, this.local);

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await remote.login(email, password);
    await local.saveUser(user);
    return user;
  }

  @override
  Future<UserEntity> register(
      String email, String password, String name) async {
    final user = await remote.register(email, password, name);
    await local.saveUser(user);
    return user;
  }

  @override
  Future<void> logout() async {
    await local.clearUser();
  }
}
