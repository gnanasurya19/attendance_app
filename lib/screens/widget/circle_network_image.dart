import 'package:attendance_app/res/common_lib.dart';

class CircleNetworkImage extends StatelessWidget {
  const CircleNetworkImage({
    super.key,
    required this.image,
    this.width,
  });

  final double? width;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CachedNetworkImage(
        placeholder: (context, url) => Container(
          color: AppColors.lightGrey,
        ),
        cacheKey: 'todo$image',
        imageUrl: image,
        fit: BoxFit.cover,
      ),
    );
  }
}
