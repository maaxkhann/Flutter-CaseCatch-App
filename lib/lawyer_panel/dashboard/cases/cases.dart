import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      icon: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * .3),
                    const Text(
                      'Cases',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
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
                            borderRadius: BorderRadius.circular(12),
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
                              const Text(
                                'Ongoing',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
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
                              const Center(
                                child: Text(
                                  'Cancelled',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
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
                                    color: Colors.white,
                                  ),
                                  5.widthBox,
                                ],
                              ),
                              const Center(
                                child: Text(
                                  'Pending',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
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
                                    color: Colors.white,
                                  ),
                                  5.widthBox,
                                ],
                              ),
                              const Center(
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    16.heightBox,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All cases',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // Text(
                        //   "View all",
                        //   style: TextStyle(
                        //     color: Colors.amber,
                        //     fontSize: 13,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('appointments')
                            .where('lawyerId',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .orderBy('date', descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 99),
                              child: CircularProgressIndicator(),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 166),
                              child: Text(
                                'You have not any client yet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.amber.shade700),
                              ),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length ?? 0,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];

                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => CaseDetailScreen(
                                                name: data['name'],
                                                cnic: data['cnic'],
                                                time: data['time'],
                                                date: data['date'],
                                                caseType: data['caseType'],
                                                status: data['status'],
                                                caseId: data['caseId'],
                                              ));
                                        },
                                        child: Container(
                                          width: Get.size.width,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 12),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          height: Get.height * .12,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.black38),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              // Image.asset(
                                              //   'assets/images/case.png',
                                              // ),
                                              // const SizedBox(
                                              //   width: 12,
                                              // ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Cnic no.  ',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Text(
                                                        ':  ${data['cnic']}',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Case Type ',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Text(
                                                        ': ${data['caseType']}',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Client name ',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Text(
                                                        ': ${data['name']}',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
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
          .collection('appointments')
          .where('lawyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('status', isEqualTo: status)
          .snapshots(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Text(
              snapshot.data?.docs.length.toString() ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
