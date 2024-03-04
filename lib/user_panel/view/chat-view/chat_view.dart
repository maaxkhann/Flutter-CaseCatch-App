import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/model/chat_model.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Message> messages = [
      Message(text: 'Hello!', time: '10:00 AM', sender: Sender.me),
      Message(text: 'Hi there!', time: '10:05 AM', sender: Sender.other),
      Message(text: 'How are you?', time: '10:10 AM', sender: Sender.me),
    ];
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Padding(
                padding: EdgeInsets.only(top: 10.r),
                child: BubbleSpecialOne(
                    text: message.text,
                    isSender: message.sender == Sender.me ? true : false,
                    seen: message.sender == Sender.me ? true : false,
                    color: message.sender == Sender.me
                        ? Colors.blue
                        : Colors.grey.shade300,
                    textStyle: message.sender == Sender.me
                        ? kBody3LightBlue
                        : kBody3Black),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MessageBar(
              onSend: (_) {},
              actions: [
                InkWell(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 24.r,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w),
                  child: InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.green,
                      size: 24.r,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

enum Sender { me, other }
