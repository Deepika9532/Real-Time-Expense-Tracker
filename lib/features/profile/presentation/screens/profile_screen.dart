import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.profile == null
              ? Center(
                  child: ElevatedButton(
                    onPressed: () => provider.loadProfile(),
                    child: const Text('Load Profile'),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        provider.profile!.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(provider.profile!.email),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
    );
  }
}
