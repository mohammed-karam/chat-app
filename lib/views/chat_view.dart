import 'package:chat_app/components/bubble_element.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubit/chat_cubit/chat_states.dart';
import 'package:chat_app/models/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  static String id = 'chatView';

  // CollectionReference<Map<String, dynamic>> messages = FirebaseFirestore
  //     .instance
  //     .collection(kMessagesCollection);

  TextEditingController? controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  final String? userId = FirebaseAuth.instance.currentUser!.email;
  

  ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    // CollectionReference<Map<String, dynamic>> messages =
    //     BlocProvider.of<ChatCubit>(context).messages;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 60),
            Text(
              'Chat',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          BlocBuilder<ChatCubit, ChatStates>(
            
            builder: (context, state) {
              List<Message> chats = BlocProvider.of<ChatCubit>(context).messagesList;
              return Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    print('$userId ${chats[index].id}');
                    if (chats[index].id == userId) {
                      return BubbleElement(message: chats[index]);
                    } else {
                      return BubbleElementForFriend(message: chats[index]);
                    }
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                if (controller!.text.isNotEmpty) {
                  BlocProvider.of<ChatCubit>(
                    context,
                  ).sendMessage(message: controller!.text, email: userId!);
                  controller!.clear();
                  _scrollController.animateTo(
                    0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 500),
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Sent a message',
                suffixIcon: IconButton(
                  onPressed: () {
                    if (controller!.text.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(
                        context,
                      ).sendMessage(message: controller!.text, email: userId!);
                      controller!.clear();
                      _scrollController.animateTo(
                        0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500),
                      );
                    }
                  },
                  icon: Icon(Icons.send, color: kPrimaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
