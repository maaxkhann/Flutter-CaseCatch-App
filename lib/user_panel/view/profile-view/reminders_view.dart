import 'package:catch_case/user_panel/constant-widgets/constant_appbar.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const ConstantAppBar(text: 'Reminders'),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage:
                            const AssetImage('assets/images/home/person.png'),
                      ),
                      SizedBox(
                        width: 6.r,
                      ),
                      Text(
                        'Adithi Nagaraj',
                        style: kBody1MediumBlue,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.notifications,
                        color: kDarkBlue,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                buildDaysRow(DateTime.now()),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Text(
                  'Upcoming Meetings',
                  style: kBody3DarkBlue,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                FittedBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kButtonColor,
                        radius: 5.r,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        '10:00AM',
                        style: kBody3Black,
                      ),
                      SizedBox(
                        width: Get.width * 0.08,
                      ),
                      Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: const BoxDecoration(
                            color: kButtonColor, shape: BoxShape.rectangle),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Appointment with ',
                              style: kBody3Black,
                              children: [
                            TextSpan(text: 'Rako Christian', style: kBody3Black)
                          ])),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

Widget buildDaysRow(DateTime selectedDate) {
  final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final startDate =
      selectedDate.subtract(Duration(days: selectedDate.weekday - 1));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            7,
            (index) => Text(
              days[(startDate.weekday + index - 1) % 7],
              style: kBody1Black2,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            7,
            (index) {
              final currentDate = startDate.add(Duration(days: index));
              return Text('${currentDate.day}',
                  style: currentDate == selectedDate
                      ? kBody2MediumBlue
                      : kBody2Black);
            },
          ),
        ),
      ),
    ],
  );
}
