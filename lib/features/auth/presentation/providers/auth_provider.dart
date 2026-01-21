import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/register_user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;

  AuthProvider({
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
  });

  UserEntity? user;
  bool isLoading = false;

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    user = await loginUser(email, password);

    isLoading = false;
    notifyListeners();
  }

  Future<void> register(String email, String password, String name) async {
    isLoading = true;
    notifyListeners();

    user = await registerUser(email, password, name);

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await logoutUser();
    user = null;
    notifyListeners();
  }
}
