import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/controllers/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['question'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                                  // String formattedDateTime =
                                  //     DateFormat('yyyy-MM-dd HH:mm')
                                  //         .format(DateTime.now());
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userId)
                                        .collection('questions')
                                        .doc(userDocId)
                                        .update(
                                            {'answer': answerController.text});
                                    await FirebaseFirestore.instance
                                        .collection('lawyers')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('questions')
                                        .doc(docId)
                                        .update(
                                            {'answer': answerController.text});
                                    Fluttertoast.showToast(msg: 'Submitted');
                                    LocalNotificationService.sendNotification(
                                        title: 'Answer',
                                        message: answerController.text,
                                        token: token);
                                  } catch (e) {
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
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
