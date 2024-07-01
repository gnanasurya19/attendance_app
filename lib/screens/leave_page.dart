import 'package:attendance_app/res/common_lib.dart';

import 'widget/gradient_button_round_corner.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({
    super.key,
  });

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  final List<Map<String, dynamic>> leaves = [
    {
      'text': 'Casual Leave',
      'leaves': 2,
      'value': 0.2,
      'color': AppColors.blue,
    },
    {
      'text': 'Madical Leave',
      'leaves': 4,
      'value': 0.75,
      'color': AppColors.pink,
    },
    {
      'text': 'Annual Leave',
      'leaves': 7,
      'value': 0.75,
      'color': AppColors.orange,
    },
    {
      'text': 'Maternity Leave',
      'leaves': 0,
      'value': 0.0,
      'color': AppColors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.symmetric(horizontal: style.insets.lg),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: kToolbarHeight,
              alignment: Alignment.center,
              child: Text(
                'My Leaves',
                style: style.text.h2,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: Column(
                    children: [
                      Gap(style.scale * 30),
                      Gap(style.scale * 30),
                      //balance leave

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 350,
                              maxHeight: 350,
                            ),
                            height: MediaQuery.sizeOf(context).width * 0.6,
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: TweenAnimationBuilder(
                              builder: (context, value, child) {
                                double leavePercent = 0.75 * value;
                                return CircularProgressIndicator(
                                  strokeWidth: style.scale * 10,
                                  backgroundColor: AppColors.lightGrey,
                                  color: AppColors.blue,
                                  value: leavePercent,
                                );
                              },
                              duration: const Duration(seconds: 1),
                              tween: Tween<double>(begin: 0, end: 1),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '05',
                                style: style.text.h
                                    .copyWith(color: AppColors.blueGrey),
                              ),
                              Text(
                                'Leave Balance',
                                style: style.text.bodyTitle
                                    .copyWith(color: AppColors.blueGrey),
                              )
                            ],
                          ),
                        ],
                      ),

                      Gap(style.insets.lg),
                      //apply leave button
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'apply-leave');
                        },
                        child: Text(
                          'Click to Apply for Leave',
                          style: style.text.bodyContentSmall.copyWith(
                            color: AppColors.blueGrey,
                          ),
                        ),
                      ),
                      Gap(style.insets.xxl),
                      //total and used leave count
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2.0),
                                child: DotWidget(
                                  color: AppColors.grey,
                                ),
                              ),
                              Gap(style.insets.md),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Leave',
                                    style: style.text.bodyContentSmall,
                                  ),
                                  Text(
                                    '20',
                                    style: style.text.h2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2.0),
                                child: DotWidget(
                                  color: AppColors.blue,
                                ),
                              ),
                              Gap(style.insets.md),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Leave Used',
                                    style: style.text.bodyContentSmall,
                                  ),
                                  Text(
                                    '15',
                                    style: style.text.h2,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),

                      Gap(style.insets.xxl),

                      //leave details
                      LeaveDetails(leaves: leaves),

                      Gap(style.insets.lg),

                      //buttons
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: style.insets.lg),
                        child: Row(
                          children: [
                            Expanded(
                              child: GradientButtonRoundCorner(
                                onClick: () {},
                                text: 'Approve',
                              ),
                            ),
                            Expanded(
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Leave History',
                                      style: style.text.bodyContent
                                          .copyWith(color: AppColors.greyText),
                                    )))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveDetails extends StatelessWidget {
  const LeaveDetails({
    super.key,
    required this.leaves,
  });

  final List<Map<String, dynamic>> leaves;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: leaves
          .map(
            (e) => Expanded(
                child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    TweenAnimationBuilder(
                        duration: const Duration(seconds: 1),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, value, child) {
                          double leavePercent = e['value'] * value;
                          return CircularProgressIndicator(
                            backgroundColor: AppColors.lightGrey,
                            color: e['color'],
                            strokeWidth: style.scale * 3,
                            value: leavePercent,
                          );
                        }),
                    Text(
                      "${e['leaves']}",
                      style: style.text.h3,
                    )
                  ],
                ),
                Gap(style.insets.md),
                Text(
                  e['text'],
                  textAlign: TextAlign.center,
                  style: style.text.bodyContentXSmall
                      .copyWith(color: AppColors.blueGrey),
                ),
              ],
            )),
          )
          .toList(),
    );
  }
}

class DotWidget extends StatelessWidget {
  final Color color;
  final double? size;
  const DotWidget({
    super.key,
    this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: style.scale * (size ?? 10),
      width: style.scale * (size ?? 10),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
