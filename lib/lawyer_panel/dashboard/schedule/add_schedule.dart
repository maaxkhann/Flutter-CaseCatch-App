import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({Key? key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  Map<String, bool> lawyerAvailability = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              44.heightBox,
              Row(
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: Get.width * 0.15,
                  ),
                  Text('Availability',
                      textAlign: TextAlign.center, style: kHead2Black),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    const Text(
                      'Set your availability',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: _getUserSchedule(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.data() == null) {
                          return const Center(
                              child: Text('No schedule found.'));
                        }

                        Map<String, dynamic> lawyerData =
                            snapshot.data!.data()!;
                        Map<String, dynamic> lawyerSchedule =
                            (lawyerData['availability']
                                    as Map<String, dynamic>) ??
                                {};

                        return Column(
                          children: [
                            for (var day in lawyerAvailability.keys)
                              ListTile(
                                title: Text(day),
                                trailing: Checkbox(
                                  value: lawyerSchedule[day] ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      lawyerAvailability[day] = value ?? false;
                                    });
                                    _updateAvailability(day, value ?? false);
                                  },
                                ),
                              ),
                            SizedBox(
                              height: 14.h,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  await saveLawyerSchedule();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(14.r),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text('Save Changes',
                                        textAlign: TextAlign.center,
                                        style: kBody1White),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveLawyerSchedule() async {
    try {
      EasyLoading.show(status: 'Processing');
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('lawyers')
            .doc(user.uid)
            .set({'availability': lawyerAvailability}, SetOptions(merge: true));
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Availability saved successfully!');
      }
    } catch (error) {
      EasyLoading.dismiss();

      Get.snackbar('Error', error.toString());
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _getUserSchedule() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('lawyers').doc(user.uid).snapshots();
    } else {
      throw Exception('User not authenticated');
    }
  }

  Future<void> _updateAvailability(String day, bool availability) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('lawyers').doc(user.uid).update({
          'availability.$day': availability,
        });
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to update availability');
    }
  }
}
