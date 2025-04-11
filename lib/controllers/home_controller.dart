import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/widget/clock_in_confirmation.dart';
import '../screens/widget/whf_button.dart';

class HomeController extends ChangeNotifier {
  DateTime? clockIn;
  DateTime? clockOut;
  String? currentLocation;
  CoordinatesModel? currentCoordinates;
  bool isWfh = false;
  bool isAttCompleted = false;

  static const double officeLat = 13.026303027671402;
  static const double officeLong = 77.63426467010314;

  String get clockInTime =>
      clockIn == null ? '--:--' : DateFormat('hh:mm').format(clockIn!);
  String get clockOutTime =>
      clockOut == null ? '--:--' : DateFormat('hh:mm').format(clockOut!);

  int? get workingHrsInMin => (clockIn == null || clockOut == null)
      ? null
      : clockOut!.difference(clockIn!).inMinutes;

  String get workingHrs => workingHrsInMin == null
      ? '--:--'
      : "${(workingHrsInMin! ~/ 60).toString().padLeft(2, '0')}: ${(workingHrsInMin! % 60).toString().padLeft(2, '0')}";

  AttendanceModel attendance = AttendanceModel();

  HomeController() {
    getLocalData();
  }

  void getLocalData() async {
    // DateTime now = DateTime.now();
    // await hiveBox.clear();
    // for (var i = 0; i < 365 * 3; i++) {
    //   hiveBox.add(
    //     AttendanceModel(
    //       clockInTime: now.subtract(
    //         Duration(days: i, hours: 3, minutes: 30),
    //       ),
    //       clockOutTime: now.subtract(
    //         Duration(days: i, hours: 6, minutes: 20),
    //       ),
    //       date: now.subtract(
    //         Duration(days: i),
    //       ),
    //       workingHrsInMin: 400,
    //     ),
    //   );
    // }

    if (hiveBox.isNotEmpty) {
      attendance = hiveBox.values.last;
      SharedPreferences sp = await SharedPreferences.getInstance();
      String today = sp.getString('today') ?? '';
      bool isToday = DateFormat('dd MM yyyy').format(DateTime.now()) == today;
      if (isToday) {
        clockIn = attendance.clockInTime;
        clockOut = attendance.clockOutTime;
        currentLocation = sp.getString('clockInLocation');
        if (clockOut != null) {
          isAttCompleted = true;
        }
      }
    }
    notifyListeners();
  }

  toggleClockIn(context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (clockIn == null) {
      showConfirmation(context, 'are you sure want to clock in?', () async {
        if (currentLocation == 'You are not in Office reach') {
          changToWHF(context);
        } else {
          doClockIn(sp);
        }
        notifyListeners();
      });
    } else if (clockOut == null && clockIn != null) {
      showConfirmation(
        context,
        'are you sure want to clock out?',
        () {
          doClockOut(sp);
        },
      );
    }
  }

  void doClockOut(SharedPreferences sp) {
    clockOut = DateTime.now();
    attendance.attendanceType = isWfh ? 0 : 1;
    attendance.clockOutTime = clockOut;
    attendance.workingHrsInMin = workingHrsInMin;
    hiveBox.putAt(hiveBox.length - 1, attendance);
    sp.setString('clockOutTime', clockOutTime);
    isAttCompleted = true;
    notifyListeners();
  }

  void doClockIn(SharedPreferences sp) {
    clockIn = DateTime.now();
    attendance = AttendanceModel(
      clockInTime: DateTime.now(),
      date: DateTime.now(),
    );
    hiveBox.add(attendance);
    sp.setString('clockInTime', clockInTime);
    sp.setString('today', DateFormat('dd MM yyyy').format(clockIn!));
    if (currentLocation != null) {
      sp.setString('clockInLocation', currentLocation!);
    }
  }

  Future getLocation(context) async {
    if (clockIn == null) {
      currentCoordinates = await util.getLocationCoordinates(context);
      await checkOfficeReach();
      notifyListeners();
    }
  }

  checkOfficeReach() async {
    double distant = Geolocator.distanceBetween(
        officeLat,
        officeLong,
        double.parse(currentCoordinates!.latitude!),
        double.parse(currentCoordinates!.longitude!));
    if (distant > 20) {
      currentLocation = 'You are not in Office reach';
    } else {
      currentLocation = await util
          .getCurrentLocationData(currentCoordinates!)
          .catchError((e) => 'Error Fetching place details');
    }
  }

  Future showConfirmation(BuildContext cnt, String text, Function() fun) async {
    await showDialog(
      context: cnt,
      builder: (context) => ClockInConfirmation(
        text: text,
        onClick: fun,
      ),
    );
  }

  changToWHF(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => WHFButton(
        onClick: () {
          Navigator.pop(context);
          isWfh = true;
          currentLocation = 'Work From Home';
          notifyListeners();
        },
      ),
    );
  }
}
