import 'package:catch_case/constant-widgets/constant_appbar.dart';
import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/home-view/user_questions_view.dart';
import 'package:catch_case/user_panel/view/lawyers-view/all_lawyers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutView extends StatefulWidget {
  final String image;
  final String name;
  final String category;
  final String experience;
  final String bio;
  final String? fcmToken;
  final String lawyerId;
  final String address;
  final String contact;
  final String practice;

  const AboutView(
      {super.key,
      required this.image,
      required this.name,
      required this.category,
      required this.experience,
      required this.bio,
      this.fcmToken,
      required this.lawyerId,
      required this.address,
      required this.contact,
      required this.practice});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ConstantAppBar(text: 'About'),
        body: Stack(
          children: [
            Image.network(
              widget.image,
              height: Get.height * 0.5,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.026, vertical: Get.height * 0.01),
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Get.width * 0.06),
                        topRight: Radius.circular(Get.width * 0.06))),
                width: double.infinity,
                height: Get.height * 0.58,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: Get.width * 0.14,
                          height: Get.height * 0.008,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Get.width * 0.04,
                              ),
                              color: kBlack),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Text(
                        widget.name,
                        style: kHead2Black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Area of practice',
                            style: kBody2Black,
                          ),
                          Text(
                            'Category',
                            style: kBody2Black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: kMediumBlue)),
                            child: Text(
                              widget.practice,
                              style: kBody3DarkBlue,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: kMediumBlue)),
                            child: Text(
                              widget.category,
                              style: kBody3DarkBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Text(
                        'Biography',
                        style: kBody2Black,
                      ),
                      Text(
                        widget.bio,
                        style: kBody3DarkBlue,
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: kMediumBlue,
                          ),
                          SizedBox(
                            width: Get.width * 0.012,
                          ),
                          Text(
                            widget.address,
                            style: kBody44DarkBlue,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.008,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.content_paste,
                            color: kMediumBlue,
                          ),
                          SizedBox(
                            width: Get.width * 0.012,
                          ),
                          Text(
                            '${widget.experience} years',
                            style: kBody44DarkBlue,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.008,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.call,
                            color: kMediumBlue,
                          ),
                          SizedBox(
                            width: Get.width * 0.012,
                          ),
                          Text(
                            widget.contact,
                            style: kBody44DarkBlue,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.07,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                        child: ConstantButton(
                            buttonText: 'Question now',
                            onTap: () => Get.to(() => QuestionsView(
                                  lawyerId: widget.lawyerId,
                                  token: widget.fcmToken,
                                ))),
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () =>
                                Get.off(() => const AllLawyersView()),
                            child: Text(
                              'Back to search',
                              style: kBody1MediumBlue,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
