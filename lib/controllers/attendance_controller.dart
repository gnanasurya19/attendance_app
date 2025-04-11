import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:intl/intl.dart';

class AttendanceController extends ChangeNotifier {
  int month = DateTime.now().month;
  String get selectedMonth => DateFormat('MMMM').format(DateTime(2024, month));
  int selectedYear = DateTime.now().year;

  //calendar
  int calMonth = DateTime.now().month;

  String get selectedCalMonth =>
      DateFormat('MMMM').format(DateTime(2023, calMonth));

  int selectedCalYear = DateTime.now().year;

  AttendanceController() {
    getMonthlyData();
  }

  getMonthlyData() {
    final firstDateofMonth = DateTime(selectedYear, month, 1);
    final lastDateofMonth = DateTime(selectedYear, month + 1, 1);
    if (hiveBox.isNotEmpty) {
      attendanceList = hiveBox.values
          .where((element) =>
              element.date!.isAfter(firstDateofMonth) &&
              element.date!.isBefore(lastDateofMonth))
          .toList();
    }
    notifyListeners();
  }

  List<AttendanceModel> attendanceList = [];

  bool isAnimate = false;

  incYear() {
    selectedCalYear++;
    notifyListeners();
  }

  decYear() {
    selectedCalYear--;
    notifyListeners();
  }

  onCalMonthChange(int month) {
    calMonth = month;
    notifyListeners();
  }

  changeCalMonthandYear() {
    month = calMonth;
    selectedYear = selectedCalYear;
    getMonthlyData();
  }

  increaseMonth() {
    if (month == 12) {
      month = 1;
      selectedYear++;
    } else {
      month++;
    }
    isAnimate = !isAnimate;
    getMonthlyData();
  }

  decreaseMonth() {
    if (month == 1) {
      month = 12;
      selectedYear--;
    } else {
      month--;
    }

    isAnimate = !isAnimate;
    getMonthlyData();
  }

  resetCalendar() {
    selectedYear = DateTime.now().year;
    month = DateTime.now().month;
    calMonth = month;
    selectedCalYear = selectedYear;
    getMonthlyData();
  }

  cancelCalendar() {
    selectedCalYear = selectedYear;
    calMonth = month;
    notifyListeners();
  }
}
