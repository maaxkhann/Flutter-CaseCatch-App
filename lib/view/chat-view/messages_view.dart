import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/chat-view/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kButtonColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Messages',
            style: kHead2White,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Recent',
                  style: kBody1MediumBlue,
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () => Get.to(() => const ChatView()),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundImage:
                              const AssetImage('assets/images/home/person.png'),
                        ),
                        SizedBox(
                          width: 2.r,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rako Christian',
                              style: kBody1Black2,
                            ),
                            Text(
                              'Hello! hope you are doing well',
                              style: kBody3Grey,
                            )
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '10:02AM',
                          style: kBody3DarkBlue,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
