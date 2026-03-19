import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/calendar_event.dart';
import '../utils/calendar_service.dart';
import '../utils/notification_service.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final TextEditingController _titleController = TextEditingController();
  final CalendarService _calendarService = CalendarService();
  List<CalendarEvent> _events = [];
  Map<DateTime, List<CalendarEvent>> _eventsMap = {};
  DateTime _selectedDate = DateTime.now();
  DateTime? _newEventDateTime;

  @override
  void initState() {
    super.initState();
    _calendarService.init().then((_) {
      setState(() {
        _events = _calendarService.getEvents();
        _eventsMap = _groupEventsByDate(_events);
      });
    });
  }

  Map<DateTime, List<CalendarEvent>> _groupEventsByDate(List<CalendarEvent> events) {
    Map<DateTime, List<CalendarEvent>> data = {};
    for (var event in events) {
      final date = DateTime(event.date.year, event.date.month, event.date.day);
      if (data[date] == null) {
        data[date] = [];
      }
      data[date]!.add(event);
    }
    return data;
  }

  List<CalendarEvent> _getEventsForDay(DateTime date) {
    return _eventsMap[DateTime(date.year, date.month, date.day)] ?? [];
  }

  void _addEvent() {
    if (_titleController.text.isNotEmpty && _newEventDateTime != null) {
      final date = _newEventDateTime!;
        final event = CalendarEvent(
          title: _titleController.text,
          date: date,
        );
        _calendarService.addEvent(event).then((_) {
          NotificationService.instance.scheduleNotification(
            DateTime.now().millisecondsSinceEpoch ~/ 1000,
            'Lembrete do Bebê',
            event.title,
            event.date,
          );

          setState(() {
            _events = _calendarService.getEvents();
            _eventsMap = _groupEventsByDate(_events);
            _titleController.clear();
            _newEventDateTime = null;
          });
        });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Título e data/hora são obrigatórios!')),
      );
    }
  }

  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );

    if (pickedDate == null) return;
    if (!mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      _newEventDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  void _deleteEvent(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Evento"),
          content: Text("Tem certeza que deseja excluir este evento?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Excluir"),
              onPressed: () {
                _calendarService.deleteEvent(index).then((_) {
                  setState(() {
                    _events = _calendarService.getEvents();
                    _eventsMap = _groupEventsByDate(_events);
                  });
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFFB3E5FC), // Azul bebê
      title: Text(
        'Calendário',
        style: TextStyle(fontFamily: 'Nunito', fontSize: 20),
      ),
      centerTitle: true,
      elevation: 0,
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Título do Evento',
                    prefixIcon: Icon(Icons.event),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: _pickDateTime,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Data e hora',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _newEventDateTime == null
                          ? 'Selecionar'
                          : '${_newEventDateTime!.day.toString().padLeft(2, '0')}/${_newEventDateTime!.month.toString().padLeft(2, '0')}/${_newEventDateTime!.year} '
                              '${_newEventDateTime!.hour.toString().padLeft(2, '0')}:${_newEventDateTime!.minute.toString().padLeft(2, '0')}',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB3E5FC),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDate,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Color(0xFFF8BBD0), // Rosa claro
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xFFB3E5FC), // Azul bebê
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _getEventsForDay(_selectedDate).length,
            itemBuilder: (context, index) {
              final event = _getEventsForDay(_selectedDate)[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 6.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    title: Text(
                      event.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      event.date.toLocal().toString().split(' ')[0],
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        final index = _events.indexOf(event);
                        _deleteEvent(index);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}


}
