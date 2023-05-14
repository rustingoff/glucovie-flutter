import 'package:glucovie/pages/auth/loginScreen.dart';
import 'package:glucovie/pages/calendar_page.dart';
import 'package:flutter/material.dart';
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CalendarScreen(),
        themeMode: ThemeMode.light,
      ));
}
