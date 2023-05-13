import "package:glucovie/models/note.dart";
import "package:intl/intl.dart";

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

class Utils {
  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd("ro-RO").format(dateTime);

    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final date = DateFormat.Hm("ro-RO").format(dateTime);

    return '$date';
  }
}