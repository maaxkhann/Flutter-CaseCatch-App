import 'package:catch_case/lawyer_panel/dashboard/schedule/add_schedule.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MySchedule extends StatefulWidget {
  final String lawyerId;
  const MySchedule({Key? key, required this.lawyerId}) : super(key: key);

  @override
  State<MySchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
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
        title: Text('Availability',
            textAlign: TextAlign.center, style: kHead2Black),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.to(() => const AddScheduleScreen());
            },
            child: const Text("Add schedule"),
          )
        ],
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

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return const Center(child: Text('No schedule found.'));
          }

          Map<String, dynamic> lawyerData = snapshot.data!.data()!;
          Map<String, dynamic> lawyerSchedule =
              lawyerData['availability'] ?? {};

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(),
                  for (var day in _weekDays)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 12.h),
                      child: Row(
                        children: [
                          Center(child: Text(day, style: kBody1Black)),
                          const Spacer(),
                          StreamBuilder<bool>(
                            stream: _getDayAvailability(day),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  padding: EdgeInsets.all(6.r),
                                  decoration: BoxDecoration(
                                    color: snapshot.data!
                                        ? kButtonColor
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    snapshot.data!
                                        ? 'Available'
                                        : 'Unavailable',
                                    style: kBody2White,
                                  ),
                                );
                              } else {
                                return Container(); // Return empty container if no data yet
                              }
                            },
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

  Stream<bool> _getDayAvailability(String day) {
    return _firestore
        .collection('lawyers')
        .doc(widget.lawyerId)
        .snapshots()
        .map((snapshot) =>
            (snapshot.data()!['availability'] ?? {})[day] ?? false);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _getUserSchedule() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('lawyers').doc(widget.lawyerId).snapshots();
    }
    throw Exception('User not authenticated');
  }

  final List<String> _weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
}
