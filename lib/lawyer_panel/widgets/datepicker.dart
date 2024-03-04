import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime dateTime)? onDateChanged;
  final DateTime? initialDate;

  const DatePicker({
    Key? key,
    this.onDateChanged,
    this.initialDate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    _dateTime = widget.initialDate ?? DateTime.now();
    super.initState();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2055))
        .then((value) => setState(() {
              if (value != null) {
                _dateTime = value;
                if (widget.onDateChanged != null) {
                  widget.onDateChanged!(_dateTime);
                }
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            height: Get.height * 0.045,
            width: Get.width * 0.08,
            decoration: ShapeDecoration(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: IconButton(
                padding: const EdgeInsets.only(right: 1),
                onPressed: () {
                  _dateTime = _dateTime.subtract(const Duration(days: 1));
                  if (widget.onDateChanged != null) {
                    widget.onDateChanged!(_dateTime);
                  }

                  setState(() {});
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined))),
        Container(
          height: Get.height * 0.045,
          width: Get.width * .7,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(8)),
          child: GestureDetector(
            onTap: () {
              _showDatePicker();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.date_range_outlined),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(_dateTime),
                  semanticsLabel: _dateTime.toString(),
                ),
              ],
            ),
          ),
        ),
        Container(
            width: Get.width * 0.08,
            height: Get.height * 0.045,
            decoration: ShapeDecoration(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: IconButton(
                padding: const EdgeInsets.only(right: 1),
                onPressed: () {
                  _dateTime = _dateTime.add(const Duration(days: 1));
                  if (widget.onDateChanged != null) {
                    widget.onDateChanged!(_dateTime);
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.arrow_forward_ios_outlined))),
      ],
    );
  }
}
