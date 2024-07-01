import 'package:attendance_app/models/todo_model.dart';
import 'package:attendance_app/res/common_lib.dart';

class TodoController extends ChangeNotifier {
  TodoController() {
    _todoList = todoList.map((e) {
      if (e.date!.isAfter(DateTime.now())) {
        if ((e.date!.year == DateTime.now().year) &&
            (e.date!.month == DateTime.now().month) &&
            (e.date!.day == DateTime.now().day + 1)) {
          e.label = 'Tomorrow';
        } else if ((e.date!.year > DateTime.now().year) ||
            (e.date!.month > DateTime.now().month) ||
            (e.date!.day > DateTime.now().day)) {
          e.label = 'Upcoming';
        }
      } else {
        if ((e.date!.year == DateTime.now().year) &&
            (e.date!.month == DateTime.now().month) &&
            (e.date!.day == DateTime.now().day)) {
          e.label = 'Today';
        } else {
          e.label = 'Previous';
        }
      }

      return e;
    }).toList();
  }

  List<TodoModel> _todoList = [
    TodoModel(
      date: DateTime(2024, 06, 25),
      image:
          "https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isCompleted: false,
      todoName: 'Plan the meeting with client',
    ),
    TodoModel(
      date: DateTime(2024, 06, 24),
      image:
          "https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isCompleted: true,
      todoName: "Project plan for david's",
    ),
    TodoModel(
      date: DateTime(2024, 06, 25),
      image:
          "https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isCompleted: false,
      todoName: 'Send Proposal client',
    ),
    TodoModel(
      date: DateTime(2024, 06, 25),
      image:
          "https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isCompleted: false,
      todoName: 'Send Proposal client',
    ),
    TodoModel(
      date: DateTime(2024, 06, 26),
      image:
          "https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isCompleted: false,
      todoName: 'Send Proposal client',
    ),
    TodoModel(
      date: DateTime(2024, 06, 26),
      image:
          "https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isCompleted: false,
      todoName: 'Send Proposal client',
    ),
    TodoModel(
      date: DateTime(2024, 06, 27),
      image:
          "https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isCompleted: false,
      todoName: 'Send Proposal client',
    ),
    TodoModel(
      date: DateTime(2024, 07, 29),
      image:
          "https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isCompleted: false,
      todoName: 'Send Proposal client',
    ),
  ];
  List<TodoModel> get todoList {
    _todoList.sort(
      (a, b) => a.date!.compareTo(b.date!),
    );
    return _todoList;
  }

  List locations = [
    {
      'image':
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'placeName': 'R & D islambad',
      'location': 'street 20,92 - islambad',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1496754803883-1c38626e6d4d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDJ8fGl0JTIwc2VydmljZXN8ZW58MHx8MHx8fDA%3D',
      'placeName': 'AT & T',
      'location': 'USA',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1619892127776-08a763bfe34c?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'placeName': 'Sales Office',
      'location': 'Oman',
    },
  ];

  void markAsInComplete(TodoModel todo) {
    todo.isCompleted = false;
    notifyListeners();
  }

  void markAsComplete(TodoModel todo) {
    todo.isCompleted = true;
    notifyListeners();
  }
}
