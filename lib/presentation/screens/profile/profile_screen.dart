import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/constants.dart';
import '../../../core/widgets/animations/fade_in_animation.dart';
import '../../../core/widgets/common/error_widget.dart';
import '../../../core/widgets/common/loading_widget.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return FadeInAnimation(child: _buildBody(context, state));
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(child: LoadingWidget());
    }

    if (state is ProfileError) {
      return CustomErrorWidget(
        errorMessage: state.message,
        onRetry: () => context.read<ProfileCubit>().loadProfile(),
      );
    }

    if (state is ProfileLoaded) {
      final profile = state.profile;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            ProfileHeader(profile: profile),

            const SizedBox(height: AppConstants.paddingXL),

            // Personal Information Section
            Text(
              'Personal Information',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: AppConstants.paddingM),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                child: Column(
                  children: [
                    SettingsTile(
                      icon: Icons.person_outline,
                      title: 'Name',
                      subtitle: profile.name,
                      onTap: () => _editProfile(context),
                    ),
                    const Divider(),
                    SettingsTile(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      subtitle: profile.email,
                      onTap: () => _editProfile(context),
                    ),
                    const Divider(),
                    SettingsTile(
                      icon: Icons.phone_outlined,
                      title: 'Phone',
                      subtitle: profile.phone ?? 'Not provided',
                      onTap: () => _editProfile(context),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.paddingXL),

            // Settings Section
            Text(
              'Settings',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: AppConstants.paddingM),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                child: Column(
                  children: [
                    SettingsTile(
                      icon: Icons.settings_outlined,
                      title: 'App Settings',
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.settings),
                    ),
                    const Divider(),
                    SettingsTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      trailing: Switch(
                        value: profile.notificationsEnabled,
                        onChanged: (value) => context
                            .read<ProfileCubit>()
                            .toggleNotifications(value),
                      ),
                    ),
                    const Divider(),
                    SettingsTile(
                      icon: Icons.security_outlined,
                      title: 'Privacy & Security',
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    const Divider(),
                    SettingsTile(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.paddingXL),

            // Account Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                child: Column(
                  children: [
                    SettingsTile(
                      icon: Icons.logout_outlined,
                      title: 'Logout',
                      iconColor: Theme.of(context).colorScheme.error,
                      onTap: () => _showLogoutDialog(context),
                    ),
                    const Divider(),
                    SettingsTile(
                      icon: Icons.delete_outline,
                      title: 'Delete Account',
                      titleColor: Theme.of(context).colorScheme.error,
                      iconColor: Theme.of(context).colorScheme.error,
                      onTap: () => _showDeleteAccountDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container();
  }

  void _editProfile(BuildContext context) {
    // Navigate to edit profile screen
    // Navigator.pushNamed(context, AppRoutes.editProfile);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProfileCubit>().logout();
              // Navigate to login screen
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProfileCubit>().deleteAccount();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
