import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsScreen extends StatelessWidget {
  final String userId;

  const QuestionsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Questions & Answers'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('questions')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No questions found.'),
              );
            }

            // Extracting questions and answers from snapshot
            List<String> questions = [];
            List<String> answers = [];

            snapshot.data!.docs.forEach((doc) {
              var data = doc.data() as Map<String, dynamic>;
              List<dynamic> questionList = data['questions'];
              List<dynamic> answerList = data['answers'];

              for (int i = 0; i < questionList.length; i++) {
                questions.add(questionList[i]);
                answers.add(answerList[i]);
              }
            });

            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    '${index + 1}.',
                    style: kBody1Black,
                  ),
                  title: Text(questions[index]),
                  subtitle: Text(answers[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
