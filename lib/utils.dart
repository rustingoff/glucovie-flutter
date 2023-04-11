import 'dart:collection';
import "package:glucovie/models/note.dart";
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = { for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')) }
  ..addAll({
    kToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<Note> sortNotes(List<Note> notes, {bool ascending = true, by = "title"}) {
  if (by == "title") {
    notes.sort((a, b) => (a.title!).compareTo(b.title!));
  } else if (by == "createdAt") {
    notes.sort((a, b) => (a.createdAt!).compareTo(b.createdAt!));
  } else if (by == "updatedAt") {
    notes.sort((a, b) => (a.updatedAt!).compareTo(b.updatedAt!));
  }

  if (ascending) {
    return notes;
  }
  return notes.reversed.toList();
}