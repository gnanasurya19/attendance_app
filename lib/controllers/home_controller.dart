import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
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
    attendance = hiveBox.values.last;
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? inTime = attendance.clockInTime;
    String? outTime = attendance.clockOutTime;
    currentLocation = sp.getString('clockInLocation');

    if (inTime != null) {
      clockIn = DateFormat('hh:mm').parse(inTime);
    }
    if (outTime != null) {
      clockOut = DateFormat('hh:mm').parse(outTime);
      isAttCompleted = true;
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
          clockIn = DateTime.now();
          attendance = AttendanceModel(
            attendanceType: 1,
            clockInTime: clockInTime,
            date: DateFormat('dd EEE MMM yyyy').format(
              DateTime.now(),
            ),
          );
          hiveBox.add(attendance);

          sp.setString('clockInTime', clockInTime);
          if (currentLocation != null) {
            sp.setString('clockInLocation', currentLocation!);
          }
        }
        notifyListeners();
      });
    } else if (clockOut == null && clockIn != null) {
      showConfirmation(
        context,
        'are you sure want to clock out?',
        () {
          clockOut = DateTime.now();
          attendance.clockOutTime = clockOutTime;
          hiveBox.putAt(hiveBox.length - 1, attendance);
          sp.setString('clockOutTime', clockOutTime);
          isAttCompleted = true;
          notifyListeners();
        },
      );
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
