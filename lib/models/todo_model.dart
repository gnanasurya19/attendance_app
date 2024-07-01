class TodoModel {
  String? todoName;
  String? image;
  bool? isCompleted;
  DateTime? date;
  String? label;

  TodoModel(
      {this.todoName, this.image, this.isCompleted, this.date, this.label});

  @override
  String toString() {
    return '''todoName:$todoName,\nimage:$image,\nisCompleted:$isCompleted,\ndate:$date,''';
  }
}
