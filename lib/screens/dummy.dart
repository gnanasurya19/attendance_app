import 'package:attendance_app/res/common_lib.dart';
import 'package:popover/popover.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  DataGridSource studentDatas = StudentDataSource(studentData: [
    StudentModel(age: 10, name: 'Surya', height: 100, weight: 20),
    StudentModel(age: 10, name: 'vijay', height: 122, weight: 30),
    StudentModel(age: 10, name: 'ajith', height: 115, weight: 60),
    StudentModel(age: 10, name: 'john', height: 147, weight: 34),
    StudentModel(age: 10, name: 'mikey', height: 115, weight: 30),
  ]);

  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        controller.play();
      });

    controller.addListener(videoListerner);

    smsRetrieverImpl = SmsRetrieverImpl(SmartAuth());
  }

  bool isPlaying = false;
  videoListerner() {
    setState(() {
      isPlaying = controller.value.isPlaying;
    });
  }

  bool isSearch = false;

  int selectedIndex = 0;

  late final SmsRetrieverImpl smsRetrieverImpl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: AppColors.black.withOpacity(0.2),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.white,
              ));
        }),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: !isSearch
            ? Container(
                alignment: Alignment.center,
                child: const Text(
                  'Home',
                  style: TextStyle(color: AppColors.white),
                  key: ValueKey<String>('text'),
                ),
              )
            : LayoutBuilder(builder: (context, constraints) {
                constraints;
                return TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) => Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: constraints.maxWidth * value,
                      child: child,
                    ),
                  ),
                  child: Container(
                    key: const ValueKey('search'),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(14, 4, 4, 4),
                        hintText: 'search',
                        hintStyle: const TextStyle(color: AppColors.grey),
                        isDense: true,
                        fillColor: AppColors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            icon: AnimatedSwitcher(
              reverseDuration: Duration.zero,
              duration: const Duration(milliseconds: 200),
              child: isSearch
                  ? const Icon(
                      Icons.close,
                      key: ValueKey<int>(1),
                      color: AppColors.white,
                    )
                  : const Icon(
                      Icons.search,
                      key: ValueKey<int>(2),
                      color: AppColors.white,
                    ),
              transitionBuilder: (widget, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: RotationTransition(
                    turns: animation,
                    child: widget,
                  ),
                );
              },
            ),
          ),
          const ProfileButton()
        ],
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(100),
            VideoWidget(controller: controller, isPlaying: isPlaying),
            ElevatedButton(
              onPressed: () async {
                var uri = Uri.parse(
                    "google.navigation:q=13.026187225720788,77.63428518284556&mode=d");
                launchUrl(uri);
              },
              child: const Text('Open Map'),
            ),
            const DataTableWidget(),
            // Expanded(
            //   child: Table(
            //     children: const [
            //       TableRow(
            //         children: [
            //           Align(child: Text('Student')),
            //           Align(child: Text('kjsd'))
            //         ],
            //       ),
            //       TableRow(
            //         children: [
            //           Align(child: Text('Student')),
            //           Align(child: Text('kjsd'))
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            SyncfusionDataGrid(studentDatas: studentDatas),
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(10),
              child: ToggleWidget(
                onChange: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                list: const ['name', 'kjndf', 'sjdn', 'sdjhf'],
                selectedIndex: selectedIndex,
                color: AppColors.green,
                borderColor: AppColors.black,
                selectedColor: AppColors.blue,
                textColor: AppColors.black,
                selectedTextColor: AppColors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showAnimatedDialog(context);
              },
              child: const Text(
                'Open Model',
              ),
            ),
            const Gap(50),
            Pinput(
              smsRetriever: smsRetrieverImpl,
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }

  Future<Object?> showAnimatedDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final Animation<Offset> slideanimation =
            Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                .animate(animation);
        return SlideTransition(
          position: slideanimation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return const AnimatedDialog();
      },
    );
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsCode(
      useUserConsentApi: true,
    );
    if (res.succeed && res.codeFound) {
      return res.code!;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showPopover(
            arrowDyOffset: -kToolbarHeight,
            arrowHeight: 0,
            context: context,
            bodyBuilder: (context) {
              return const SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(
          Icons.person,
          color: AppColors.white,
        ));
  }
}

