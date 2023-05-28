import 'package:glucovie/api/apiClient.dart';
import 'package:glucovie/models/event.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier{
  final ApiClient _apiClient = ApiClient();
  final List<Event> _events = [];

  EventProvider() {
    var response = _apiClient.getEvents();
    response.then((value) => {
      for(var v in value.data["data"]){
        _events.add(
          Event(
            id: v["id"],
            title: v["title"],
            description: "",
            from: DateTime.parse(v["from"]),
            to: DateTime.parse(v["to"]),
          ),
        ),
      },
      notifyListeners(),
    }).onError((error, stackTrace) => {
      debugPrint("$error"),
    });
  }

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDay => _events;

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);

    notifyListeners();
  }
}