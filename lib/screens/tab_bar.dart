import 'package:attendance_app/models/tab_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/attendance_page.dart';
import 'package:attendance_app/screens/home_page.dart';
import 'package:attendance_app/screens/my_team_page.dart';
import 'package:attendance_app/screens/notification_page.dart';

import 'leave_page.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int selectedPage = 0;

  List<TabModel> tabList = [
    TabModel(
      icon: 'home',
      activeIcon: 'home-fill',
      label: 'Home',
      page: const HomePage(),
    ),
    TabModel(
      icon: 'team',
      activeIcon: 'team-fill',
      label: 'My team',
      page: const MyTeamPage(),
    ),
    TabModel(
      icon: 'attendance',
      activeIcon: 'attendance-fill',
      label: 'Attendance',
      page: const AttendancePage(),
    ),
    TabModel(
      icon: 'notification',
      activeIcon: 'notification-fill',
      label: 'Notification',
      page: const NotificationPage(),
    ),
    TabModel(
      icon: 'leave',
      activeIcon: 'leave-fill',
      label: 'Leave',
      page: const LeavePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).width >= 600;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ResizeImage(const AssetImage('assets/images/home_bg.png'),
                  height: MediaQuery.sizeOf(context).height.toInt(),
                  width: MediaQuery.sizeOf(context).width.toInt()),
              fit: BoxFit.fill),
        ),
        child: isTablet
            ? NavigationRailWidget(
                selectedPage: selectedPage,
                tabList: tabList,
                onchange: (int value) {
                  setState(() {
                    selectedPage = value;
                  });
                },
              )
            : tabList[selectedPage].page,
      ),
      bottomNavigationBar: isTablet
          ? null
          : TabWidget(
              selectedPage: selectedPage,
              tabList: tabList,
              ontap: (value) {
                setState(() {
                  selectedPage = value;
                });
              },
            ),
    );
  }
}

class NavigationRailWidget extends StatelessWidget {
  const NavigationRailWidget({
    super.key,
    required this.selectedPage,
    required this.tabList,
    required this.onchange,
  });

  final Function(int value) onchange;
  final int selectedPage;
  final List<TabModel> tabList;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      NavigationRail(
        backgroundColor: const Color(0xfffdfbfc).withOpacity(0.5),
        onDestinationSelected: onchange,
        selectedIndex: selectedPage,
        groupAlignment: 0,
        labelType: NavigationRailLabelType.all,
        useIndicator: false,
        destinations: List.generate(
          tabList.length,
          (index) => NavigationRailDestination(
              padding: EdgeInsets.symmetric(vertical: style.insets.xl),
              icon: SvgIcon(
                name: index == selectedPage
                    ? tabList[index].activeIcon
                    : tabList[index].icon,
                size: style.icon.sm,
              ),
              label: Text(tabList[index].label)),
        ).toList(),
      ),
      Expanded(child: tabList[selectedPage].page)
    ]);
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.selectedPage,
    required this.tabList,
    required this.ontap,
  });

  final int selectedPage;
  final List<TabModel> tabList;
  final Function(int value) ontap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xfffdfbfc).withOpacity(0.5),
      useLegacyColorScheme: false,
      elevation: 0,
      selectedLabelStyle: style.text.bodyContentXSmall,
      unselectedLabelStyle: style.text.bodyContentXSmall,
      mouseCursor: WidgetStateMouseCursor.clickable,
      currentIndex: selectedPage,
      onTap: (value) {
        ontap(value);
      },
      items: tabList
          .map(
            (e) => BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: SvgIcon(
                name: e.icon,
                size: style.icon.sm,
              ),
              activeIcon: SvgIcon(
                name: e.activeIcon,
                size: style.icon.sm,
              ),
              tooltip: e.label,
              label: e.label,
            ),
          )
          .toList(),
    );
  }
}
