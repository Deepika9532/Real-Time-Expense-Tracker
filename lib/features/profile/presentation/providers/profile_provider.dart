import 'package:flutter/material.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';

class ProfileProvider extends ChangeNotifier {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;

  ProfileProvider({
    required this.getProfile,
    required this.updateProfile,
  });

  ProfileEntity? profile;
  bool isLoading = false;

  Future<void> loadProfile() async {
    isLoading = true;
    notifyListeners();

    profile = await getProfile();

    isLoading = false;
    notifyListeners();
  }

  Future<void> saveProfile(ProfileEntity updatedProfile) async {
    await updateProfile(updatedProfile);
    profile = updatedProfile;
    notifyListeners();
  }
}
