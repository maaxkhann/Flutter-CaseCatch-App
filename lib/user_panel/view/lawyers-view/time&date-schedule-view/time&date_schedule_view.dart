
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant-widgets/constant_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/textstyles.dart';
import '../all_lawyers_view.dart';
import '../confirm-booking-view/confirm_booking_view.dart';
import '../widgets/booking_appbar.dart';

class TimeScheduleView extends StatefulWidget {
  const TimeScheduleView({Key? key}) : super(key: key);

  @override
  State<TimeScheduleView> createState() => _TimeScheduleViewState();
}

class _TimeScheduleViewState extends State<TimeScheduleView> {
  DateTime? dateTime = DateTime.now();
  final ValueNotifier<DateTime?> selectedDateNotifier =
      ValueNotifier<DateTime?>(DateTime.now());
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BookingAppBar(text: 'Lawyer'),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Select date',
                  style: kHead2Black,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ValueListenableBuilder<DateTime?>(
                  valueListenable: selectedDateNotifier,
                  builder: (context, selectedDate, _) {
                    return datePicker();
                  },
                ),
                Text(
                  'Select Time',
                  style: kHead2Black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    timeContainer('08:00 AM', false),
                    timeContainer('08:00 AM', false),
                    timeContainer('08:00 AM', false),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    timeContainer('08:00 AM', false),
                    timeContainer('08:00 AM', false),
                    timeContainer('08:00 AM', false),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: ConstantButton(
                      buttonText: 'Book now for free',
                      onTap: () => showQuestionsDialog()),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => Get.off(() => const AllLawyersView()),
                      child: Text(
                        'Back to search',
                        style: kBody1MediumBlue,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget datePicker() {
    return DaysPicker(
      minDate: DateTime(2024, 1, 1),
      maxDate: DateTime(2025, 5, 5),
      onDateSelected: (value) {
        dateTime = value;
        setState(() {});
      },
    );
  }

  Widget timeContainer(String time, bool isSelected) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: Get.height * 0.045,
        width: Get.width * 0.25,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kDarkBlue)),
        child: Center(
          child: Text(
            time,
            style: TextStyle(color: isSelected ? Colors.grey : Colors.black),
          ),
        ),
      ),
    );
  }

  void showQuestionsDialog() {
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
                    onPressed: () {
                      setState(() {
                        if (currentStep < (questionSets?.length ?? 0) - 1) {
                          currentStep++;
                        } else {
                          currentStep = 0;
                          allControllers[currentStep]
                              .forEach((controller) => controller.clear());
                          Navigator.of(context).pop();
                          Get.to(() => const ConfirmBookingView());
                        }
                      });
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
}
