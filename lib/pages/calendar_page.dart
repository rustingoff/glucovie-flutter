import 'package:flutter/material.dart';
import 'package:glucovie/pages/event/event_edit_page.dart';
import 'package:glucovie/pages/navigation/navigation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants/text_styles.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'CALENDAR',
          style: appBarTitleTS,
        ),
      ),
      body: Padding(
        padding:const EdgeInsets.fromLTRB(0, 20, 0, 40),
        child: SfCalendar(
          view: CalendarView.month,
          initialSelectedDate: DateTime.now(),
          todayHighlightColor: Colors.purple,
          cellBorderColor: Colors.purple,
          backgroundColor: Colors.white,
          timeZone: "GTB Standard Time",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EventEditPage()),
        ),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: navigation(context),
    );
  }
}