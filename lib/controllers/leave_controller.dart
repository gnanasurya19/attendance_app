import 'package:attendance_app/models/leave_type_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:intl/intl.dart';

class LeaveController extends ChangeNotifier {
  DateTime? fromDate;
  DateTime? toDate;
  String? get dateRange => (fromDate != null && toDate != null)
      ? "${DateFormat('dd MMM').format(fromDate!)} to ${DateFormat('dd MMM').format(toDate!)}"
      : null;
  String? get dayscount => (fromDate != null && toDate != null)
      ? '${(toDate!.difference(fromDate!)).inDays + 1} Days'
      : null;

  List<LeaveTypeModel> leaveType = [
    LeaveTypeModel(type: 'Casual Leave', color: AppColors.blue),
    LeaveTypeModel(type: 'Medical Leave', color: AppColors.green),
    LeaveTypeModel(type: 'Annual Leave', color: AppColors.pink),
    LeaveTypeModel(type: 'Unpaid Leave', color: AppColors.red),
  ];

  getDateRange(DateTimeRange date) {
    fromDate = date.start;
    toDate = date.end;
    notifyListeners();
  }
}
