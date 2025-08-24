import 'package:chat_app/models/Message.dart';

class ChatStates {}

class InitialChatState extends ChatStates {}

class SuccessChatState extends ChatStates {
  List<Message> messagesList;
  SuccessChatState({required this.messagesList});
}
