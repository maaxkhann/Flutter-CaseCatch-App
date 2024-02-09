import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyers-view/time&date-schedule-view/widgets/booking_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class TimeScheduleView extends StatelessWidget {
  const TimeScheduleView({Key? key}) : super(key: key);

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
          child: ListView(
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
                  return buildWeekDatePicker(
                    selectedDate: selectedDate,
                    firstAllowedDate: selectedDate,
                    lastAllowedDate: selectedDate,
                    onNewSelected: (value) {
                      selectedDateNotifier.value = value.start;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Update the buildWeekDatePicker function signature to accept selectedDate
Widget buildWeekDatePicker({
  required DateTime selectedDate,
  required DateTime firstAllowedDate,
  required DateTime lastAllowedDate,
  required ValueChanged<DatePeriod> onNewSelected,
}) {
  // add some colors to default settings
  DatePickerRangeStyles styles = DatePickerRangeStyles(
    selectedPeriodLastDecoration: const BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(10.0),
        bottomEnd: Radius.circular(10.0),
      ),
    ),
    selectedPeriodStartDecoration: const BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(10.0),
        bottomStart: Radius.circular(10.0),
      ),
    ),
    selectedPeriodMiddleDecoration: const BoxDecoration(
      color: Colors.yellow,
      shape: BoxShape.rectangle,
    ),
  );

  return WeekPicker(
    selectedDate: selectedDate,
    onChanged: onNewSelected,
    firstDate: firstAllowedDate,
    lastDate: lastAllowedDate,
    datePickerStyles: styles,
  );
}
