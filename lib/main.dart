import 'package:glucovie/pages/auth/loginScreen.dart';
import 'package:glucovie/pages/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() {
  initializeDateFormatting().then((_) => runApp(GlucoVie()));
}

class GlucoVie extends StatelessWidget {
  const GlucoVie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalendarScreen(),
      themeMode: ThemeMode.light,
    );
  }
}
