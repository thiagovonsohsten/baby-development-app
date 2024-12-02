// lib/models/calendar_event.dart
import 'package:hive/hive.dart';

part 'calendar_event.g.dart';

@HiveType(typeId: 1)
class CalendarEvent extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime date;

  CalendarEvent({required this.title, required this.date});
}
