import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/auth_controller.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen>
     {
  LawyerAuthController authController = Get.put(LawyerAuthController());
  Map<String, List<String>> lawyerSchedule = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
    'Sunday': [],
  };
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  bool addSchedule = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
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
                              'Add hours of your availability',
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            for (var day in lawyerSchedule.keys)
                              ListTile(
                                title: Text(day),
                                // subtitle: Flexible(
                                //   fit: FlexFit.loose,
                                //   child: Row(
                                //     children: [
                                //       for (var hour in lawyerSchedule[day]!)
                                //         Expanded(
                                //             child: Container(
                                //           height: 66,
                                //           child: Text(
                                //             '$hour  ',
                                //             maxLines: 8,
                                //           ),
                                //         )),
                                //     ],
                                //   ),
                                // ),
                                trailing: ElevatedButton(
                                  onPressed: () async {
                                    await _selectHours(day);
                                  },
                                  child: const Text('Select Hours'),
                                ),
                              ),
                            SizedBox(
                              height: 14.h,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  await saveLawyerSchedule();
                                  await updateSchedule();
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
                        ),
                      ),
              ],
            )));
  }

  Future<void> _selectHours(String day) async {
    List<String> selectedHours = await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> availableHours =
            List.generate(12, (index) => '${index + 1} AM') +
                List.generate(12, (index) => '${index + 1} PM');

        List<String> selectedHours = [];

        return AlertDialog(
          title: Text(
            'Select Available Hours for $day',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Container(
            height: Get.height * 0.5,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var hour in availableHours)
                        SwitchListTile(
                          title: Text(hour),
                          value: selectedHours.contains(hour),
                          onChanged: (value) {
                            setState(() {
                              if (value) {
                                selectedHours.add(hour);
                              } else {
                                selectedHours.remove(hour);
                              }
                            });
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, selectedHours);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (selectedHours != null) {
      setState(() {
        lawyerSchedule[day] = selectedHours;
      });
      // await saveLawyerSchedule();
    }
  }

  Future<void> saveLawyerSchedule() async {
    try {
      EasyLoading.show(status: 'Processing');
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('lawyers')
            .doc(user.uid)
            .set({'schedule': lawyerSchedule}, SetOptions(merge: true));
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Schedule saved successfully!');
      }
    } catch (error) {
      EasyLoading.dismiss();

      print('Error saving schedule: $error');
      Get.snackbar('Error', error.toString());
    }
  }

  //
  //
  Future<void> updateSchedule() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('lawyers')
            .doc(user.uid)
            .update({'schedule': lawyerSchedule});
        Fluttertoast.showToast(msg: 'Schedule updated successfully!');
      }
    } catch (error) {
      print('Error saving schedule: $error');
      Get.snackbar('Error', error.toString());
    }
  }
}

