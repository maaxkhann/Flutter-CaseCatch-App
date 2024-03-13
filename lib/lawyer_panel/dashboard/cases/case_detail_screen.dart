import 'package:catch_case/lawyer_panel/controllers/profile_controller.dart';
import 'package:catch_case/lawyer_panel/dashboard/cases/questions_screen.dart';
import 'package:catch_case/user_panel/constant-widgets/constant_button.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CaseDetailScreen extends StatefulWidget {
  final String name;
  final String cnic;
  final String time;
  final String date;
  final String caseType;
  final String? status;
  final String userId;
  final String caseId;
  final String? userCaseId;
  const CaseDetailScreen(
      {super.key,
      required this.name,
      required this.cnic,
      required this.time,
      required this.date,
      required this.caseType,
      this.status,
      required this.caseId,
      required this.userId,
      this.userCaseId});

  @override
  State<CaseDetailScreen> createState() => _CaseDetailScreenState();
}

class _CaseDetailScreenState extends State<CaseDetailScreen> {
  LawyerProfileController profileController =
      Get.put(LawyerProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios)),
                    SizedBox(
                      width: Get.width * 0.13,
                    ),
                    Text('Case details',
                        textAlign: TextAlign.center, style: kHead2Black),
                  ],
                ),
                10.heightBox,
                Text('Petitoner & advocate', style: kBody1Black2),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black38),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Petitioner name :  ',
                                style: kBody2MediumBlue),
                            Text(
                              widget.name,
                              style: kBody2Black,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          children: [
                            Text('Cnic number :  ', style: kBody2MediumBlue),
                            Text(widget.cnic, style: kBody2Black),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          children: [
                            Text('Date :  ', style: kBody2MediumBlue),
                            Text(widget.date, style: kBody2Black),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          children: [
                            Text('Time :  ', style: kBody2MediumBlue),
                            Text(widget.time, style: kBody2Black),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          children: [
                            Text('Case Type :  ', style: kBody2MediumBlue),
                            Text(widget.caseType, style: kBody2Black),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Text('Status :  ', style: kBody2MediumBlue),
                            Text(widget.status.toString(), style: kBody2Black),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                ConstantButton(
                    buttonText: 'Show Questions',
                    onTap: () {
                      Get.to(() => QuestionsScreen(userId: widget.userId));
                    }),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      updateCaseStatus('completed');
                      // profileController.updateCaseStatus(
                      //     status: 'completed',
                      //     caseId: widget.caseId.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.all(14.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('Completed',
                            textAlign: TextAlign.center, style: kBody1White),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      updateCaseStatus('pending');
                      // profileController.updateCaseStatus(
                      //     status: 'pending', caseId: widget.caseId.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.all(14.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('Pending',
                            textAlign: TextAlign.center, style: kBody1White),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      updateCaseStatus('cancelled');
                      // profileController.updateCaseStatus(
                      //     status: 'cancelled',
                      //     caseId: widget.caseId.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.all(14.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text('Cancelled',
                            textAlign: TextAlign.center, style: kBody1White),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateCaseStatus(String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('appointments')
          .doc(widget.userCaseId)
          .update({'status': status});
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('appointments')
          .doc(widget.caseId)
          .update({'status': status});
      Fluttertoast.showToast(msg: 'Status Updated');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
}
