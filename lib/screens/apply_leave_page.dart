import 'package:attendance_app/controllers/leave_controller.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/leave_page.dart';

class ApplyLeavePage extends StatefulWidget {
  const ApplyLeavePage({super.key});

  @override
  State<ApplyLeavePage> createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends State<ApplyLeavePage> {
  TextEditingController daterangeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LeaveController leaveController = Provider.of<LeaveController>(context);
    daterangeController.text = leaveController.dateRange ?? '';
    var borderRadius = BorderRadius.circular(style.radius.md);
    var inputDecoration = InputDecoration(
      hintText: 'Select leave dates',
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.lightGrey,
        ),
        borderRadius: borderRadius,
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.blue,
          ),
          borderRadius: borderRadius),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.orientationOf(context) == Orientation.landscape
              ? MediaQuery.sizeOf(context).width
              : MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                scrolledUnderElevation: 0,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: style.icon.sm,
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Apply Leave',
                  style: style.text.h2,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: style.insets.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: style.insets.sm),
                        child: Text(
                          'Choose Date',
                          style:
                              style.text.title.copyWith(color: AppColors.grey),
                        ),
                      ),
                      PhysicalModel(
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: AppColors.blueGrey.withOpacity(0.5),
                        borderRadius: borderRadius,
                        child: TextField(
                          controller: daterangeController,
                          onTap: () async {
                            var date = await showDateRangePicker(
                              currentDate: DateTime.now(),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030),
                            );
                            if (date != null) {
                              leaveController.getDateRange(date);
                            }
                          },
                          readOnly: true,
                          decoration: inputDecoration.copyWith(
                            suffixText: leaveController.dayscount,
                          ),
                        ),
                      ),
                      Gap(style.insets.sm),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: style.insets.sm),
                        child: Text(
                          'Choose Leave type',
                          style:
                              style.text.title.copyWith(color: AppColors.grey),
                        ),
                      ),
                      PhysicalModel(
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: AppColors.blueGrey.withOpacity(0.5),
                        borderRadius: borderRadius,
                        child: DropdownButtonFormField(
                          decoration: inputDecoration,
                          value: 0,
                          dropdownColor: AppColors.white,
                          icon: SvgIcon(
                            name: 'arrow',
                            size: style.icon.xxs,
                          ),
                          items: List.generate(leaveController.leaveType.length,
                              (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DotWidget(
                                    size: 7,
                                    color:
                                        leaveController.leaveType[index].color!,
                                  ),
                                  const Gap(10),
                                  Text(
                                    '${leaveController.leaveType[index].type}',
                                    style: style.text.bodyContent.copyWith(
                                      color: AppColors.grey,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                          onChanged: (value) {},
                        ),
                      ),
                      Gap(style.insets.sm),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: style.insets.sm),
                        child: Text(
                          'Reason',
                          style:
                              style.text.title.copyWith(color: AppColors.grey),
                        ),
                      ),
                      PhysicalModel(
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: AppColors.blueGrey.withOpacity(0.5),
                        borderRadius: borderRadius,
                        child: TextField(
                          minLines: 1,
                          maxLines: 7,
                          decoration: inputDecoration.copyWith(
                              hintText: 'Please enter reason'),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(style.radius.xs),
                                  gradient: const LinearGradient(colors: [
                                    AppColors.purpleGradient,
                                    AppColors.blueGradient
                                  ]),
                                ),
                              )),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              style.radius.xs)),
                                      visualDensity: VisualDensity.standard,
                                      foregroundColor: AppColors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Submit for Approval',
                                      style: style.text.h3,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(style.insets.xxl),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
