import 'package:attendance_app/res/common_lib.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      clockOut == null ? '--:--' : DateFormat('hh:mm').format(clockIn!);

  int? get workingHrsInMin => (clockIn == null || clockOut == null)
      ? null
      : clockOut!.difference(clockIn!).inMinutes;

  String get workingHrs => workingHrsInMin == null
      ? '--:--'
      : "${(workingHrsInMin! ~/ 60).toString().padLeft(2, '0')}: ${(workingHrsInMin! % 60).toString().padLeft(2, '0')}";

  HomeController() {
    getLocalData();
  }

  void getLocalData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? inTime = sp.getString('clockInTime');
    String? outTime = sp.getString('clockOutTime');
    currentLocation = sp.getString('clockInLocation');

    if (inTime != null) {
      clockIn = DateFormat('hh:mm').parse(inTime);
      print(clockIn);
    }
    if (outTime != null) {
      clockOut = DateFormat('hh:mm').parse(outTime);
      isAttCompleted = true;
    }

    // sp.clear();
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
          sp.setString('clockInTime', clockInTime);
          if (currentLocation != null) {
            sp.setString('clockInLocation', currentLocation!);
          }
        }
        notifyListeners();
      });
    } else if (clockOut == null && clockIn != null) {
      showConfirmation(context, 'are you sure want to clock out?', () {
        clockOut = DateTime.now();
        sp.setString('clockOutTime', clockOutTime);
        isAttCompleted = true;
        notifyListeners();
      });
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

class ClockInConfirmation extends StatelessWidget {
  const ClockInConfirmation({
    super.key,
    required this.onClick,
    required this.text,
  });

  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.all(style.insets.md), child: Text(text)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(AppColors.black)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'No',
                    style: style.text.title,
                  )),
              TextButton(
                  style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(AppColors.blue)),
                  onPressed: () {
                    Navigator.pop(context);
                    onClick();
                  },
                  child: Text(
                    'Yes',
                    style: style.text.title,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
