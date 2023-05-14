import 'package:flutter/material.dart';
import 'package:glucovie/pages/event/event_edit_page.dart';
import 'package:glucovie/pages/navigation/navigation.dart';
import 'package:glucovie/provider/event_provider.dart';
import 'package:glucovie/widgets/tasks_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants/text_styles.dart';
import '../models/event_data_source.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

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
          dataSource: EventDataSource(events),
          view: CalendarView.month,
          initialSelectedDate: DateTime.now(),
          todayHighlightColor: Colors.purple,
          cellBorderColor: Colors.purple,
          backgroundColor: Colors.white,
          timeZone: "GTB Standard Time",
          onLongPress: (details) {
            final provider = Provider.of<EventProvider>(context, listen: false);
            provider.setDate(details.date!);
            showModalBottomSheet(
                context: context,
                builder: (context) => const TasksWidget(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EventEditPage()),
        ),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: navigation(context),
    );
  }
}