class AnimatedDialog extends StatelessWidget {
  const AnimatedDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white,
                ),
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.only(top: 40),
                height: 200,
              ),
            ],
          ),
          Positioned(
            top: 0,
            child: PhysicalModel(
              elevation: 10,
              color: AppColors.black,
              shape: BoxShape.circle,
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SyncfusionDataGrid extends StatelessWidget {
  const SyncfusionDataGrid({
    super.key,
    required this.studentDatas,
  });

  final DataGridSource studentDatas;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: SfDataGrid(
          frozenColumnsCount: 1,
          selectionMode: SelectionMode.single,
          gridLinesVisibility: GridLinesVisibility.none,
          headerGridLinesVisibility: GridLinesVisibility.none,
          highlightRowOnHover: true,
          isScrollbarAlwaysShown: false,
          showHorizontalScrollbar: false,
          showVerticalScrollbar: false,
          source: studentDatas,
          columns: [
            GridColumn(
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              columnName: 'name',
              label: Container(
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: AppColors.white)),
                  color: AppColors.orange,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Student Name',
                  style: TextStyle(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GridColumn(
                columnName: 'age',
                label: Container(
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: AppColors.white)),
                    color: AppColors.orange,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Age',
                    style: TextStyle(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
            GridColumn(
              columnName: 'height',
              label: Container(
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: AppColors.white)),
                  color: AppColors.orange,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Height',
                  style: TextStyle(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GridColumn(
                columnName: 'weight',
                label: Container(
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: AppColors.white)),
                    color: AppColors.orange,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Weight',
                    style: TextStyle(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ]),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            color: AppColors.lightGreen,
            child: DataTable(
                dividerThickness: 2,
                showBottomBorder: true,
                horizontalMargin: 2,
                columns: const [
                  DataColumn(
                    label: Text('Students'),
                  ),
                  DataColumn(
                    label: Text('Age'),
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Age'),
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Age'),
                  ),
                ],
                rows: List.generate(
                    10,
                    (context) => const DataRow(cells: [
                          DataCell(
                            Text(
                              'Student Name',
                            ),
                          ),
                          DataCell(
                            Text(
                              '22',
                            ),
                          ),
                          DataCell(
                            Text(
                              'Surya',
                            ),
                          ),
                          DataCell(
                            Text(
                              '22',
                            ),
                          ),
                          DataCell(
                            Text(
                              'Surya',
                            ),
                          ),
                          DataCell(
                            Text(
                              '22',
                            ),
                          ),
                        ]))),
          ),
        ),
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required this.controller,
    required this.isPlaying,
  });

  final VideoPlayerController controller;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
          if (!isPlaying)
            Center(
              child: IconButton(
                onPressed: () {
                  controller
                    ..seekTo(Duration.zero)
                    ..play();
                },
                icon: const Icon(
                  Icons.play_arrow,
                  color: AppColors.white,
                  size: 50,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: AppColors.blueGrey,
                      child: ListView(
                        // shrinkWrap: true,
                        children: const [ListTile()],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          color: AppColors.black, child: const Column()))
                ],
              ),
            ),
            Container(
              height: 100,
              color: AppColors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleWidget extends StatelessWidget {
  const ToggleWidget({
    super.key,
    required this.selectedIndex,
    required this.list,
    required this.onChange,
    this.color,
    required this.borderColor,
    required this.selectedColor,
    this.textColor,
    this.selectedTextColor,
  });

  final Function(int value) onChange;
  final Color? color;
  final Color selectedColor;
  final Color borderColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final int selectedIndex;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        color: color,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.fastOutSlowIn,
              top: 0,
              bottom: 0,
              left: (constraints.maxWidth / list.length) * selectedIndex,
              duration: const Duration(milliseconds: 350),
              child: Container(
                color: selectedColor,
                width: constraints.maxWidth / list.length,
                height: 10,
              ),
            ),
            Row(
              children: List.generate(
                list.length,
                (index) => Expanded(
                  child: InkWell(
                    onTap: () {
                      onChange(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right: index != list.length - 1
                                  ? BorderSide(color: borderColor)
                                  : BorderSide.none)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                            color: selectedIndex == index
                                ? selectedTextColor
                                : textColor),
                        child: Text(
                          list[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class StudentModel {
  String? name;
  int? age;
  double? height;
  double? weight;
  StudentModel({this.name, this.age, this.height, this.weight});
}

class StudentDataSource extends DataGridSource {
  StudentDataSource({required List<StudentModel> studentData}) {
    _studentData = studentData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'name',
                value: e.name,
              ),
              DataGridCell<int>(columnName: 'age', value: e.age),
              DataGridCell<double>(columnName: 'height', value: e.height),
              DataGridCell<double>(columnName: 'weight', value: e.weight),
            ]))
        .toList();
  }
  List<DataGridRow> _studentData = [];

  @override
  List<DataGridRow> get rows => _studentData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row
            .getCells()
            .map(
              (e) => Container(
                decoration: BoxDecoration(
                  border: Border(
                      right: e.columnName != 'weight' && e.columnName != 'name'
                          ? const BorderSide(color: AppColors.green)
                          : BorderSide.none,
                      bottom: const BorderSide(color: AppColors.orange)),
                  color: e.columnName == 'name'
                      ? AppColors.orange.withOpacity(0.4)
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(e.value.toString()),
              ),
            )
            .toList());
  }
}
