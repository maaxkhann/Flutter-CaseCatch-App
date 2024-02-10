import 'package:catch_case/view/payment-view/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/textstyles.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  SfRangeValues sliderValues = const SfRangeValues(50, 2000);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SfRangeSlider currentRangeValues = SfRangeSlider(
        values: sliderValues,
        onChanged: (value) {
          sliderValues = value;
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.1,
                child: appBar(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: kBody1Black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: Get.height * 0.03,
                        width: Get.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                        child: const Center(child: Text('Lowest')),
                      ),
                      SizedBox(width: Get.width * 0.01),
                      Container(
                        height: Get.height * 0.03,
                        width: Get.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                        child: const Center(child: Text('Highest')),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              rangeSLider(),
              SizedBox(height: Get.height * 0.02),
              divider(),
              SizedBox(height: Get.height * 0.02),
              Text(
                'Ratings',
                style: kBody1Black,
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                children: [
                  ratingContainer(5),
                  ratingContainer(4),
                  ratingContainer(3),
                  ratingContainer(2),
                  ratingContainer(1),
                ],
              ),
              SizedBox(height: Get.height * 0.01),
              divider(),
              SizedBox(height: Get.height * 0.01),
              Text(
                'Area of Practice',
                style: kBody1Black,
              ),
              SizedBox(height: Get.height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customButton(() {}, 'Go to all lawyers list'),
                ],
              ),
              SizedBox(height: Get.height * 0.01),
              divider(),
              SizedBox(height: Get.height * 0.01),
              Text(
                'Years of Experience',
                style: kBody1Black,
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                children: [
                  experienceContainer('1-3 Years'),
                  experienceContainer('4-7 Years'),
                  experienceContainer('8-10 Years'),
                  experienceContainer('11+ Years'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Text(
            "Cancel",
            style: kBody2Black,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: Get.height * 0.008,
              width: Get.width * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.black),
            ),
            const Text(
              "Filters",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const PaymentScreen());
          },
          child: Text(
            "Apply",
            style: kBody2Black,
          ),
        ),
      ],
    );
  }

  Widget rangeSLider() {
    return SfRangeSlider(
      activeColor: Colors.blue.shade500,
      min: 50,
      max: 2000,
      values: sliderValues,
      interval: 400,
      showLabels: true,
      onChanged: (SfRangeValues value) {
        setState(() {
          sliderValues = value;
        });
      },
    );
  }

  Widget divider() {
    return Divider(
      thickness: 1,
      color: Colors.grey.shade300,
    );
  }

  Widget ratingContainer(double rating) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: Get.height * 0.03,
      width: Get.width * 0.15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.blue.shade100),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.star,
            size: 20,
          ),
          Text("$rating+")
        ],
      )),
    );
  }

  Widget customButton(VoidCallback onTap, String buttonText) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.5,
        height: Get.height * 0.04,
        decoration: BoxDecoration(
            color: kButtonColor,
            borderRadius: BorderRadius.circular(Get.width * 0.02)),
        child: Center(
          child: Text(
            buttonText,
            style: kBody22LightBlue,
          ),
        ),
      ),
    );
  }

  Widget experienceContainer(String experience) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: Get.height * 0.03,
      width: Get.width * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.blue.shade100),
      child: Center(child: Text(experience)),
    );
  }
}
