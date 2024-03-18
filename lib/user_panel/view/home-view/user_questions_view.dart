import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/controllers/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class QuestionsView extends StatefulWidget {
  final String lawyerId;
  final String? token;
  const QuestionsView({super.key, required this.lawyerId, this.token});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  final TextEditingController answerController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? userToken;

  Future<void> askQuestion() async {
    String question = questionController.text.trim();
    if (question.isNotEmpty) {
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

      //   String formattedDateTime =
      //      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

      try {
        await userRef.set({
          'question': question,
          'answer': '',
          'lawyerId': widget.lawyerId,
          'docId': userRef.id,
          'lawyerDocId': lawyerRef.id,
        });

        await lawyerRef.set({
          'question': question,
          'answer': '',
          'userId': auth.currentUser!.uid,
          'docId': lawyerRef.id,
          'userDocId': userRef.id,
          'fcmToken': userToken ?? ''
        });
        questionController.clear();
        Fluttertoast.showToast(msg: 'Submitted');
        LocalNotificationService.sendNotification(
            title: 'Question', message: question, token: widget.token ?? '');
      } catch (e) {
        Fluttertoast.showToast(msg: 'Something went wrong');
        rethrow;
      }
    } else {
      Fluttertoast.showToast(msg: 'Ask question');
    }
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kButtonColor,
          automaticallyImplyLeading: false,
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
          padding: EdgeInsets.all(Get.width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: questionController,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'Your Question'),
                ),
                SizedBox(height: Get.height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    if (questionController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Ask your question');
                    } else {
                      askQuestion();
                    }
                  },
                  child: Text(
                    'Ask',
                    style: kBody1DarkBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
