import 'dart:io';
import 'package:attendance_app/controllers/todo_controller.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/widget/circle_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

import 'widget/gradient_button_round_corner.dart';

class AddTodoSchedulesPage extends StatefulWidget {
  const AddTodoSchedulesPage({
    super.key,
  });

  @override
  State<AddTodoSchedulesPage> createState() => _AddTodoSchedulesPageState();
}

class _AddTodoSchedulesPageState extends State<AddTodoSchedulesPage> {
  String? attachment;
  String? extention;
  bool get isImage =>
      extention == 'jpg' || extention == 'jpeg' || extention == 'png';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.35,
        expand: false,
        builder: (context, scrollController) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: style.insets.lg),
              child: ListView(
                controller: scrollController,
                children: [
                  Gap(style.insets.lg),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: style.insets.md),
                    child: Text(
                      'Plan meeting with client',
                      style: style.text.h3,
                    ),
                  ),
                  Row(
                    children: [
                      CircleNetworkImage(
                          width: style.icon.md,
                          image:
                              'https://images.unsplash.com/photo-1528892952291-009c663ce843?q=80&w=1544&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      const Gap(3),
                      CircleNetworkImage(
                          width: style.icon.md,
                          image:
                              'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      IconButton(
                        style: ButtonStyle(
                          iconSize: WidgetStatePropertyAll(style.icon.xxs),
                          visualDensity: VisualDensity.compact,
                          side: const WidgetStatePropertyAll(
                            BorderSide(
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                  //options
                  Container(
                    margin: EdgeInsets.symmetric(vertical: style.insets.md),
                    height: (screenSize.width + screenSize.height) / 11,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectTime(screenSize: constraints.maxWidth),
                        ShareTodo(
                          screenSize: constraints.maxWidth,
                        ),
                        SelectLocation(screenSize: constraints.maxWidth),
                      ],
                    ),
                  ),
                  Gap(style.insets.md),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: style.insets.xs),
                    child: Text(
                      'SubTasks',
                      style: style.text.h4,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(minWidth: 0),
                      prefixIcon: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: style.insets.xs),
                        child: Icon(
                          Icons.circle_outlined,
                          size: style.icon.xs,
                          color: AppColors.lightGrey,
                        ),
                      ),
                      hintStyle: style.text.bodyContentSmall
                          .copyWith(color: AppColors.lightGrey),
                      hintText: 'Add a new subask',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(style.insets.xs),
                        borderSide: const BorderSide(
                          color: AppColors.lightGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(style.insets.xs),
                        borderSide: const BorderSide(
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),
                  ),
                  Gap(style.insets.lg),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: style.insets.xs),
                    child: Text(
                      'Notes',
                      style: style.text.h4,
                    ),
                  ),
                  DottedBorder(
                    strokeWidth: 1,
                    color: AppColors.lightGrey,
                    borderType: BorderType.RRect,
                    dashPattern: const [1, 0, 2],
                    radius: Radius.circular(style.radius.sm),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: style.insets.md),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: style.text.bodyContentSmall
                            .copyWith(color: AppColors.lightGrey),
                        hintText: 'Click to add notes',
                      ),
                    ),
                  ),
                  Gap(style.insets.lg),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: style.insets.xs),
                    child: Text(
                      'Attachment',
                      style: style.text.h4,
                    ),
                  ),
                  // Attachment field
                  if (attachment == null)
                    DottedBorder(
                      strokeWidth: 1,
                      color: AppColors.lightGrey,
                      borderType: BorderType.RRect,
                      dashPattern: const [1, 0, 2],
                      radius: Radius.circular(style.radius.sm),
                      child: TextField(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            setState(() {
                              attachment = result.files.single.path!;
                              extention = result.files.single.extension;
                            });
                          }
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: style.insets.md),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintStyle: style.text.bodyContentSmall
                              .copyWith(color: AppColors.lightGrey),
                          hintText: 'Tap to add Attachment',
                        ),
                      ),
                    ),
                  Gap(style.insets.sm),
                  // Attachment
                  if (attachment != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (isImage)
                              Image.file(
                                File(attachment!),
                                fit: BoxFit.cover,
                                width: style.icon.lg,
                                height: style.icon.lg,
                              ),
                            if (!isImage)
                              SvgIcon(
                                name: 'attach',
                                size: style.icon.lg,
                              ),
                            Gap(style.insets.md),
                            Text(attachment!.split('/').last),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              attachment = null;
                              extention = '';
                            });
                          },
                          icon: SvgIcon(
                            name: 'cancel',
                            size: style.icon.xs,
                          ),
                        )
                      ],
                    ),
                  Gap(style.insets.lg),
                  Text('Created', style: style.text.bodyContentSmall),
                  Text(
                    'Jul 4,2019',
                    style: style.text.h4,
                  ),
                  Gap(style.insets.xxl),
                  //buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                const WidgetStatePropertyAll(AppColors.red),
                            backgroundColor:
                                const WidgetStatePropertyAll(AppColors.white),
                            shape: WidgetStatePropertyAll(
                                ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(style.radius.sm),
                                    side: const BorderSide(
                                        color: AppColors.red))),
                          ),
                          onPressed: () {},
                          child: Text('Delete', style: style.text.bodyContent),
                        ),
                      ),
                      Gap(style.insets.lg),
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 3.5),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(style.radius.sm),
                                  gradient: const LinearGradient(colors: [
                                    AppColors.purpleGradient,
                                    AppColors.blueGradient
                                  ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      iconColor: AppColors.white,
                                      foregroundColor: AppColors.white,
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            style.radius.sm),
                                      )),
                                  onPressed: () {},
                                  child: Text('Save',
                                      style: style.text.bodyContent)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class SelectLocation extends StatelessWidget {
  const SelectLocation({
    super.key,
    required this.screenSize,
  });

  final double screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey,
            blurRadius: 5,
          )
        ],
      ),
      child: Material(
        color: AppColors.white,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: (screenSize - (style.insets.xxl * 3)) / 3,
            padding: EdgeInsets.symmetric(horizontal: style.insets.sm),
            child: Column(
              children: [
                const Expanded(
                  flex: 10,
                  child: SvgIcon(
                    name: 'location_earth',
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Align(
                    child: Text(
                      'Office Location',
                      style: style.text.bodyContentSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShareTodo extends StatelessWidget {
  const ShareTodo({
    super.key,
    required this.screenSize,
  });

  final double screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey,
            blurRadius: 5,
          )
        ],
      ),
      child: Material(
        color: AppColors.white,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const SelectLocationModal(),
            );
          },
          child: Container(
            width: (screenSize - (style.insets.xxl * 3)) / 3,
            padding: EdgeInsets.symmetric(horizontal: style.insets.sm),
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: CircleNetworkImage(
                      width: style.icon.md,
                      image:
                          'https://images.unsplash.com/photo-1528892952291-009c663ce843?q=80&w=1544&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                ),
                Expanded(
                  flex: 9,
                  child: Align(
                    child: Text(
                      'Share todo',
                      style: style.text.bodyContentSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectLocationModal extends StatelessWidget {
  const SelectLocationModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(style.radius.md)),
      insetPadding: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(style.insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SvgIcon(
                  name: 'location_earth',
                  size: style.icon.xs,
                ),
                Gap(style.insets.md),
                Text(
                  'Todo Location',
                  style: style.text.h4.copyWith(color: AppColors.blue),
                ),
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
                Expanded(
                  child: GradientButtonRoundCorner(
                    onClick: () {},
                    text: 'Done',
                  ),
                ),
              ],
            ),
            Gap(style.insets.xs),
            TextField(
              decoration: InputDecoration(
                hintStyle: style.text.bodyContentSmall
                    .copyWith(color: AppColors.lightGrey),
                hintText: 'Seach Location',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(style.insets.xs),
                  borderSide: const BorderSide(
                    color: AppColors.lightGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(style.insets.xs),
                  borderSide: const BorderSide(
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: style.insets.md),
              child: Text(
                'Company Location',
                style: style.text.h4,
              ),
            ),
            Consumer<TodoController>(
              builder: (context, todoController, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: todoController.locations.length,
                  itemBuilder: (context, index) {
                    Map location = todoController.locations[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {},
                      title: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: location['image'],
                            width: style.scale * 50,
                            height: style.scale * 50,
                          ),
                          Gap(style.insets.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location['placeName'],
                                  style: style.text.bodyContent,
                                ),
                                Row(
                                  children: [
                                    SvgIcon(
                                      name: 'location',
                                      color: AppColors.black,
                                      size: style.icon.xxs,
                                    ),
                                    Gap(style.insets.xs),
                                    Text(
                                      location['location'],
                                      style: style.text.bodyContentXSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.check,
                            size: style.icon.xxs,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTime extends StatelessWidget {
  const SelectTime({
    super.key,
    required this.screenSize,
  });

  final double screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey,
            blurRadius: 5,
          )
        ],
      ),
      child: Material(
        color: AppColors.white,
        child: InkWell(
          splashColor: AppColors.lightGrey,
          onTap: () {
            showDatePicker(
              initialDate: DateTime.now(),
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
          },
          child: Container(
            width: (screenSize - (style.insets.xxl * 3)) / 3,
            padding: EdgeInsets.symmetric(horizontal: style.insets.sm),
            child: Column(
              children: [
                const Expanded(
                  flex: 10,
                  child: Icon(Icons.access_time),
                ),
                Expanded(
                  flex: 9,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Today 01:30am',
                      style: style.text.bodyContentSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
