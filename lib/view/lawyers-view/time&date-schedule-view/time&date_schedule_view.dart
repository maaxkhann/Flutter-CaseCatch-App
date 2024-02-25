import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyers-view/all_lawyers_view.dart';
import 'package:catch_case/view/lawyers-view/widgets/booking_appbar.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant-widgets/constant_button.dart';
import '../confirm-booking-view/confirm_booking_view.dart';

class TimeScheduleView extends StatefulWidget {
  const TimeScheduleView({Key? key}) : super(key: key);

  @override
  State<TimeScheduleView> createState() => _TimeScheduleViewState();
}

class _TimeScheduleViewState extends State<TimeScheduleView> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<DateTime> selectedDateNotifier =
        ValueNotifier<DateTime>(DateTime.now());

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
                ValueListenableBuilder<DateTime>(
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
                      onTap: () => Get.to(() => const ConfirmBookingView())),
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
        // Handle selected date
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
}
