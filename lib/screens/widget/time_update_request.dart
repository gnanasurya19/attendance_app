import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/widget/colored_button.dart';

class TimeUpdateRequest extends StatelessWidget {
  const TimeUpdateRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var divider = const Divider(
      color: AppColors.lightGrey,
      height: 1,
    );
    return Dialog(
      shadowColor: AppColors.blue,
      elevation: 20,
      backgroundColor: AppColors.white,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(style.radius.md)),
      insetPadding: EdgeInsets.symmetric(horizontal: style.insets.md),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: style.insets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.md),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        cacheKey: 'image',
                        width: style.scale * 50,
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D.png",
                        placeholder: (context, url) => Container(
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),
                    const Gap(5),
                    Text(
                      'Jennifer Auston',
                      style: style.text.h3,
                    ),
                  ],
                ),
              ),
              divider,
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: style.text.bodyContent,
                    ),
                    Text(
                      '10-Dec-2019',
                      style: style.text.bodyContent,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Old Time',
                      style: style.text.bodyContent,
                    ),
                    Text(
                      '01:00pm',
                      style: style.text.bodyContent,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Date',
                      style: style.text.bodyContent,
                    ),
                    Text(
                      '12:25pm',
                      style: style.text.bodyContent.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              divider,
              const Gap(10),
              Text(
                'Team Lead',
                style: style.text.title.copyWith(
                  color: AppColors.greyText,
                ),
              ),
              Text(
                'Ahmed Hassan',
                style: style.text.titleMd.copyWith(color: AppColors.black),
              ),
              const Gap(20),
              Text(
                'Comment',
                style: style.text.title.copyWith(
                  color: AppColors.greyText,
                ),
              ),
              Text(
                'I forgot to punch out',
                style: style.text.titleMd.copyWith(color: AppColors.black),
              ),
              const Gap(20),
              Text(
                'My Comment',
                style: style.text.title.copyWith(
                  color: AppColors.greyText,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: style.insets.md),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3E6394).withOpacity(0.3),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: TextField(
                  maxLines: 2,
                  minLines: 2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    fillColor: AppColors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(style.radius.sm),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(style.radius.sm),
                    ),
                  ),
                ),
              ),
              //buttons
              Padding(
                padding: EdgeInsets.symmetric(vertical: style.insets.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColoredButton(
                      text: 'APPROVE',
                      onClick: () {
                        Navigator.pop(context);
                      },
                      color: AppColors.blue,
                    ),
                    const Gap(10),
                    ColoredButton(
                      text: 'REJECT',
                      onClick: () {
                        Navigator.pop(context);
                      },
                      color: AppColors.darkRed,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
