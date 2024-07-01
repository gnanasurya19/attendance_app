import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:intl/intl.dart';

class YearMonthPicker extends StatefulWidget {
  const YearMonthPicker({super.key});

  @override
  State<YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  final List<String> months = List<String>.generate(
      12, (index) => DateFormat('MMMM').format(DateTime(2023, index + 1, 01)));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attControler = Provider.of<AttendanceController>(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: style.insets.sm),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  attControler.decYear();
                },
                child: Padding(
                  padding: EdgeInsets.all(style.insets.xs),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.grey,
                    size: style.icon.xs,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  attControler.selectedCalYear.toString(),
                  textAlign: TextAlign.center,
                  style: style.text.h4.copyWith(color: AppColors.blue),
                ),
              ),
              InkWell(
                onTap: () {
                  attControler.incYear();
                },
                child: Padding(
                  padding: EdgeInsets.all(style.insets.xs),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.grey,
                    size: style.icon.xs,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(builder: (context, constrains) {
            return Wrap(
              children: List.generate(
                  months.length,
                  (index) => Container(
                        width: constrains.maxWidth / 3,
                        height: constrains.maxHeight / 4,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {},
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    months[index] ==
                                            attControler.selectedCalMonth
                                        ? AppColors.blue
                                        : AppColors.white,
                                  ),
                                  foregroundColor: WidgetStatePropertyAll(
                                    months[index] ==
                                            attControler.selectedCalMonth
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                  textStyle:
                                      WidgetStatePropertyAll(style.text.title)),
                              onPressed: () async {
                                context
                                    .read<AttendanceController>()
                                    .onCalMonthChange(index + 1);
                              },
                              child: Text(months[index])),
                        ),
                      )).toList(),
            );
          }),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(AppColors.blue)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              const Gap(15),
              ElevatedButton(
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(AppColors.white),
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.lightBlue,
                    ),
                  ),
                  onPressed: () {
                    context
                        .read<AttendanceController>()
                        .changeCalMonthandYear();
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          ),
        )
      ],
    );
  }
}
