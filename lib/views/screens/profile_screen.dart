import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/controllers/profile_controller.dart';
import 'package:tiktok_tutorial/controllers/video_controller.dart';
import 'package:tiktok_tutorial/views/screens/video_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                controller.user['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: controller.user['profilePhoto'],
                                  height: 100,
                                  width: 100,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 65,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      controller.user['following'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Following',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey,
                                width: 1,
                                height: 15,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                              SizedBox(
                                width: 65,
                                child: Column(
                                  children: [
                                    Text(
                                      controller.user['followers'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Followers',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey,
                                width: 1,
                                height: 15,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                              SizedBox(
                                width: 65,
                                child: Column(
                                  children: [
                                    Text(
                                      controller.user['likes'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Likes',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                if (widget.uid == authController.user.uid) {
                                  authController.signOut();
                                } else {
                                  controller.followUser();
                                }
                              },
                              child: Container(
                                width: 140,
                                height: 47,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: buttonColor,
                                ),
                                child: Center(
                                  child: Text(
                                    widget.uid == authController.user.uid
                                        ? 'Sign Out'
                                        : controller.user['isFollowing']
                                            ? 'Unfollow'
                                            : 'Follow',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          // video list
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.user['thumbnails'].length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 3,
                            ),
                            itemBuilder: (context, index) {
                              String thumbnail =
                                  controller.user['thumbnails'][index];
                              return InkWell(
                                onTap: () {
                                  print('Video user');
                                },
                                child: CachedNetworkImage(
                                  imageUrl: thumbnail,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}