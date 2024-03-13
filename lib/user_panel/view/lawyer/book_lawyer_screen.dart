import 'package:catch_case/user_panel/view/lawyer/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../lawyer_panel/widgets/primary_textfield.dart';
import '../../constants/textstyles.dart';
import '../lawyers-view/confirm-booking-view/confirm_booking_view.dart';

class LawyerBookingScreen extends StatefulWidget {
  final String lawyerId;
  final String name;
  final String image;
  const LawyerBookingScreen(
      {super.key,
      required this.lawyerId,
      required this.name,
      required this.image});

  @override
  State<LawyerBookingScreen> createState() => _LawyerBookingScreenState();
}

class _LawyerBookingScreenState extends State<LawyerBookingScreen> {
  int currentStep = 0;
  List<TextEditingController>? controllers;
  List<List<String>>? questionSets = [
    [
      'Have you been arrested before',
      'How are you feeling at the moment?',
      'Would you want anything else?',
      'Have you seen the custody nurse?',
      'Question 5',
      'Question 6',
      'Question 7'
    ],
    [
      'I have been here for ages, how long can the police keep me here?',
      'Will i get bail?',
      'Do you reckon i will get charged for this?',
      'Will i be able to get my phone back?',
      'Am i able to call my brother, sister, wife, girlfriend etc?',
      'What\'s going to happen after the interview?',
      'How long will it take for a disposal decision to be made?'
    ],
    [
      'Question 1C',
      'Question 2C',
      'Question 3C',
      'Question 4C',
      'Question 5C',
      'Question 6C',
      'Question 7C'
    ],
    [
      'Question 1D',
      'Question 2D',
      'Question 3D',
      'Question 4D',
      'Question 5D',
      'Question 6D',
      'Question 7D'
    ],
  ];

  @override
  void dispose() {
    controllers?.forEach((controller) => controller.dispose());
    super.dispose();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController caseTypeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void bookAppointment({
    required String caseType,
    required String cnic,
    required String name,
    required String date,
    required String time,
  }) async {
    try {
      EasyLoading.show(status: 'Processing');
      User? user = _auth.currentUser;
      String uid = user!.uid;
      var uuid = const Uuid();
      var myId = uuid.v6();
      DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final data = document.data()!;
      String userName = data['username'];
      String image = data['image'];
      //
      //
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(myId)
          .set({
        'caseId': myId,
        'userId': uid,
        'lawyerId': widget.lawyerId,
        'lawyerImage': widget.image,
        'lawyerName': widget.name,
        'name': userName,
        'image': image,
        'caseType': caseType,
        'cnic': cnic,
        'date': date,
        'time': time,
        'status': 'ongoing',
      });

      showQuestionsDialog(uid);
      Fluttertoast.showToast(msg: 'Booking successful');

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();

      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              44.heightBox,
              Row(children: [
                InkWell(
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
                SizedBox(width: Get.width * .2),
                const Text(
                  'Book a lawyer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
              55.heightBox,
              const Text(
                'Case type',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              PrimaryTextField(
                  controller: caseTypeController,
                  text: 'Case type',
                  prefixIcon: const Icon(
                    Icons.type_specimen,
                    size: 22,
                  )),
              10.heightBox,
              const Text(
                'Cnic No.',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: cnicController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.030,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Your cnic",
                  focusColor: Colors.black,
                  hintStyle: const TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.email_rounded,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              10.heightBox,
              const Text(
                'Select date',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              DatePicker(controller: dateController),
              10.heightBox,
              const Text(
                'Select a time',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: timeController,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.030,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Select a time",
                  focusColor: Colors.black,
                  hintStyle: const TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.watch_later,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      timeController.text = picked.format(context);
                    });
                  }
                },
              ),
              SizedBox(height: Get.height * .33),
              GestureDetector(
                onTap: () async {
                  String name = nameController.text.trim();
                  String date = dateController.text.trim();
                  String time = timeController.text.trim();
                  String caseType = caseTypeController.text.trim();
                  String cnic = cnicController.text.trim();
                  //
                  //

                  if (caseType.isEmpty || date.isEmpty || time.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter all details');
                  } else {
                    bookAppointment(
                        caseType: caseType,
                        cnic: cnic,
                        date: date,
                        time: time,
                        name: name);
                  }

                  // caseTypeController.clear();
                  // timeController.clear();
                  // dateController.clear();
                },
                child: Container(
                  height: 49,
                  width: Get.size.width,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Book Appointment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showQuestionsDialog(String uid) async {
    if (currentStep < (questionSets?.length ?? 0)) {
      List<List<TextEditingController>> allControllers = List.generate(
          questionSets!.length,
          (_) => List.generate(7, (_) => TextEditingController()));

      List<List<String>> enteredValues = List.generate(
          questionSets!.length, (_) => List.filled(7, '', growable: false));

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  'Common questions',
                  style: kBody1Black,
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < 7; i++)
                        ExpansionTile(
                          title: Text(questionSets![currentStep][i]),
                          children: [
                            TextField(
                              controller: allControllers[currentStep][i],
                              onChanged: (value) {
                                enteredValues[currentStep][i] = value;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter your answer',
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      bool isEmpty = enteredValues[currentStep]
                          .any((value) => value.isEmpty);

                      if (isEmpty) {
                        Fluttertoast.showToast(msg: 'Please fill all fields');
                      } else {
                        setState(() {
                          if (currentStep < (questionSets?.length ?? 0) - 1) {
                            currentStep++;
                          } else {
                            currentStep = 0;
                            allControllers[currentStep]
                                .forEach((controller) => controller.clear());
                            Get.back();
                            storeQuestionsAndAnswers(
                                enteredValues, questionSets!, uid);
                          }
                        });
                      }
                    },
                    child: Text(currentStep < (questionSets?.length ?? 0) - 1
                        ? 'Next'
                        : 'Finish'),
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      currentStep = 0;
      controllers?.forEach((controller) => controller.clear());
      Get.to(() => const ConfirmBookingView());
    }
  }

  void storeQuestionsAndAnswers(List<List<String>> enteredValues,
      List<List<String>> questions, String uid) async {
    try {
      EasyLoading.show(status: 'Storing Data');
      var uuid = const Uuid();

      for (int i = 0; i < questions.length; i++) {
        var myId = uuid.v6();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('questions')
            .doc(myId)
            .set({
          'questions': questions[i],
          'answers': enteredValues[i],
        });
      }

      Fluttertoast.showToast(msg: 'Successful');
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
}
