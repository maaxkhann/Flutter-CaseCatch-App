import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShowQuestionAnswerLawyer extends StatelessWidget {
  const ShowQuestionAnswerLawyer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: kButtonColor,
          title: Text(
            'Question Answer',
            style: kHead2White,
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('lawyers')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('questions')
                //  .orderBy('answerTime')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Card(
                      color: Colors.grey.shade50,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 10.h,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: double.infinity,
                              height: 10.h,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: double.infinity,
                              height: 10.h,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'No data to show',
                    style: kBody1DarkBlue,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Something went wrong',
                    style: kBody1DarkBlue,
                  ),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return Card(
                      color: Colors.grey.shade50,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Q: ${data['question']}',
                                style: kBody1Black2,
                                textAlign: TextAlign.start),
                            Text('Ans: ${data['answer']}',
                                style: kBody1Black, textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
