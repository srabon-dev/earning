import 'package:earning/model/message_model.dart';
import 'package:flutter/material.dart';
import 'custom_shape.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.messageModel});
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    final senderChatMessage = Flexible(
        child: Row(
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
                child: Column(
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
                ),
              ),
            ),
            CustomPaint(painter: CustomShape(Colors.cyan.shade900)),
          ],
        ));

    final receiverChatMessage = Flexible(
        child: Row(
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
                child: Column(
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
                ),
              ),
            ),
            CustomPaint(painter: CustomShape(Colors.cyan.shade900)),
          ],
        ));

    return Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 12, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 30),
          (messageModel.isMe??false)? senderChatMessage : receiverChatMessage,
        ],
      ),
    );
  }
}