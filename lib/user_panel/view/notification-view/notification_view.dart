import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/notification-view/widgets/cancelled_notifications.dart';
import 'package:catch_case/user_panel/view/notification-view/widgets/completed_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kButtonColor,
              centerTitle: true,
              title: Text(
                'Notifications',
                style: kBody1White,
              )),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                  labelColor: kDarkBlue,
                  unselectedLabelColor: kMediumBlue,
                  indicatorColor: kDarkBlue,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const Expanded(
                    child: TabBarView(children: [
                  SingleChildScrollView(child: CasesTab(status: 'ongoing')),
                  SingleChildScrollView(
                    child: CasesTab(
                      status: 'completed',
                    ),
                  ),
                  SingleChildScrollView(child: CasesTab(status: 'cancelled')),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CasesTab extends StatelessWidget {
  final String status;
  const CasesTab({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('status', isEqualTo: status)
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 188),
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 188),
            child: Text(
              'You have not any $status cases yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.amber.shade700),
            ),
          );
        } else {
          return Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length ?? 0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final appointment = snapshot.data!.docs[index];

                  return Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: Get.width * .17,
                                    height: Get.height * .08,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            appointment['lawyerImage']),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: Get.width * 0.03),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          appointment['lawyerName'],
                                          style: kBody1Black,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.date_range,
                                              color: kMediumBlue,
                                            ),
                                            Text(
                                              ' ${appointment['date']}  |  ${appointment['time']} ',
                                              style: kBody4Black,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '4.7',
                                    style: kBody2MediumBlue,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.008,
                              ),
                              Text(
                                'Area of practice',
                                style: kBody3DarkBlue,
                              ),
                              Row(
                                children: [
                                  Text(
                                    appointment['caseType'],
                                    style: kBody5DarkBlue,
                                  ),
                                  const Spacer(),
                                  // LawyersButton(
                                  //     buttonText: 'Message',
                                  //     buttonColor: kButtonColor,
                                  //     onTap: () => Get.to(() => const ChatView()))
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
