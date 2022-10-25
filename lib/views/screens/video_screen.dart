import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/controllers/video_controller.dart';
import 'package:tiktok_tutorial/views/screens/comment_screen.dart';
import 'package:tiktok_tutorial/views/widgets/circle_animation.dart';
import 'package:tiktok_tutorial/views/widgets/video_player_iten.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image(
          image: NetworkImage(profilePhoto),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  buidMusicAlbum(String profilePhoto) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey.shade800, Colors.black],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image(
          image: NetworkImage(profilePhoto),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        return PageView.builder(
            itemCount: videoController.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(
                    videoUrl: data.videoUrl,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.username,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(7),
                                    Text(
                                      data.caption,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Gap(7),
                                    Row(
                                      children: [
                                        const Icon(Icons.music_note,
                                            size: 15, color: Colors.white),
                                        const Gap(5),
                                        Text(
                                          data.songName,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildProfile(data.profilePhoto),
                                  const Gap(25),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            videoController.likeVideo(data.id),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 40,
                                          color: data.likes.contains(
                                                  authController.user.uid)
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                      ),
                                      Text(
                                        data.likes.length.toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      const Gap(15),
                                      InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => CommentScreen(
                                              id: data.id,
                                            ),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.comment,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        data.commentCount.toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      const Gap(15),
                                      InkWell(
                                        onTap: () {
                                          print('You tap share');
                                        },
                                        child: const Icon(
                                          Icons.reply,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        data.shareCount.toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const Gap(25),
                                  CircleAnimation(
                                    child: buidMusicAlbum(data.profilePhoto),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            });
      }),
    );
  }
}
