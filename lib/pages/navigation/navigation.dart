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
          iconSize: 40,
          icon: Icon(
            Icons.home,
            color: ModalRoute.of(context)?.settings.name == "main_p"
                ? Colors.purple
                : Colors.black54,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "main_p");
          },
        ),
        IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.insert_chart,
            color: ModalRoute.of(context)?.settings.name == "chart_p"
                ? Colors.purple
                : Colors.black54,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "chart_p");
          },
        ),
        IconButton(
          iconSize: 40,
          focusColor: Colors.purple,
          hoverColor: Colors.purple,
          icon: Icon(
            Icons.note_add,
            color: ModalRoute.of(context)?.settings.name == "notes_p"
                ? Colors.purple
                : Colors.black54,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "notes_p");
          },
        ),
        IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.calendar_month_sharp,
            color: ModalRoute.of(context)?.settings.name == "calendar_p"
                ? Colors.purple
                : Colors.black54,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "calendar_p");
          },
        ),
        IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.newspaper_sharp,
            color: ModalRoute.of(context)?.settings.name == "blog_p"
                ? Colors.purple
                : Colors.black54,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "blog_p");
          },
        ),
        IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.settings,
            color: ModalRoute.of(context)?.settings.name == "settings_p"
                ? Colors.purple
                : Colors.black54,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "settings_p");
          },
        ),
      ],
    ),
  );
}
