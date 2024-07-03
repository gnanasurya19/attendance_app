import 'package:attendance_app/res/common_lib.dart';
import 'package:video_player/video_player.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
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
  }

  bool isPlaying = false;
  videoListerner() {
    setState(() {
      isPlaying = controller.value.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
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
                        children: [const ListTile()],
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
      body: Column(
        children: [
          SizedBox(
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
          ),
        ],
      ),
    );
  }
}
