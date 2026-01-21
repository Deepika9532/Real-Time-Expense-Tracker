import '../models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel> getProfile();
  Future<void> saveProfile(ProfileModel profile);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileModel? _cachedProfile;

  @override
  Future<ProfileModel> getProfile() async {
    return _cachedProfile ??
        const ProfileModel(
          id: '1',
          name: 'Lakshya',
          email: 'lakshya@example.com',
        );
  }

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    _cachedProfile = profile;
  }
}
