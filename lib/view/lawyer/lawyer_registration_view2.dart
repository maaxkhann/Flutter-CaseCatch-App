import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyer/lawyer_home_view.dart';
import 'package:catch_case/view/lawyer/widgets/multi_select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LawyerRegistrationView2 extends StatefulWidget {
  const LawyerRegistrationView2({super.key});

  @override
  State<LawyerRegistrationView2> createState() =>
      _LawyerRegistrationView2State();
}

class _LawyerRegistrationView2State extends State<LawyerRegistrationView2> {
  List<String> selectedCategories = [];
  List<String> selectedPracticeAreas = [];
  List<String> selectedLanguages = [];
  List<String> categories = [
    'Family Lawyer',
    'Tax Lawyer',
    'Divorce Lawyer',
    'Criminal Lawyer',
  ];

  List<String> practiceAreas = [
    'Family matters',
    'Corporate buisness',
    'Immigration case',
    'Tax case'
  ];

  List<String> languages = ['English', 'Urdu', 'Hindi', 'Kannada'];

  void showMultiSelect(List<String> items, List<String> selectedItems) async {
    final List<String>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(items: items, selectedItems: selectedItems);
      },
    );
    if (result != null) {
      setState(() {
        if (items == categories) {
          selectedCategories = result;
        } else if (items == practiceAreas) {
          selectedPracticeAreas = result;
        } else {
          selectedLanguages = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04,
            vertical: Get.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Catch',
                    style: kHead1DarkBlue,
                    children: [
                      TextSpan(text: 'Case', style: kHead1MediumBlue),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Register yourself as Lawyer',
                  style: kHead2Black,
                  maxLines: 2,
                ),
              ),
              Center(
                child: Text(
                  '1/2',
                  style: kBody1Black,
                ),
              ),
              GestureDetector(
                onTap: () => showMultiSelect(categories, selectedCategories),
                child: Container(
                  margin: EdgeInsets.only(top: 15.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Text(
                    'Choose Category',
                    style: kBody1Black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    showMultiSelect(practiceAreas, selectedPracticeAreas),
                child: Container(
                  margin: EdgeInsets.only(top: 15.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Text(
                    'Choose Area of practices',
                    style: kBody1Black,
                  ),
                ),
              ),
              InkWell(
                onTap: () => showMultiSelect(languages, selectedLanguages),
                child: Container(
                  margin: EdgeInsets.only(top: 15.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Text(
                    'Choose Languages',
                    style: kBody1Black,
                  ),
                ),
              ),
              const Spacer(),
              ConstantButton(
                  buttonText: 'Submit',
                  onTap: () => Get.to(() => const LawyerHomeView()))
            ],
          ),
        ),
      ),
    );
  }
}
