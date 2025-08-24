import 'package:chat_app/constants.dart';
import 'package:chat_app/models/Message.dart';
import 'package:flutter/material.dart';

class BubbleElement extends StatelessWidget {
  const BubbleElement({super.key, required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: kPrimaryColor,

          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(24),
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class BubbleElementForFriend extends StatelessWidget {
  const BubbleElementForFriend({super.key, required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.grey,

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
