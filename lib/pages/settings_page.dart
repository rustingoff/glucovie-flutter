import 'package:ecommerce/pages/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setări'),
        backgroundColor: Colors.purple,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Setări de profil', style: TextStyle(color: Colors.purple),),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                activeSwitchColor: Colors.purple,
                onToggle: (value) {},
                initialValue: false,
                leading: const Icon(Icons.notification_add_outlined),
                title: const Text('Pornește norificările'),
              ),
              SettingsTile.switchTile(
                activeSwitchColor: Colors.purple,
                onToggle: (value) {},
                initialValue: false,
                leading: const Icon(Icons.email),
                title: const Text('Trimite automat email medicului'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: navigation(context),
    );
  }
}
