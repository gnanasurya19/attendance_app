import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/team_reports_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularChat extends StatelessWidget {
  const CircularChat({
    super.key,
    required this.attStatus,
  });

  final List<AttendanceCircleChatModel> attStatus;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      annotations: [CircularChartAnnotation(widget: Container())],
      series: <DoughnutSeries<AttendanceCircleChatModel, String>>[
        DoughnutSeries(
          explode: true,
          pointColorMapper: (datum, index) => datum.color,
          innerRadius: '${style.icon.md}',
          dataSource: attStatus,
          xValueMapper: (datum, index) => datum.name,
          yValueMapper: (datum, index) => datum.value,
        )
      ],
    );
  }
}
