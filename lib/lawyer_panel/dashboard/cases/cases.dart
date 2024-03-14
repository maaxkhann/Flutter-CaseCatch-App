import 'package:catch_case/lawyer_panel/dashboard/dashboard.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'case_detail_screen.dart';

class Cases extends StatefulWidget {
  const Cases({super.key});

  @override
  State<Cases> createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.w),
                child: Text('Cases',
                    textAlign: TextAlign.center, style: kHead2Black),
              ),
              16.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Get.height * .108,
                          width: Get.width * .446,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.blue[900],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  5.widthBox,
                                  buildCasesStream('ongoing'),
                                  const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
                                  5.widthBox,
                                ],
                              ),
                              Text('Ongoing', style: kHead2White),
                            ],
                          ),
                        ),
                        Container(
                          height: Get.height * .108,
                          width: Get.width * .446,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  5.widthBox,
                                  buildCasesStream('cancelled'),
                                  const Icon(
                                    Icons.man,
                                    color: Colors.white,
                                  ),
                                  5.widthBox,
                                ],
                              ),
                              Center(
                                child: Text('Cancelled', style: kHead2White),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Get.height * .108,
                          width: Get.width * .446,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  5.widthBox,
                                  buildCasesStream('pending'),
                                  const Icon(
                                    Icons.lock_clock,
                                    color: kWhite,
                                  ),
                                  5.widthBox,
                                ],
                              ),
                              Center(
                                child: Text('Pending', style: kHead2White),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: Get.height * .108,
                          width: Get.width * .446,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.redAccent,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  5.widthBox,
                                  buildCasesStream('completed'),
                                  const Icon(
                                    Icons.done_all,
                                    color: kWhite,
                                  ),
                                  5.widthBox,
                                ],
                              ),
                              Center(
                                child: Text('Completed', style: kHead2White),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    16.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('All cases', style: kHead2Black)),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('lawyers')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('appointments')
                            .orderBy('date', descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: EdgeInsets.only(top: 140.h),
                              child: const CircularProgressIndicator(),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 166),
                              child: Text('You have not any client yet',
                                  textAlign: TextAlign.center,
                                  style: kBody1Black),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length ?? 0,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data['date'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500)),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => CaseDetailScreen(
                                                name: data['name'],
                                                cnic: data['cnic'],
                                                time: data['time'],
                                                date: data['date'],
                                                caseType: data['caseType'],
                                                status: data['status'],
                                                userId: data['userId'],
                                                caseId: data['caseId'],
                                                userCaseId: data['userCaseId'],
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.h, horizontal: 12.w),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 6.h),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.black38),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                          ),
                                          child: Row(children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Cnic no ',
                                                        style: kBody3Grey),
                                                    Text(':  ${data['cnic']}',
                                                        style: kBody3Black),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Case Type ',
                                                        style: kBody3Grey),
                                                    Text(
                                                        ': ${data['caseType']}',
                                                        style: kBody3Black),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Client name ',
                                                        style: kBody3Grey),
                                                    Text(': ${data['name']}',
                                                        style: kBody3Black),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  deleteAppointment(
                                                      context, data['caseId']);
                                                },
                                                icon: const Icon(Icons.delete))
                                          ]),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCasesStream(String status) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('appointments')
          // .where('lawyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('status', isEqualTo: status)
          .snapshots(),
      builder: (context, snapshot) {
        return Text(snapshot.data?.docs.length.toString() ?? '',
            style: kHead1White);
      },
    );
  }

  void deleteAppointment(context, var id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('lawyers')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('appointments')
                    .doc(id)
                    .delete()
                    .then((value) {
                  Fluttertoast.showToast(msg: 'Deleted');
                  Navigator.of(context).pop();
                });
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
