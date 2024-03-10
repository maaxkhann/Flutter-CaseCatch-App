import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../lawyer_panel/controllers/data_controller.dart';
import '../../../lawyer_panel/dashboard/chat/notification.dart';
import '../../../user_panel/constants/colors.dart';
import '../../../user_panel/constants/textstyles.dart';

class Chat extends StatefulWidget {
  const Chat(
      {super.key,
      this.image,
      this.name,
      this.groupId,
      this.fcmToken,
      this.uid});

  final String? image, name, groupId, fcmToken, uid;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isSendingMessage = false;
  bool isEmojiPickerOpen = false;
  String myUid = '';
  var screenheight;

  var screenwidth;

  DataController dataController = Get.put(DataController());
  TextEditingController messageController = TextEditingController();
  FocusNode inputNode = FocusNode();
  String replyText = '';
  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  _onBackspacePressed() {
    messageController
      ..text = messageController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: messageController.text.length));
  }

  @override
  void initState() {
    super.initState();
    dataController = Get.find<DataController>();
    myUid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    screenheight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kButtonColor,
        actions: [
          widget.image!.isEmpty
              ? const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                )
              : CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.image!),
                ),
          const SizedBox(
            width: 16,
          )
        ],
        title: Text(
          widget.name.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: Row(
          children: [
            const SizedBox(
              width: 14,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(() => dataController.isMessageSending.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream:
                          dataController.getMessage(widget.groupId, widget.uid),
                      builder: (ctx, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        List<DocumentSnapshot> data =
                            snapshot.data!.docs.reversed.toList();

                        return ListView.builder(
                          reverse: true,
                          itemBuilder: (ctx, index) {
                            String messageUserId = data[index].get('uid');
                            String messageType = data[index].get('type');

                            Widget messageWidget = Container();

                            if (messageUserId == myUid) {
                              switch (messageType) {
                                case 'iSentText':
                                  messageWidget = textMessageISent(data[index]);
                                  break;

                                case 'iSentReply':
                                  messageWidget =
                                      sentReplyTextToText(data[index]);
                              }
                            } else {
                              switch (messageType) {
                                case 'iSentText':
                                  messageWidget =
                                      textMessageIReceived(data[index]);
                                  break;

                                case 'iSentReply':
                                  messageWidget =
                                      receivedReplyTextToText(data[index]);
                              }
                            }

                            return messageWidget;
                          },
                          itemCount: data.length,
                        );
                      },
                    ))),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // width: 200,
                        // height: 50,
                        child: MessageBar(
                          onTextChanged: (p0) {
                            messageController.text = p0;
                          },
                          onSend: (_) async {
                            if (messageController.text.isEmpty) {
                              return;
                            }

                            String message = messageController.text;
                            messageController.clear();

                            Map<String, dynamic> data = {
                              'type': 'iSentText',
                              'message': message,
                              'timeStamp': DateTime.now(),
                              'uid': myUid
                            };

                            if (replyText.length > 0) {
                              data['reply'] = replyText;
                              data['type'] = 'iSentReply';
                              replyText = '';
                            }
                            DocumentSnapshot<Map<String, dynamic>> document =
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .get();
                            final userData = document.data()!;
                            String userName = userData['username'];
                            String userImage = userData['image'];
                            String fcmToken = userData['fcmToken'];

                            dataController.sendMessageToFirebase(
                                data: data,
                                userId: widget.groupId.toString(),
                                otherUserId: widget.uid.toString(),
                                lastMessage: message,
                                name: userName,
                                image: userImage,
                                fcmToken: fcmToken);

                            dataController.createNotification(
                              userId: widget.uid.toString(),
                              message: message,
                            );

                            LocalNotificationService.sendNotification(
                                title: 'New message from $userName',
                                message: message,
                                token: widget.fcmToken);
                          },
                          messageBarColor: Colors.grey.shade100,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  textMessageIReceived(DocumentSnapshot doc) {
    String message = '';
    try {
      message = doc.get('message');
    } catch (e) {
      message = '';
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Dismissible(
        confirmDismiss: (a) async {
          replyText = message;
          await Future.delayed(const Duration(seconds: 1));
          openKeyboard();
          return false;
        },
        key: UniqueKey(),
        direction: DismissDirection.startToEnd,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: widget.image!.isEmpty
                      ? const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(widget.image!),
                        ),
                ),
                BubbleSpecialOne(
                    text: message,
                    color: Colors.grey.shade300,
                    textStyle: kBody3Black),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70, top: 5),
                  child: Text(
                    DateFormat.Hm().format(doc.get('timeStamp').toDate()),
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  textMessageISent(DocumentSnapshot doc) {
    String message = doc.get('message');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BubbleSpecialOne(
            text: message, color: Colors.blue, textStyle: kBody3LightBlue),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 20),
              child: Text(
                DateFormat.Hm().format(doc.get('timeStamp').toDate()),
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ],
    );
  }

  sentReplyTextToText(DocumentSnapshot doc) {
    String message = '';
    String reply = '';
    try {
      message = doc.get('message');
    } catch (e) {
      message = '';
    }

    try {
      reply = doc.get('reply');
    } catch (e) {
      reply = '';
    }

    return Container(
      margin: const EdgeInsets.only(right: 20, top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 66, top: 5),
                child: Text(
                  "You replied to ${widget.name}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: screenheight * 0.006,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 17),
                width: screenwidth * 0.43,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18),
                    ),
                    color: Colors.grey.shade300),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    reply,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Container(
                  width: 1,
                  height: 50,
                  color: const Color(0xff918F8F),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenheight * 0.003,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BubbleSpecialOne(
                  text: message,
                  color: Colors.blue,
                  textStyle: kBody3LightBlue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  DateFormat.Hm().format(doc.get('timeStamp').toDate()),
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  receivedReplyTextToText(DocumentSnapshot doc) {
    String message = '';
    String reply = '';
    try {
      message = doc.get('message');
    } catch (e) {
      message = '';
    }

    try {
      reply = doc.get('reply');
    } catch (e) {
      reply = '';
    }

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 66, top: 5),
                child: Text(
                  "Replied to you ",
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: screenheight * 0.006,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 65, right: 10),
                child: Container(
                  width: 1,
                  height: 50,
                  color: const Color(0xff918F8F),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0),
                width: screenwidth * 0.4,
                // height: screenheight * 0.06,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18),
                    ),
                    color: Colors.blue.shade400),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    reply,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenheight * 0.003,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: widget.image!.isEmpty
                    ? const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(widget.image!),
                      ),
              ),
              BubbleSpecialOne(
                  text: message,
                  color: Colors.grey.shade300,
                  textStyle: kBody3Black),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 73, top: 2),
                child: Text(
                  DateFormat.Hm().format(doc.get('timeStamp').toDate()),
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
