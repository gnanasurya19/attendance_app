class AttendanceModel {
  String? date;
  String? clockInTime;
  String? clockOutTime;
  String? workingHrsIn;
  int? attendanceType;
  bool? isClockInlate;
  bool? isClockOutlate;
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
