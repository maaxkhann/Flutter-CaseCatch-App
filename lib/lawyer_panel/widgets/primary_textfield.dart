import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final String text;
  final bool obsecure;
  final TextEditingController controller;

  const PrimaryTextField(
      {super.key,
      required this.prefixIcon,
      required this.controller,
      required this.text, this.suffixIcon, this.obsecure=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.030,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black45, 
          ),
        ), focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black, 
          ),
        ),
        
        hintText: text,
        hintStyle: const TextStyle(
          color: Color(0xFF828A89),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
