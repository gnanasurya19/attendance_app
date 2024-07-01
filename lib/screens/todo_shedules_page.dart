import 'package:attendance_app/controllers/todo_controller.dart';
import 'package:attendance_app/models/todo_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'add_todo_schedules_page.dart';
import 'widget/circle_network_image.dart';

class TodoShedulesPage extends StatefulWidget {
  const TodoShedulesPage({super.key});

  @override
  State<TodoShedulesPage> createState() => _TodoShedulesPageState();
}

class _TodoShedulesPageState extends State<TodoShedulesPage> {
  final key = GlobalKey();
  double bottomSheetheight = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var widgetrenderbox = key.currentContext!.findRenderObject() as RenderBox;
      bottomSheetheight = widgetrenderbox.size.height;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            key: key,
            padding: EdgeInsets.fromLTRB(
              style.insets.sm,
              style.insets.sm,
              0,
              style.insets.sm,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightGrey,
                  offset: Offset(0, 0),
                  spreadRadius: 3,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(style.radius.xl),
                        borderSide:
                            const BorderSide(color: AppColors.lightGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(style.radius.xl),
                        borderSide:
                            const BorderSide(color: AppColors.lightGrey),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            AppColors.purpleGradient,
                            AppColors.blueGradient
                          ]),
                        ),
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          iconColor: AppColors.white,
                          foregroundColor: AppColors.white,
                          shape: const CircleBorder(eccentricity: 0),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              backgroundColor: AppColors.white,
                              context: context,
                              isScrollControlled: true,
                              builder: (context) =>
                                  const AddTodoSchedulesPage());
                        },
                        child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.add))),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      body: Consumer<TodoController>(
        builder: (context, todoController, child) {
          return Container(
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
              children: [
                AppBar(
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: style.icon.sm,
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    'Todos & Schedule',
                    style: style.text.h2,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom +
                            bottomSheetheight),
                    itemCount: todoController.todoList.length,
                    itemBuilder: (context, index) {
                      TodoModel todo = todoController.todoList[index];
                      return Column(
                        children: [
                          if (index == 0 ||
                              (index > 0 &&
                                  todoController.todoList[index - 1].label !=
                                      todo.label))
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: style.insets.sm),
                              child: Text(
                                todo.label!,
                                style: style.text.h4,
                              ),
                            ),
                          Container(
                            margin:
                                EdgeInsets.symmetric(vertical: style.insets.sm),
                            child: ListTileTheme(
                              horizontalTitleGap: style.insets.lg,
                              child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: AppColors.blue,
                                  checkColor: AppColors.white,
                                  checkboxShape:
                                      const CircleBorder(eccentricity: 0),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Text(
                                              todo.todoName ?? '',
                                              style: style.text.title,
                                            ),
                                            if (todo.isCompleted ?? false)
                                              SizedBox(
                                                width: double.infinity,
                                                height: 1,
                                                child: TweenAnimationBuilder(
                                                    tween: Tween<double>(
                                                        begin: 0, end: 1),
                                                    duration:
                                                        Durations.extralong1,
                                                    builder:
                                                        (context, value, __) {
                                                      return LinearProgressIndicator(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        color: AppColors.black,
                                                        value: value,
                                                      );
                                                    }),
                                              )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.08,
                                        height:
                                            MediaQuery.sizeOf(context).width *
                                                0.08,
                                        alignment: Alignment.center,
                                        child: Builder(
                                          builder: (context) {
                                            if (todo.isCompleted ?? false) {
                                              return IconButton(
                                                onPressed: () {
                                                  todoController
                                                      .markAsInComplete(todo);
                                                },
                                                icon: SvgIcon(
                                                  name: 'cancel',
                                                  size: style.icon.md,
                                                ),
                                              );
                                            }
                                            if (!(todo.isCompleted ?? false)) {
                                              return CircleNetworkImage(
                                                  image: todo.image!);
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: todo.isCompleted,
                                  onChanged: (value) {
                                    todoController.markAsComplete(todo);
                                  }),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
