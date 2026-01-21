import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/profile.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfile() async {
    try {
      emit(ProfileLoading());

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock profile data
      final profile = Profile(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+1 234 567 8900',
        notificationsEnabled: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      );

      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> toggleNotifications(bool value) async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final updatedProfile = currentState.profile.copyWith(
        notificationsEnabled: value,
      );
      emit(ProfileLoaded(profile: updatedProfile));
    }
  }

  Future<void> logout() async {
    emit(ProfileInitial());
    // Add logout logic here
  }

  Future<void> deleteAccount() async {
    emit(ProfileInitial());
    // Add delete account logic here
  }

  Future<void> clearCache() async {
    // Add clear cache logic here
  }
}
