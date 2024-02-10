import 'package:catch_case/view/chat-view/widgets/chat_appbar.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ChatAppBar(text: 'Rako Christian'),
      ),
    );
  }
}
