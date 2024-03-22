import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/user_panel/controllers/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QuestionsView extends StatefulWidget {
  final String lawyerId;
  final String? token;
  const QuestionsView({super.key, required this.lawyerId, this.token});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  final List<TextEditingController> controllers = [];
  final List<bool> questionAsked = [];
  bool isAskNewVisible = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? userToken;

  Future<void> askQuestion(int index) async {
    String question = controllers[index].text.trim();
    if (question.isNotEmpty && questionAsked[index] == false) {
      EasyLoading.show(status: 'loading..');
      final userRef = firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('questions')
          .doc();
      final lawyerRef = firestore
          .collection('lawyers')
          .doc(widget.lawyerId)
          .collection('questions')
          .doc();

      String formattedDateTime =
          DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

      try {
        await userRef.set({
          'question': question,
          'answer': '',
          'lawyerId': widget.lawyerId,
          'docId': userRef.id,
          'lawyerDocId': lawyerRef.id,
          'date': formattedDateTime
        });

        await lawyerRef.set({
          'question': question,
          'answer': '',
          'userId': auth.currentUser!.uid,
          'docId': lawyerRef.id,
          'userDocId': userRef.id,
          'fcmToken': userToken ?? '',
          'date': formattedDateTime
        });
        questionAsked[index] = true;
        isAskNewVisible = true;
        Fluttertoast.showToast(msg: 'Submitted');
        LocalNotificationService.sendNotification(
            title: 'Question', message: question, token: widget.token ?? '');
        EasyLoading.dismiss();
      } catch (e) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Something went wrong');
        rethrow;
      }
    } else if (questionAsked[index] == true) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Question already asked');
    } else {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Ask question');
    }
    setState(() {});
  }

  void getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userToken = value['fcmToken'];
    });
  }

  @override
  void initState() {
    getUserData();
    controllers.add(TextEditingController());
    questionAsked.add(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kButtonColor,
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              )),
          title: Text(
            'Ask Question',
            style: kHead2White,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < controllers.length; i++)
                  Column(
                    children: [
                      TextField(
                        controller: controllers[i],
                        maxLines: null,
                        decoration:
                            const InputDecoration(labelText: 'Your Question'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => askQuestion(i),
                        child: const Text('Ask'),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                if (isAskNewVisible)
                  ElevatedButton(
                    onPressed: () {
                      controllers.add(TextEditingController());
                      questionAsked.add(false);
                      setState(() {
                        isAskNewVisible = false;
                      });
                    },
                    child: const Text('Ask New Question'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
