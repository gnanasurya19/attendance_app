import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/services/util/widget/alert_widget.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';

class UtilService {
  showSnackBar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: style.text.bodyContentSmall.copyWith(color: AppColors.white),
      ),
      backgroundColor: AppColors.red,
      showCloseIcon: true,
    ));
  }

  CoordinatesModel coordinates = CoordinatesModel();

  Future<CoordinatesModel?> getLocationCoordinates(BuildContext context) async {
    await checkLocation(context).then((value) async {
      if (value == "Permission Denied Forever") {
        doAlert(
            'In order to continue we need your location permission. please ensure permission in app settings',
            'Open Settings',
            'location', () {
          Navigator.pop(context);
        }, context);
        throw 'Permission Denied';
      } else {
        Position locationData = await Geolocator.getCurrentPosition();
        coordinates.latitude = locationData.latitude.toString();
        coordinates.longitude = locationData.longitude.toString();
        return coordinates;
      }
    });
    return coordinates;
  }

  Future checkLocation(context) async {
    LocationPermission? permission;
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return 'Permission Denied Forever';
      }
    } else {
      doAlert('Please enable location', 'Enable Location', 'location', () {
        // Geolocator.openLocationSettings();
        Navigator.pop(context);
      }, context);
      throw "Location service disabled";
    }
  }

  doAlert(String content, String btnTxt, String alertype, Function() fun,
      BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertWidget(
        btnTxt: btnTxt,
        onClick: fun,
        content: content,
        errorType: alertype,
      ),
    );
  }

  List<geo.Placemark> placeMark = [];

  Future<String> getCurrentLocationData(CoordinatesModel coordinate) async {
    try {
      placeMark = await geo.placemarkFromCoordinates(
          double.parse(coordinate.latitude!),
          double.parse(coordinate.longitude!));
      return placeMark[0].name!;
    } catch (e) {
      throw 'Error fetching place details';
    }
  }
}

class CoordinatesModel {
  String? latitude;
  String? longitude;
  CoordinatesModel({this.latitude, this.longitude});

  @override
  String toString() {
    return "$latitude $longitude";
  }
}
