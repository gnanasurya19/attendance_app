import 'package:hive/hive.dart';
part 'attendance_model.g.dart';

@HiveType(typeId: 0)
class AttendanceModel {
  @HiveField(0)
  String? date;
  @HiveField(1)
  String? clockInTime;
  @HiveField(2)
  String? clockOutTime;
  @HiveField(3)
  String? workingHrsIn;
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
    this.workingHrsIn,
    this.attendanceType,
    this.isClockInlate,
    this.isClockOutlate,
    this.isworkHrsLess = true,
  });
}
