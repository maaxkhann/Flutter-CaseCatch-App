import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;
  const DatePicker({super.key, required this.controller});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
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
        hintText: "Select a date",
        focusColor: Colors.black,
        hintStyle: const TextStyle(
          color: Color(0xFF828A89),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: const Icon(
          Icons.calendar_today_rounded,
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
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            widget.controller.text =
                DateFormat('dd-MM-yyyy').format(pickedDate);
          });
        }
      },
    );
  }
}
