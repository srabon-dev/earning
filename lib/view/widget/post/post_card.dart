import 'package:cached_network_image/cached_network_image.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, this.isMyPost = false,this.isFavorite = false});
  final bool isMyPost;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor)),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isDarkMode ? AppColors.blackColor:AppColors.whiteColor,
          ),
          child: Column(
            children: [


              //Top Section
              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                                imageUrl:
                                "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjEwMzQtZWxlbWVudC0wNi0zOTcucG5n.png"),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Srabon Bapari",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 5),
                        const Icon(Iconsax.verify,size: 18,color: AppColors.greenColor,),
                      ],
                    ),
                    isFavorite?PopupMenuButton<String>(
                      onSelected: (String choice){

                      },
                      itemBuilder: (BuildContext context)=>[
                        const PopupMenuItem(
                            value: "Remove Favorite",
                            child: ListTile(
                              title: Text("Remove Favorite"),
                              leading: Icon(Iconsax.lovely5),
                            )),
                      ],
                    ): PopupMenuButton<String>(
                      onSelected: (String choice){

                      },
                      itemBuilder: (BuildContext context)=>[
                        PopupMenuItem(
                            value: isMyPost?"Delete": "Favorite Post",
                            child: ListTile(
                              title: Text(isMyPost? "Delete": "Favorite Post"),
                              leading: Icon(isMyPost?Icons.delete_outline:Iconsax.lovely5),
                            )),
                        PopupMenuItem<String>(
                            value: isMyPost?"Edit":"Report Post",
                            child: ListTile(
                              title: Text(isMyPost?"Edit":"Report Post"),
                              leading: Icon(isMyPost?Iconsax.edit:Iconsax.receipt),
                            )),
                      ],
                    ),
                  ],
                ),
              ),

              //Text Section
              ListTile(
                title: ReadMoreText(
                  'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Show less',
                  moreStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800).copyWith(
                      color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor
                  ),
                  lessStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.redColor,
                  ),
                ),
              ),

              //Image Section
              GestureDetector(
                onTap: (){
                  showImageViewer(context, Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Shiva_temples_Dhakeshwari_Mandir_2_by_Ragib_Hasan.jpg/1024px-Shiva_temples_Dhakeshwari_Mandir_2_by_Ragib_Hasan.jpg').image,
                      swipeDismissible: true);
                },
                child: SizedBox(
                  width: width,
                  height: height / 5,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                    imageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Shiva_temples_Dhakeshwari_Mandir_2_by_Ragib_Hasan.jpg/1024px-Shiva_temples_Dhakeshwari_Mandir_2_by_Ragib_Hasan.jpg",
                  ),
                ),
              ),
              const SizedBox(height: 8.0),


              //Live Button Section
              LikeButton(
                size: 50,
                circleColor: const CircleColor(
                  start: Color(0xffe320e0),
                  end: Color(0xffee0d70),
                ),
                onTap: (bool isLiked) async {
                  return !isLiked;
                },
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color(0xffec8119),
                  dotSecondaryColor: Color(0xff1cdc7c),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Iconsax.lovely,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 35,
                  );
                },
                likeCount: 665,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
