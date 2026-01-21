import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/profile_entity.dart';
import '../providers/profile_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProfileProvider>();
    final profile = provider.profile!;

    nameController.text = profile.name;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                provider.saveProfile(
                  ProfileEntity(
                    id: profile.id,
                    name: nameController.text,
                    email: profile.email,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
