import 'package:glucovie/pages/navigation/navigation.dart';
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
                title: const Text('Pornește notificările'),
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
          SettingsSection(
            title: const Divider(
              height: 1,
              thickness: 1,
              endIndent: 0,
              color: Colors.black,
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.logout),
                title: const Text('Deconectează-te'),
                onPressed: (context) {
                  Navigator.pushNamed(context, "welcome_p");
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: navigation(context),
    );
  }
}
