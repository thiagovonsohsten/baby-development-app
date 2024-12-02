// lib/models/routine.dart
import 'package:hive/hive.dart';

part 'routine.g.dart';

@HiveType(typeId: 0)
class Routine extends HiveObject {
  @HiveField(0)
  String activity;

  @HiveField(1)
  String time;

  Routine({required this.activity, required this.time});
}
