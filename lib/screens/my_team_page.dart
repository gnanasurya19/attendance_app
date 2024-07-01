import 'package:attendance_app/models/option_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:intl/intl.dart';

class MyTeamPage extends StatefulWidget {
  const MyTeamPage({super.key});

  @override
  State<MyTeamPage> createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {
  final List<OptionModel> options = [
    OptionModel(
      navigation: 'team-report',
      icon: 'todo',
      colors: [
        AppColors.blue,
        const Color(0xffa2d9fd),
      ],
      text: 'Team Report',
    ),
    OptionModel(
      icon: 'calendar',
      colors: [
        AppColors.blue,
        const Color(0xffa2d9fd),
      ],
      navigation: 'todo',
      text: 'Todo & Schedules',
    ),
    OptionModel(
      icon: 'location',
      colors: [
        const Color(0xffba78d2),
        const Color(0xff7643bf),
      ],
      text: 'Office & Locations',
    ),
    OptionModel(
      icon: 'user',
      colors: [
        const Color(0xff27d3a8),
        const Color(0xff30d2ce),
      ],
      text: 'Team Managment',
    ),
  ];

  String? selectedDate;

  String? selectedTeam;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(style.insets.sm);
    return SafeArea(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: style.insets.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(
                title: 'My Teams',
                icon: 'menu',
              ),

              // tabs
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.lg),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: options
                      .map(
                        (e) => Expanded(
                          child: Material(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(style.radius.lg),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, e.navigation!);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: style.insets.sm,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(style.insets.md),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            style.insets.sm),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          tileMode: TileMode.mirror,
                                          colors: e.colors,
                                        ),
                                      ),
                                      child: SvgIcon(name: e.icon),
                                    ),
                                    const Gap(20),
                                    Text(
                                      e.text,
                                      textAlign: TextAlign.center,
                                      style: style.text.bodyContentXSmall
                                          .copyWith(color: AppColors.greyText),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              //present text
              Text(
                'Present',
                style: style.text.title.copyWith(color: AppColors.grey),
              ),

              // bottom modal and calendar
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: AppColors.white,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: borderRadius,
                      child: InkWell(
                        onTap: () {
                          changeTeam(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: style.insets.md,
                              horizontal: style.insets.sm),
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            border: Border.all(
                              color: AppColors.lightGrey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedTeam ?? 'Select Team',
                                style: style.text.bodyContentXSmall,
                              ),
                              SvgIcon(name: 'arrow', size: style.icon.xxs),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Material(
                      color: AppColors.white,
                      borderRadius: borderRadius,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () async {
                          DateTime? date = await datePicker(context);
                          if (date != null) {
                            setState(() {
                              selectedDate =
                                  DateFormat('dd MMM yyyy').format(date);
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: style.insets.md,
                              horizontal: style.insets.sm),
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            border: Border.all(
                              color: AppColors.lightGrey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: SvgIcon(name: 'calendar-outline'),
                              ),
                              Expanded(
                                child: Text(
                                  selectedDate ??
                                      DateFormat('dd MMM yyyy')
                                          .format(DateTime.now()),
                                  style: style.text.bodyContentXSmall,
                                ),
                              ),
                              SvgIcon(name: 'arrow', size: style.icon.xxs),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              const MonthlyAvgTime(),
              const Gap(20),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                      decoration: const BoxDecoration(
                          border: Border.symmetric(
                              horizontal:
                                  BorderSide(color: AppColors.lightGrey))),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                        leading: Container(
                          width: MediaQuery.sizeOf(context).width * 0.1,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: CachedNetworkImage(
                            cacheKey: index.toString(),
                            width: MediaQuery.sizeOf(context).width * 0.1,
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=1522&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D.png",
                            placeholder: (context, url) => Container(
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Natasha Kirovska',
                                    style: style.text.h4,
                                  ),
                                  Text(
                                    'Software Engineer',
                                    style: style.text.bodyContentSmall
                                        .copyWith(color: AppColors.grey),
                                  ),
                                ],
                              ),
                            ),
                            if (index == 0)
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgIcon(
                                            name: 'arrow-right-up',
                                            size: style.icon.xs,
                                          ),
                                          Text(
                                            "09:01",
                                            textAlign: TextAlign.center,
                                            style: style.text.title.copyWith(
                                              color: AppColors.green,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgIcon(
                                            name: 'arrow-right-up',
                                            size: style.icon.xs,
                                          ),
                                          Text(
                                            "09:01",
                                            textAlign: TextAlign.center,
                                            style: style.text.title.copyWith(
                                              color: AppColors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (index == 1)
                              Expanded(
                                  child: Align(
                                child: TextButton.icon(
                                    style: ButtonStyle(
                                        shape: WidgetStatePropertyAll(
                                            ContinuousRectangleBorder(
                                                side: const BorderSide(
                                                    color: AppColors.lightGrey),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    icon: const SvgIcon(name: 'mail'),
                                    onPressed: () {},
                                    label: Text(
                                      'Send Alert',
                                      style: style.text.title
                                          .copyWith(color: AppColors.black),
                                    )),
                              )),
                            if (index == 2)
                              Expanded(
                                  child: Align(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    padding: EdgeInsets.symmetric(
                                      vertical: style.insets.xs,
                                      horizontal: style.insets.md,
                                    ),
                                    child: Text(
                                      'Casual Leave',
                                      style: style.text.title.copyWith(
                                          color: AppColors.white,
                                          letterSpacing: .8),
                                    )),
                              ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  Future<DateTime?> datePicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Theme(
        data: ThemeData().copyWith(
          primaryColor: AppColors.black,
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: AppColors.white,
            confirmButtonStyle: ButtonStyle(
              surfaceTintColor: WidgetStatePropertyAll(AppColors.blueGrey),
              backgroundColor: WidgetStatePropertyAll(AppColors.blue),
              foregroundColor: WidgetStatePropertyAll(AppColors.white),
            ),
          ),
        ),
        child: DatePickerDialog(
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            cancelText: '',
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now()),
      ),
    );
  }

  Future<dynamic> changeTeam(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: AppColors.white,
      builder: (context) => BottomSheet(
        elevation: 10,
        backgroundColor: AppColors.white,
        onClosing: () {},
        builder: (context) => ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  selectedTeam = 'Oman Team';
                });
                Navigator.pop(context);
              },
              title: Text(
                'Oman Team',
                style: style.text.bodyContentSmall,
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  selectedTeam = 'Mobile Team';
                });
                Navigator.pop(context);
              },
              title: Text(
                'Mobile Team',
                style: style.text.bodyContentSmall,
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  selectedTeam = 'Testing Team';
                });
                Navigator.pop(context);
              },
              title: Text(
                'Testing Team',
                style: style.text.bodyContentSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          height: kToolbarHeight,
          alignment: Alignment.center,
          child: Text(
            title,
            style: style.text.h2,
          ),
        ),
        Positioned(
          child: IconButton(
            onPressed: () {},
            icon: SvgIcon(name: icon),
          ),
        ),
      ],
    );
  }
}

class MonthlyAvgTime extends StatelessWidget {
  const MonthlyAvgTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              SvgIcon(
                name: 'check-mark',
                size: style.icon.xs,
              ),
              const MaxGap(14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '06/15',
                    style: style.text.h5,
                  ),
                  Text(
                    'Present',
                    style: style.text.bodyContentSmall
                        .copyWith(color: AppColors.greyText),
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              SvgIcon(
                name: 'clock-in',
                size: style.icon.sm,
              ),
              const MaxGap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '09:20',
                    style: style.text.h5,
                  ),
                  Text(
                    'Avg Clock in',
                    style: style.text.bodyContentSmall,
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              SvgIcon(
                name: 'clock-out',
                size: style.icon.sm,
              ),
              const MaxGap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '05:50',
                    style: style.text.h5,
                  ),
                  Text(
                    'Avg Clock Out',
                    style: style.text.bodyContentSmall
                        .copyWith(color: AppColors.greyText),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
