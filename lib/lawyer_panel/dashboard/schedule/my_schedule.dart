import 'package:catch_case/lawyer_panel/dashboard/schedule/add_schedule.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySchedule extends StatefulWidget {
  final String lawyerId;
  const MySchedule({super.key, required this.lawyerId});

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
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
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
            ),
          ],
        ),
        centerTitle: true,
        title: const Text(
          'Availability',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.to(() => const AddScheduleScreen());
              },
              child: const Text("Add schedule"))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getUserSchedule(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No schedule found.'));
          }

          Map<String, dynamic> lawyerData =
              snapshot.data!.data() as Map<String, dynamic>;
          Map<String, dynamic> lawyerSchedule = lawyerData['schedule'] ?? Map();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const Divider(),
                Text(lawyerData['available'] ?? ''),
                for (var day in lawyerSchedule.keys)
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        day,
                        style: const TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    subtitle: Row(
                      children: [
                        for (var hour in lawyerSchedule[day]!)
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 5),
                              decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                  child: Text(
                                hour + '  ',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )),
                            ),
                          )
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserSchedule() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await _firestore.collection('lawyers').doc(widget.lawyerId).get();
    }
    throw Exception('User ont authenticated');
  }
}
