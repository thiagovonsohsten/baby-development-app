// lib/utils/routine_service.dart
import 'package:hive/hive.dart';
import '../models/routine.dart';

class RoutineService {
  late Box<Routine> _routineBox;

  Future<void> init() async {
    _routineBox = await Hive.openBox<Routine>('routines');
  }

  List<Routine> getRoutines() {
    return _routineBox.values.toList();
  }

  Future<void> addRoutine(Routine routine) async {
    await _routineBox.add(routine);
  }

  Future<void> updateRoutine(int index, Routine routine) async {
    await _routineBox.putAt(index, routine);
  }

  Future<void> deleteRoutine(int index) async {
    await _routineBox.deleteAt(index);
  }
}
