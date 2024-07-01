import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/my_team_page.dart';
import 'package:attendance_app/screens/widget/time_update_request.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HeaderWidget(
            title: 'Notification',
            icon: 'menu',
          ),
          Gap(style.insets.sm),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: style.insets.lg),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const CardWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) {
            final Animation<Offset> offsetAnimation =
                Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                    .animate(animation);
            return SlideTransition(
                position: offsetAnimation, child: const TimeUpdateRequest());
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: style.insets.md),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightGrey,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                cacheKey: 'image',
                width: style.scale * 40,
                fit: BoxFit.cover,
                imageUrl:
                    "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Ds.png",
                placeholder: (context, url) => Container(
                  color: AppColors.lightGrey,
                ),
              ),
            ),
            Gap(style.insets.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: AppColors.black),
                      children: [
                        TextSpan(
                          text: 'Ajith Kumar ',
                          style: style.text.h5,
                        ),
                        TextSpan(
                          text: 'Applied for',
                          style: style.text.bodyContentSmall,
                        ),
                        TextSpan(
                          text: 'Annual leave ',
                          style: style.text.h5,
                        ),
                        TextSpan(
                          text: 'from 7th March to 09th March',
                          style: style.text.bodyContentSmall,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: style.insets.xs),
                    child: Text(
                      '5th June - 2024',
                      style: style.text.bodyContentXSmall
                          .copyWith(color: AppColors.grey),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                          foregroundColor:
                              WidgetStatePropertyAll(AppColors.white),
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.blue,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'APPROVE',
                          style: style.text.bodyContentXSmall,
                        ),
                      ),
                      const Gap(10),
                      ElevatedButton(
                        style: const ButtonStyle(
                          foregroundColor:
                              WidgetStatePropertyAll(AppColors.white),
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.red,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'REJECT',
                          style: style.text.bodyContentXSmall,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Gap(style.insets.lg),
            Icon(
              Icons.more_horiz,
              size: style.icon.sm,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
