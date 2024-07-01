import 'package:attendance_app/res/common_lib.dart';

import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/home_controller.dart';
import 'package:attendance_app/controllers/leave_controller.dart';
import 'package:attendance_app/controllers/todo_controller.dart';

import 'package:attendance_app/screens/apply_leave_page.dart';
import 'package:attendance_app/screens/login_page.dart';
import 'package:attendance_app/screens/profile_page.dart';
import 'package:attendance_app/screens/signup_page.dart';
import 'package:attendance_app/screens/tab_bar.dart';
import 'package:attendance_app/screens/team_reports_page.dart';
import 'package:attendance_app/screens/todo_shedules_page.dart';

void main() {
  runApp(const MainApp());
}

AppStyle get style => MainApp.style;

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static AppStyle get style => _style;
  static AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    _style = AppStyle(screenSize: MediaQuery.sizeOf(context));
    return DefaultTextStyle(
      style: _style.text.bodyTitle,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AttendanceController(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeController(),
          ),
          ChangeNotifierProvider(
            create: (context) => LeaveController(),
          ),
          ChangeNotifierProvider(
            create: (context) => TodoController(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
              datePickerTheme:
                  const DatePickerThemeData(backgroundColor: AppColors.white)),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings settings) {
            late final Widget widget;
            switch (settings.name) {
              case 'login':
                widget = const LoginPage();
                break;
              case 'signup':
                widget = const SignupPage();
                break;
              case 'tabs':
                widget = const TabBarWidget();
                break;
              case 'profile':
                widget = const ProfilePage();
                break;
              case 'team-report':
                widget = const TeamReportsPage();
                break;
              case 'todo':
                widget = const TodoShedulesPage();
                break;
              case 'apply-leave':
                widget = const ApplyLeavePage();
                break;
              default:
                widget = const Scaffold(
                  body: Center(
                    child: Text('No routes found'),
                  ),
                );
            }
            return MaterialPageRoute(
              builder: (context) => widget,
            );
          },
          initialRoute: 'tabs',
        ),
      ),
    );
  }
}
