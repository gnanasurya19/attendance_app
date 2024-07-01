import 'package:attendance_app/res/common_lib.dart';
import 'colored_button.dart';

class EditTimeDialog extends StatefulWidget {
  final Function() onClick;
  const EditTimeDialog({
    super.key,
    required this.onClick,
  });

  @override
  State<EditTimeDialog> createState() => _EditTimeDialogState();
}

class _EditTimeDialogState extends State<EditTimeDialog> {
  FixedExtentScrollController hrController =
      FixedExtentScrollController(initialItem: (DateTime.now().hour - 1) % 12);
  FixedExtentScrollController minController =
      FixedExtentScrollController(initialItem: DateTime.now().minute);
  int selecteddHour = (DateTime.now().hour - 1) % 12;
  int selectedMin = DateTime.now().minute;
  bool isAM = DateTime.now().hour < 12;

  @override
  void initState() {
    hrController.addListener(hourListerner);
    minController.addListener(minListerner);
    super.initState();
  }

  @override
  dispose() {
    hrController.dispose();
    minController.dispose();
    super.dispose();
  }

  hourListerner() {
    setState(() {
      selecteddHour = hrController.selectedItem;
    });
  }

  void minListerner() {
    setState(() {
      selectedMin = minController.selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      color: AppColors.lightGrey,
      height: 1,
    );

    return Dialog(
      backgroundColor: AppColors.white,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(style.radius.md)),
      insetPadding: EdgeInsets.symmetric(horizontal: style.insets.md),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: style.insets.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      size: style.icon.sm,
                      color: AppColors.blue,
                    ),
                    Gap(style.insets.sm),
                    Text(
                      'Edit Time',
                      style: style.text.bodyContent
                          .copyWith(color: AppColors.blue),
                    )
                  ],
                ),
              ),
              divider,

              //timepicker wheel
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: style.insets.xxl + 10),
                height: MediaQuery.sizeOf(context).height / 4,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 38.0,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 1, height: 20),
                          ColoredBox(
                            color: AppColors.white,
                            child: SizedBox(width: 1, height: 20),
                          ),
                          ColoredBox(
                            color: AppColors.white,
                            child: SizedBox(width: 1, height: 20),
                          ),
                          SizedBox(width: 1, height: 20),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            squeeze: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            controller: hrController,
                            itemExtent: 40,
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 12,
                              builder: (context, index) {
                                return Align(
                                  child: Text(
                                    (index + 1).toString().padLeft(2, '0'),
                                    style: style.text.bodyContentLg.copyWith(
                                      color: selecteddHour == index
                                          ? AppColors.white
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            squeeze: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            controller: minController,
                            itemExtent: 40,
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 60,
                              builder: (context, index) {
                                return Align(
                                  child: Text(
                                    (index).toString().padLeft(2, '0'),
                                    style: style.text.bodyContentLg.copyWith(
                                      color: selectedMin == index
                                          ? AppColors.white
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            squeeze: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                                initialItem: isAM ? 0 : 1),
                            onSelectedItemChanged: (value) => setState(() {
                              isAM = !isAM;
                            }),
                            itemExtent: 45,
                            childDelegate: ListWheelChildListDelegate(
                              children: [
                                Align(
                                  child: Text(
                                    'AM',
                                    style: style.text.bodyContentLg.copyWith(
                                        color: isAM
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                ),
                                Align(
                                  child: Text(
                                    'PM',
                                    style: style.text.bodyContentLg.copyWith(
                                        color: !isAM
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              divider,
              Gap(style.insets.sm),
              Text(
                'Team Lead',
                style: style.text.title.copyWith(
                  color: AppColors.greyText,
                ),
              ),
              Text(
                'Ahmed Hassan',
                style: style.text.titleMd.copyWith(color: AppColors.black),
              ),
              Gap(style.insets.sm),
              Text(
                'Comment',
                style: style.text.title.copyWith(
                  color: AppColors.greyText,
                ),
              ),
              //comment field
              Container(
                margin: EdgeInsets.symmetric(vertical: style.insets.md),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3E6394).withOpacity(0.3),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: TextField(
                  maxLines: 2,
                  minLines: 2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    fillColor: AppColors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(style.radius.sm),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(style.radius.sm),
                    ),
                  ),
                ),
              ),
              //buttons
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.xl),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: style.insets.lg,
                              horizontal: style.insets.lg)),
                          backgroundColor:
                              const WidgetStatePropertyAll(AppColors.white),
                          foregroundColor:
                              const WidgetStatePropertyAll(AppColors.black),
                          shape: WidgetStatePropertyAll(
                              ContinuousRectangleBorder(
                                  side: const BorderSide(color: AppColors.grey),
                                  borderRadius:
                                      BorderRadius.circular(style.radius.xs)))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'CANCEL',
                        style: style.text.bodyContent,
                      ),
                    ),
                    Gap(style.insets.md),
                    ColoredButton(
                      color: AppColors.blue,
                      onClick: widget.onClick,
                      text: 'SEND FOR APPROVAL',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
