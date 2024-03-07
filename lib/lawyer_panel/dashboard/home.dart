import 'package:catch_case/lawyer_panel/controllers/profile_controller.dart';
import 'package:catch_case/lawyer_panel/dashboard/all_schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LawyerProfileController profileController =
      Get.put(LawyerProfileController());
  @override
  Widget build(BuildContext context) {
    User? lawyer = _auth.currentUser;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                        stream: profileController.allLawyers(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return Column(
                              children: snapshot.data?.docs.map((e) {
                                    return Column(
                                      children: [
                                        e["lawyerId"] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 28,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                e['image']),
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Hello ,',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF0C253F),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            e['name'],
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF5A5A5A),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : const SizedBox()
                                      ],
                                    );
                                  }).toList() ??
                                  []);
                        }),
                  ],
                ),
                10.heightBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          cursorColor: Colors.amber,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            focusColor: Colors.amber,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                16.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today\'s Schedule',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const AllScheduleScreen());
                      },
                      child: const Text(
                        "View all",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildAppointmentsStream(lawyer!.uid),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentsStream(String lawyerId) {
    // DateTime now = DateTime.now();
    // DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('lawyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where(
            'date',
            isEqualTo: date,
          )
          .snapshots(),
      //
      //

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 188),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 188),
            child: Center(
              child: Text(
                'You have not any client for today.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.amber),
              ),
            ),
          );
        } else {
//

          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length ?? 0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final appointment = snapshot.data!.docs[index];

                  return Column(
                    children: [
                      Card(
                        shadowColor: Colors.black,
                        color: Colors.white,
                        elevation: 13,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            horizontalTitleGap: 0,
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                appointment['image'],
                              ),
                            ),
                            title: Text(
                              appointment['name'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              '${appointment['date']}  ${appointment['time']}',
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
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
