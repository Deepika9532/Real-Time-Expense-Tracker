import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_local_data_source.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl(this.localDataSource);

  @override
  Future<ProfileEntity> getProfile() {
    return localDataSource.getProfile();
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) {
    final model = ProfileModel(
      id: profile.id,
      name: profile.name,
      email: profile.email,
      imageUrl: profile.imageUrl,
    );
    return localDataSource.saveProfile(model);
  }
}
