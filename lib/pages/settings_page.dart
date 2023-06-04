import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:glucovie/pages/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../api/apiClient.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notification = false;
  bool emailNotification = false;
  final ApiClient _apiClient = ApiClient();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getUserSettings();
  }

  void getUserSettings() {
    var res = _apiClient.getUserSettings();
    res.then((value) => {
    setState(() {
      notification = value.data["data"]["notification"];
      emailNotification = value.data["data"]["email_notification"];
    }),
    }).onError((error, stackTrace) => {});
  }

  List<Widget> buildEditingActions() =>
      [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {
            Map<String, dynamic> data = {
              "notification": notification,
              "email_notification": emailNotification,
            };
            var res = _apiClient.saveUserSettings(data);
            res.then((value) => {
            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Salvat !'),
              backgroundColor: Colors.purple.shade400,
            )),
            }).onError((error, stackTrace) => {});
            storage.write(key: "n", value: notification.toString());
            storage.write(key: "nm", value: emailNotification.toString());
          },
          icon: const Icon(Icons.done),
          label: const Text("Salvează"),
        ),
      ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: buildEditingActions(),
        title: const Text('Setări'),
        backgroundColor: Colors.purple,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text(
              'Setări de profil', style: TextStyle(color: Colors.purple),),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                activeSwitchColor: Colors.purple,
                onToggle: (value) {
                  setState(() {
                    notification = !notification;
                  });
                },
                initialValue: notification,
                leading: const Icon(Icons.notification_add_outlined),
                title: const Text('Pornește notificările'),
              ),
              SettingsTile.switchTile(
                activeSwitchColor: Colors.purple,
                onToggle: (value) {
                  setState(() {
                    emailNotification = !emailNotification;
                  });
                },
                initialValue: emailNotification,
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
