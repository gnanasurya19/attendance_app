import 'package:animations/animations.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/profile_page.dart';
import 'package:attendance_app/screens/widget/circle_network_image.dart';

class ProfilePopover extends StatelessWidget {
  const ProfilePopover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable:false,
      closedBuilder: (BuildContext context, action) {
        return Container(
          padding: EdgeInsets.all(style.insets.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'profile',
                child: CircleNetworkImage(
                  image:
                      'https://images.unsplash.com/photo-1600180758890-6b94519a8ba6?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  width: 100 * style.scale,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.xs),
                child: Text(
                  'Jonathan nuez',
                  style: style.text.bodyTitleLg
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Software Developer',
                style: style.text.bodyTitle,
              ),
              Gap(style.insets.lg),
              TextButton(
                  style: TextButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(style.radius.md)),
                    backgroundColor: AppColors.lightGrey,
                    foregroundColor: const Color(0xFF555555),
                  ),
                  onPressed: () {
                    action.call();
                  },
                  child: Text(
                    'Edit Profile',
                    style: style.text.title,
                  ))
            ],
          ),
        );
      },
      openBuilder:
          (BuildContext context, void Function({Object? returnValue}) action) {
        return const ProfilePage();
      },
    );
  }
}
