// lib/utils/calendar_service.dart
import 'package:hive/hive.dart';
import '../models/calendar_event.dart';

class CalendarService {
  late Box<CalendarEvent> _eventBox;

  Future<void> init() async {
    _eventBox = await Hive.openBox<CalendarEvent>('calendar_events');
  }

  // Ajuste no retorno para garantir que seja uma lista de CalendarEvent
  List<CalendarEvent> getEvents() {
    return _eventBox.values.toList().cast<CalendarEvent>();
  }

  Future<void> addEvent(CalendarEvent event) async {
    await _eventBox.add(event);
  }

  Future<void> updateEvent(int index, CalendarEvent event) async {
    await _eventBox.putAt(index, event);
  }

  Future<void> deleteEvent(int index) async {
    await _eventBox.deleteAt(index);
  }
}
