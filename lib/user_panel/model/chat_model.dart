import 'package:catch_case/user_panel/view/chat-view/chat_view.dart';

class Message {
  final String text;
  final String time;
  final Sender sender;

  Message({
    required this.text,
    required this.time,
    required this.sender,
  });
}
