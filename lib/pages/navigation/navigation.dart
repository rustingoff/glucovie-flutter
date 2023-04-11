import 'package:glucovie/pages/chart_page.dart';
import 'package:glucovie/pages/home_notes_page.dart';
import 'package:glucovie/pages/main_page.dart';
import 'package:glucovie/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../calendar_page.dart';


Container navigation(BuildContext context) {
  return Container(
    height: 80,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconButton(
          iconSize: 35,
          icon: const Icon(
            Icons.insert_chart,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                    const ChartScreen()));
          },
        ),
        IconButton(
          iconSize: 35,
          icon: const Icon(
            Icons.note_add,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                    const HomeNotesPage()));
          },
        ),
        IconButton(
          iconSize: 55,
          icon: const Icon(
            Icons.apps,
            color: Color(0xaa860095),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                    const MainPage()));
          },
        ),
        IconButton(
          iconSize: 35,
          icon: const Icon(
            Icons.calendar_month_sharp,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                    const CalendarScreen()));
          },
        ),
        IconButton(
          iconSize: 35,
          icon: const Icon(
            Icons.settings,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                    const SettingsScreen()));
          },
        ),
      ],
    ),
  );
}