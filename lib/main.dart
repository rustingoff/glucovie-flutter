import 'package:glucovie/pages/auth/loginScreen.dart';
import 'package:glucovie/pages/auth/signUpScreen.dart';
import 'package:glucovie/pages/welcome_page.dart';
import 'package:glucovie/pages/blog_page.dart';
import 'package:glucovie/pages/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:glucovie/pages/chart_page.dart';
import 'package:glucovie/pages/home_notes_page.dart';
import 'package:glucovie/pages/main_page.dart';
import 'package:glucovie/pages/settings_page.dart';
import 'package:glucovie/provider/event_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const GlucoVie()));
}

class GlucoVie extends StatelessWidget {
  const GlucoVie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SignUpScreen(),
        themeMode: ThemeMode.light,
        routes: {
          "main_p": (BuildContext context) => const MainPage(),
          "chart_p": (BuildContext context) => const ChartScreen(),
          "notes_p": (BuildContext context) => const HomeNotesPage(),
          "calendar_p": (BuildContext context) => const CalendarScreen(),
          "blog_p": (BuildContext context) => const BlogScreen(),
          "settings_p": (BuildContext context) => const SettingsScreen(),
          "welcome_p": (BuildContext context) => const WelcomeScreen(),
          "login_p": (BuildContext context) => const LoginScreen(),
        },
      ));
}
