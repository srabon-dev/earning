import 'package:cached_network_image/cached_network_image.dart';
import 'package:earning/model/message_model.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'custom_shape.dart';

class ImageChatBubble extends StatelessWidget {
  const ImageChatBubble({super.key, required this.messageModel});

  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return (messageModel.isMe??false)? Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0, left: 12, top: 10, bottom: 5),
        child: GestureDetector(
          onTap: (){
            showImageViewer(context,
                Image.network(messageModel.postImage ?? "").image,
                swipeDismissible: true);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width-100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: messageModel.postImage??"",
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Iconsax.gallery),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade900,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: messageModel.message != ''?Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            messageModel.message??"",
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(timeago.format(messageModel.createdAt?.toDate() ?? DateTime.now()),
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                          ),
                        ],
                      ):Text(timeago.format(messageModel.createdAt?.toDate() ?? DateTime.now()),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                      ),
                    ),
                  ),
                  CustomPaint(painter: CustomShape(Colors.cyan.shade900)),
                ],
              ),
            ],
          ),
        ),
      ),
    ): Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0, left: 12, top: 10, bottom: 5),
        child: GestureDetector(
          onTap: (){
            showImageViewer(context,
                Image.network(messageModel.postImage ?? "").image,
                swipeDismissible: true);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width-100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: messageModel.postImage??"",
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Iconsax.gallery),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade900,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: messageModel.message != ''?Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            messageModel.message??"",
                            textAlign: TextAlign.right,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(timeago.format(messageModel.createdAt?.toDate() ?? DateTime.now()),
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                          ),
                        ],
                      ):Text(timeago.format(messageModel.createdAt?.toDate() ?? DateTime.now()),
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                      ),
                    ),
                  ),
                  CustomPaint(painter: CustomShape(Colors.cyan.shade900)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}