import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/leave_page.dart';
import 'package:attendance_app/screens/widget/circle_network_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ResizeImage(const AssetImage('assets/images/home_bg.png'),
                  height: MediaQuery.sizeOf(context).height.toInt(),
                  width: MediaQuery.sizeOf(context).width.toInt()),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Gap(MediaQuery.sizeOf(context).height * 0.1),
            Hero(
              tag: 'profile',
              child: CircleNetworkImage(
                image:
                    'https://images.unsplash.com/photo-1600180758890-6b94519a8ba6?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                width: (MediaQuery.sizeOf(context).width +
                        MediaQuery.sizeOf(context).height) /
                    7,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DotWidget(color: AppColors.green),
                const Gap(7),
                Text(
                  'Active',
                  style: style.text.titleLarge.copyWith(color: AppColors.grey),
                )
              ],
            ),
            Gap(MediaQuery.sizeOf(context).height * 0.05),
            Card(
              elevation: 5,
              color: AppColors.white,
              margin: EdgeInsets.symmetric(horizontal: style.insets.xxl),
              child: Padding(
                padding: EdgeInsets.all(style.insets.lg),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgIcon(
                            name: 'mail_outline',
                            size: style.icon.xxs,
                          ),
                          Text(
                            'example@gmail.com',
                            style: style.text.title
                                .copyWith(color: AppColors.grey),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgIcon(
                            name: 'phone-call',
                            size: style.icon.xxs,
                          ),
                          Text(
                            '9840377118',
                            style: style.text.title
                                .copyWith(color: AppColors.grey),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgIcon(
                            name: 'location_fill',
                            size: style.icon.xxs,
                          ),
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '130, KOM 4, Office #6, 2nd floor KOM, Muscut, Sib Oman',
                              style: style.text.title
                                  .copyWith(color: AppColors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'login',
                          (route) => false,
                        );
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: style.insets.sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              size: style.icon.xs,
                            ),
                            Text(
                              'Logout Account',
                              style: style.text.title
                                  .copyWith(color: AppColors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
