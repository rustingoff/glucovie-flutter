import 'package:flutter/material.dart';
import 'package:glucovie/api/apiClient.dart';
import 'package:glucovie/constants/text_styles.dart';
import 'package:glucovie/models/event_data_source.dart';
import 'package:glucovie/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  final ApiClient _apiClient = ApiClient();


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDay;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text(
          "Nu au fost găsite evenimente",
          style: calendarNotEventTS,
        ),
      );
    }

    return Scaffold(
      body: SfCalendar(
        view: CalendarView.schedule,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        timeZone: "GTB Standard Time",
        todayHighlightColor: Colors.purple,
        scheduleViewSettings: const ScheduleViewSettings(
          hideEmptyScheduleWeek: true,
          monthHeaderSettings: MonthHeaderSettings(
            backgroundColor: Colors.purple,
          ),
        ),
        // appointmentBuilder: appointmentBuilder,
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: false,
        backgroundColor: Colors.purple,
        onPressed: () {
          setState(() {
            _apiClient.deleteEvent(provider.events.last.id);
            provider.deleteEvent(provider.events.last);
          });
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
