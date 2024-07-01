import 'package:attendance_app/res/common_lib.dart';

class WHFButton extends StatelessWidget {
  final Function() onClick;
  const WHFButton({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.black.withOpacity(0.86),
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * 0.95,
          padding: EdgeInsets.all(style.insets.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Not In Office Range',
                style: style.text.titleLarge.copyWith(color: AppColors.white),
              ),
              const Gap(30),
              Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: MediaQuery.sizeOf(context).width * 0.1 +
                        MediaQuery.sizeOf(context).height * 0.1,
                    height: MediaQuery.sizeOf(context).width * 0.1 +
                        MediaQuery.sizeOf(context).height * 0.1,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xffb776e8), Color(0xff3E82E0)]),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgIcon(
                          name: 'home',
                          size: style.icon.sm,
                          color: AppColors.white,
                        ),
                        const MaxGap(5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Work From Home',
                            textAlign: TextAlign.center,
                            style: style.text.title
                                .copyWith(color: AppColors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const CircleBorder(eccentricity: 0),
                      child: InkWell(
                        splashColor: AppColors.white.withOpacity(0.3),
                        highlightColor: AppColors.white.withOpacity(0.3),
                        onTap: onClick,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
