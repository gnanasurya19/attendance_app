import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:intl/intl.dart';

class AttendanceController extends ChangeNotifier {
  int month = DateTime.now().month;
  String get selectedMonth => DateFormat('MMMM').format(DateTime(2023, month));
  int selectedYear = DateTime.now().year;

  //calendar
  int calMonth = DateTime.now().month;

  String get selectedCalMonth =>
      DateFormat('MMMM').format(DateTime(2023, calMonth));

  int selectedCalYear = DateTime.now().year;

  final List<AttendanceModel> attendanceList = [
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '10:00am',
      clockOutTime: '06:30',
      date: '11Thu',
      workingHrsIn: '07h 30m',
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      clockOutTime: '05:20',
      date: '12Fri',
      workingHrsIn: '06h 10m',
      isClockOutlate: true,
      isworkHrsLess: true,
    ),
    AttendanceModel(
      attendanceType: 1,
      clockOutTime: '06:20',
      date: '12Fri',
    ),
    AttendanceModel(
      attendanceType: 0,
      clockOutTime: '06:20',
      date: '12Fri',
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      clockOutTime: '06:20',
      date: '12Fri',
      workingHrsIn: '06h 10m',
      isworkHrsLess: true,
      isClockOutlate: true,
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      date: '12Fri',
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      clockOutTime: '06:20',
      date: '12Fri',
      workingHrsIn: '06h 10m',
      isClockInlate: true,
      isworkHrsLess: true,
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      clockOutTime: '06:20',
      date: '12Fri',
      workingHrsIn: '06h 10m',
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      date: '12Fri',
      workingHrsIn: '06h 10m',
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      clockOutTime: '06:20',
      date: '12Fri',
      workingHrsIn: '06h 10m',
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      date: '12Fri',
      workingHrsIn: '06h 10m',
    ),
    AttendanceModel(
      attendanceType: 1,
      clockInTime: '09:10am',
      clockOutTime: '06:20',
      date: '12Fri',
      workingHrsIn: '06h 10m',
    ),
  ];

  final List<AttendanceModel> attendanceList1 = [
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '09:10am',
        clockOutTime: '06:20',
        date: '12Fri',
        workingHrsIn: '06h 10m'),
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '09:10am',
        clockOutTime: '05:20',
        date: '12Fri',
        workingHrsIn: '06h 10m',
        isClockOutlate: true,
        isworkHrsLess: true),
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '10:00am',
        clockOutTime: '06:30',
        date: '11Thu',
        workingHrsIn: '07h 30m'),
    AttendanceModel(attendanceType: 1, clockOutTime: '06:20', date: '12Fri'),
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '09:10am',
        date: '12Fri',
        workingHrsIn: '06h 10m'),
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '09:10am',
        clockOutTime: '06:20',
        date: '12Fri',
        workingHrsIn: '06h 10m',
        isClockInlate: true,
        isworkHrsLess: true),
    AttendanceModel(attendanceType: 0, clockOutTime: '06:20', date: '12Fri'),
    AttendanceModel(attendanceType: 1, clockInTime: '09:10am', date: '12Fri'),
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '09:10am',
        clockOutTime: '06:20',
        date: '12Fri',
        workingHrsIn: '06h 10m'),
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '09:10am',
        date: '12Fri',
        workingHrsIn: '06h 10m'),
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '09:10am',
        clockOutTime: '06:20',
        date: '12Fri',
        workingHrsIn: '06h 10m'),
    AttendanceModel(
        attendanceType: 1,
        clockInTime: '09:10am',
        clockOutTime: '06:20',
        date: '12Fri',
        workingHrsIn: '06h 10m',
        isworkHrsLess: true,
        isClockOutlate: true),
  ];

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
    notifyListeners();
  }

  increaseMonth() {
    if (month == 11) {
      month = 0;
      selectedYear++;
    } else {
      month++;
    }
    isAnimate = !isAnimate;
    notifyListeners();
  }

  decreaseMonth() {
    if (month == 0) {
      month = 11;
      selectedYear--;
    } else {
      month--;
    }

    isAnimate = !isAnimate;
    notifyListeners();
  }
}
