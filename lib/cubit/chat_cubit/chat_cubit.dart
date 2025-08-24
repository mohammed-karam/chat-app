import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/chat_cubit/chat_states.dart';
import 'package:chat_app/models/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitialChatState());

  CollectionReference<Map<String, dynamic>> messages = FirebaseFirestore
      .instance
      .collection(kMessagesCollection);

  List<Message> messagesList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({kMessage: message, kCreatedAt: DateTime.now(), kId: email});
    } catch (e) {
      print(e.toString());
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(SuccessChatState(messagesList : messagesList));
    });
  }
}
