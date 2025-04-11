import 'package:hive/hive.dart';
part 'attendance_model.g.dart';

@HiveType(typeId: 1)
class AttendanceModel {
  @HiveField(0)
  DateTime? date;
  @HiveField(1)
  DateTime? clockInTime;
  @HiveField(2)
  DateTime? clockOutTime;
  @HiveField(3)
  int? workingHrsInMin;
  @HiveField(4)
  int? attendanceType;
  @HiveField(5)
  bool? isClockInlate;
  @HiveField(6)
  bool? isClockOutlate;
  @HiveField(7)
  bool? isworkHrsLess;
  AttendanceModel({
    this.date,
    this.clockInTime,
    this.clockOutTime,
    this.workingHrsInMin,
    this.attendanceType,
    this.isClockInlate,
    this.isClockOutlate,
    this.isworkHrsLess = false,
  });

  @override
  String toString() {
    return '''date:$date 
clockInTime:$clockInTime
clockOutTime:$clockOutTime
workingHrsInMin:$workingHrsInMin
attendanceType:$attendanceType
isClockInlate:$isClockInlate
isClockOutlate:$isClockOutlate
isworkHrsLess:$isworkHrsLess''';
  }
}
