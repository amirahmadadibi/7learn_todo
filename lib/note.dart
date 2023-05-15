import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject{
  @HiveField(0)
  String note;

  @HiveField(1)
  bool isDone;

  Note({required this.note, required this.isDone});

  @override
  String toString() {
    return '${this.note}-${this.isDone}';
  }
}
