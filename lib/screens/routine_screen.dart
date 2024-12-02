import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../utils/routine_service.dart';

class RoutineScreen extends StatefulWidget {
  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  final TextEditingController _routineController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final RoutineService _routineService = RoutineService();
  List<Routine> _routines = [];

  @override
  void initState() {
    super.initState();
    _routineService.init().then((_) {
      setState(() {
        _routines = _routineService.getRoutines();
      });
    });
  }

  void _addRoutine() {
    if (_routineController.text.isNotEmpty && _timeController.text.isNotEmpty) {
      final routine = Routine(
        activity: _routineController.text,
        time: _timeController.text,
      );
      _routineService.addRoutine(routine).then((_) {
        setState(() {
          _routines = _routineService.getRoutines();
          _routineController.clear();
          _timeController.clear();
        });
      });
    }
  }

  void _deleteRoutine(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Atividade"),
          content: Text("Tem certeza que deseja excluir esta atividade?"),
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
                _routineService.deleteRoutine(index).then((_) {
                  setState(() {
                    _routines = _routineService.getRoutines();
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
        title: Text('Rotina do Bebê', style: TextStyle(fontFamily: 'Nunito', fontSize: 20)),
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
                    controller: _routineController,
                    decoration: InputDecoration(
                      labelText: 'Atividade',
                      prefixIcon: Icon(Icons.event_note),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    decoration: InputDecoration(
                      labelText: 'Horário',
                      prefixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addRoutine,
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
            child: ListView.builder(
              itemCount: _routines.length,
              itemBuilder: (context, index) {
                final routine = _routines[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      title: Text(
                        routine.activity,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        routine.time,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _deleteRoutine(index),
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
