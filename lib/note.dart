class Note {
  String note;
  bool isDone;

  Note({required this.note,required this.isDone});

  @override
  String toString() {
    return '${this.note}-${this.isDone}';
  }
}
