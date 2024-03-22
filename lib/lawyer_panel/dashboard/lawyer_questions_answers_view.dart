import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/user_panel/controllers/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LawyerQuestionAnswer extends StatefulWidget {
  const LawyerQuestionAnswer({super.key});

  @override
  State<LawyerQuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<LawyerQuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kButtonColor,
          centerTitle: true,
          title: Text(
            'Question Answer Session',
            style: kHead2White,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('lawyers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('questions')
              .orderBy('date')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No questions',
                  style: kBody1Black,
                ),
              );
            }
            final questions = snapshot.data!.docs;
            final unansweredQuestions = questions
                .where((question) => question['answer'].isEmpty)
                .toList();
            if (unansweredQuestions.isEmpty) {
              return Center(
                child: Text(
                  'No questions',
                  style: kBody1DarkBlue,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: unansweredQuestions.length,
                  itemBuilder: (context, index) {
                    TextEditingController answerController =
                        TextEditingController();

                    final data = unansweredQuestions[index];

                    String userId = data['userId'];
                    String docId = data['docId'];
                    String userDocId = data['userDocId'];
                    String token = data['fcmToken'];

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(data['date'])),
                          Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (dismiss) {
                              data.reference.delete();
                              Fluttertoast.showToast(msg: 'Deleted');
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['question'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: answerController,
                                      decoration: const InputDecoration(
                                        labelText: 'Your Answer',
                                        border: OutlineInputBorder(),
                                      ),
                                      maxLines: null,
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          EasyLoading.show(status: 'loading..');
                                          // String formattedDateTime =
                                          //     DateFormat('yyyy-MM-dd HH:mm')
                                          //         .format(DateTime.now());
                                          try {
                                            if (answerController
                                                .text.isNotEmpty) {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(userId)
                                                  .collection('questions')
                                                  .doc(userDocId)
                                                  .update({
                                                'answer': answerController.text
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection('lawyers')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('questions')
                                                  .doc(docId)
                                                  .update({
                                                'answer': answerController.text
                                              });
                                              EasyLoading.dismiss();
                                              Fluttertoast.showToast(
                                                  msg: 'Submitted');
                                              LocalNotificationService
                                                  .sendNotification(
                                                      title: 'Answer',
                                                      message:
                                                          answerController.text,
                                                      token: token);
                                            } else {
                                              EasyLoading.dismiss();
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Please answer the question');
                                            }
                                          } on FirebaseException catch (e) {
                                            EasyLoading.dismiss();
                                            if (e.code == 'not-found') {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'This question is deleted by user');
                                              return;
                                            }
                                          } catch (e) {
                                            EasyLoading.dismiss();
                                            Fluttertoast.showToast(
                                                msg: 'Something went wrong');
                                            rethrow;
                                          }
                                          answerController.clear();
                                          setState(() {});
                                        },
                                        child: const Text('Submit'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
