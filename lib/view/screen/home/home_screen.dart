import 'package:earning/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    Get.put(HomeController());
    super.initState();
  }

  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GetBuilder<HomeController>(
        key: key,
        builder: (logic) {
          return PageView.builder(
            itemCount: logic.url.length,
            controller: logic.pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (int page){
              logic.initVideoPlayer(url: logic.url[page]);
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: VideoPlayer(logic.videoPlayerController??VideoPlayerController.networkUrl(Uri.parse(logic.url[0]))),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: logic.videoPlayControl,
                      child: Container(
                        height: 200,
                        width: 200,
                        alignment: Alignment.center,
                        child: logic.isVisible? SizedBox(
                          child: logic.isPlayVideo?const Icon(Iconsax.pause,color: Colors.grey,size: 50,):const Icon(Iconsax.play,color: Colors.grey,size: 50,),
                        ): Container(
                          height: 200,
                          width: 200,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
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
                                padding: const EdgeInsets.only(
                                  left: 20
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Srabon",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("I Love Bangladesh",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          //like function
                                        },
                                        child: const Icon(
                                          Icons.favorite,
                                          size: 40,
                                          color: Colors.red//data.likes.contains(authController.user.uid) ? Colors.red : Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      const Text("10",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
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
            },
          );
        },
      ),
    );
  }
}
