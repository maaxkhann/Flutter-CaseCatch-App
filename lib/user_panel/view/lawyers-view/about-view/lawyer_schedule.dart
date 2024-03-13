import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScheduleScreen extends StatefulWidget {
  final String? lawyerId;
  const ScheduleScreen({Key? key, this.lawyerId}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kBlack),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Lawyers Availability',
          textAlign: TextAlign.center,
          style: kHead2Black,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _getUserSchedule(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData ||
              snapshot.data?.data()?['availability'] == null) {
            return Center(
                child: Text(
              'No schedule found',
              style: kHead2Black,
            ));
          }

          Map<String, dynamic> lawyerData = snapshot.data!.data()!;
          Map<String, dynamic> lawyerSchedule =
              (lawyerData['availability']) ?? {};

          List<String> weekDays = [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday',
          ];

          Map<String, dynamic> rearrangedSchedule = {};
          for (var day in weekDays) {
            if (lawyerSchedule.containsKey(day)) {
              rearrangedSchedule[day] = lawyerSchedule[day];
            }
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(),
                  for (var day in rearrangedSchedule.keys)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 12.h),
                      child: Row(
                        children: [
                          Center(child: Text(day, style: kBody1Black)),
                          const Spacer(),
                          Wrap(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  color: rearrangedSchedule[day] == true
                                      ? kButtonColor
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  rearrangedSchedule[day] == true
                                      ? 'Available'
                                      : 'Unavailable',
                                  style: kBody2White,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _getUserSchedule() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('lawyers').doc(widget.lawyerId).snapshots();
    }
    throw Exception('User not authenticated');
  }
}
