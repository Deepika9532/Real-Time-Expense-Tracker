import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';
import 'widgets/settings_tile.dart';
import 'widgets/theme_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Settings
                Text(
                  'App Settings',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),

                const SizedBox(height: AppConstants.paddingM),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingM),
                    child: Column(
                      children: [
                        SettingsTile(
                          icon: Icons.palette_outlined,
                          title: 'Theme',
                          subtitle: 'Dark/Light Mode',
                          trailing: const ThemeSwitch(),
                        ),
                        const Divider(),
                        SettingsTile(
                          icon: Icons.language_outlined,
                          title: 'Language',
                          subtitle: 'English',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _changeLanguage(context),
                        ),
                        const Divider(),
                        SettingsTile(
                          icon: Icons.currency_exchange_outlined,
                          title: 'Currency',
                          subtitle: 'USD (\$)',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _changeCurrency(context),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.paddingXL),

                // Display Settings
                Text(
                  'Display',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),

                const SizedBox(height: AppConstants.paddingM),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingM),
                    child: Column(
                      children: [
                        SettingsTile(
                          icon: Icons.format_size_outlined,
                          title: 'Font Size',
                          subtitle: 'Medium',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _changeFontSize(context),
                        ),
                        const Divider(),
                        SettingsTile(
                          icon: Icons.dashboard_outlined,
                          title: 'Default View',
                          subtitle: 'Dashboard',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _changeDefaultView(context),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.paddingXL),

                // Data Management
                Text(
                  'Data Management',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),

                const SizedBox(height: AppConstants.paddingM),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingM),
                    child: Column(
                      children: [
                        SettingsTile(
                          icon: Icons.backup_outlined,
                          title: 'Backup Data',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _backupData(context),
                        ),
                        const Divider(),
                        SettingsTile(
                          icon: Icons.restore_outlined,
                          title: 'Restore Data',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _restoreData(context),
                        ),
                        const Divider(),
                        SettingsTile(
                          icon: Icons.delete_sweep_outlined,
                          title: 'Clear Cache',
                          subtitle: 'Free up storage space',
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _clearCache(context),
                            color: Theme.of(context).colorScheme.error,
                          ),
                          onTap: () => _clearCache(context),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.paddingXL),

                // About
                Text(
                  'About',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),

                const SizedBox(height: AppConstants.paddingM),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingM),
                    child: Column(
                      children: [
                        SettingsTile(
                          icon: Icons.info_outline,
                          title: 'App Version',
                          subtitle: '1.0.0',
                          onTap: () {},
                        ),
                        const Divider(),
                        SettingsTile(
                          icon: Icons.privacy_tip_outlined,
                          title: 'Privacy Policy',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _openPrivacyPolicy(context),
                        ),
                        const Divider(),
                        SettingsTile(
                          icon: Icons.description_outlined,
                          title: 'Terms of Service',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _openTermsOfService(context),
                        ),
                        const Divider(),
                        SettingsTile(
                          icon: Icons.star_outline,
                          title: 'Rate App',
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _rateApp(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _changeLanguage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              trailing: const Icon(Icons.check),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('Spanish'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('French'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _changeCurrency(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('USD (\$)'),
              trailing: const Icon(Icons.check),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('EUR (€)'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('GBP (£)'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _changeFontSize(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Font Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Small'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('Medium'),
              trailing: const Icon(Icons.check),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('Large'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _changeDefaultView(BuildContext context) {
    // Implement default view change
  }

  void _backupData(BuildContext context) {
    // Implement data backup
  }

  void _restoreData(BuildContext context) {
    // Implement data restore
  }

  void _clearCache(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Are you sure you want to clear all cached data?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProfileCubit>().clearCache();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _openPrivacyPolicy(BuildContext context) {
    // Open privacy policy
  }

  void _openTermsOfService(BuildContext context) {
    // Open terms of service
  }

  void _rateApp(BuildContext context) {
    // Open app store for rating
  }
}
