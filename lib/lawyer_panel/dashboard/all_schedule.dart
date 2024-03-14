import 'package:catch_case/user_panel/constant-widgets/constant_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cases/case_detail_screen.dart';

class AllScheduleScreen extends StatefulWidget {
  const AllScheduleScreen({super.key});

  @override
  State<AllScheduleScreen> createState() => _AllScheduleScreenState();
}

class _AllScheduleScreenState extends State<AllScheduleScreen> {
  String searchText = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConstantAppBar(text: 'All Appointments'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 48,
                width: Get.size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7F9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: searchController,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    prefixIcon: (searchText.isEmpty)
                        ? const Icon(Icons.search)
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchText = '';
                              searchController.clear();
                              setState(() {});
                            },
                          ),
                    hintText: 'Search by name',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 29),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('lawyers')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('appointments')
                    .orderBy('date')
                    .snapshots(),
                //  .orderBy('date')
                //  .startAt([searchText.toUpperCase()]).endAt(
                //     ['$searchText\uf8ff']).snapshots(),

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
                    return Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            final appointment = snapshot.data!.docs[index];

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => CaseDetailScreen(
                                          name: appointment['name'],
                                          cnic: appointment['cnic'],
                                          time: appointment['time'],
                                          date: appointment['date'],
                                          caseType: appointment['caseType'],
                                          status: appointment['status'],
                                          userId: appointment['userId'],
                                          caseId: appointment['caseId'],
                                          userCaseId: appointment['userCaseId'],
                                        ));
                                  },
                                  child: Card(
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
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
