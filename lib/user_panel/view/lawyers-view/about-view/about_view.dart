import 'package:catch_case/user_panel/constant-widgets/constant_appbar.dart';
import 'package:catch_case/user_panel/constant-widgets/constant_button.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/lawyer/book_lawyer_screen.dart';
import 'package:catch_case/user_panel/view/lawyers-view/about-view/review_view.dart';
import 'package:catch_case/user_panel/view/lawyers-view/all_lawyers_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../chat-view/chat_screen.dart';
import 'lawyer_schedule.dart';

class AboutView extends StatefulWidget {
  final String image;
  final String name;
  final String category;
  final String experience;
  final String bio;
  final String? fcmToken;
  final String? uid;
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
      this.uid,
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
                    horizontal: Get.width * 0.025, vertical: Get.width * 0.02),
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
                          width: Get.width * 0.16,
                          height: Get.height * 0.01,
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
                      Row(
                        children: [
                          Text(
                            widget.name,
                            style: kHead2Black,
                          ),
                          const Spacer(),
                          // Text(
                          //   '4.7',
                          //   style: kBody1MediumBlue,
                          // ),
                          InkWell(
                            onTap: () => Get.to(() => const ReviewScreen()),
                            child: const Icon(
                              Icons.star,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Area of practice',
                            style: kBody2Black,
                          ),
                          // Text(
                          //   '198 Reviews',
                          //   style: kBody3Grey,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          // Container(
                          //   padding: const EdgeInsets.all(6),
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(6),
                          //       border: Border.all(color: kMediumBlue)),
                          //   child: Text(
                          //     widget.category,
                          //     style: kBody3DarkBlue,
                          //   ),
                          // ),
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
                        ],
                      ),
                      // SizedBox(
                      //   height: Get.height * 0.01,
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(6),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(6),
                      //       border: Border.all(color: kMediumBlue)),
                      //   child: Text(
                      //     widget.category,
                      //     style: kBody3DarkBlue,
                      //   ),
                      // ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Text(
                        'Biography',
                        style: kBody2Black,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        widget.bio ?? '',
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
                        height: Get.height * 0.006,
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
                            widget.experience,
                            style: kBody44DarkBlue,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.006,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.chat,
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
                        height: Get.height * 0.03,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Get.to(() => Chat(
                                      fcmToken: widget.fcmToken,
                                      groupId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      name: widget.name,
                                      image: widget.image,
                                      uid: widget.uid,
                                    ));
                              },
                              child: Container(
                                height: 49,
                                width: Get.width * .4,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Continue chat',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Get.to(() => ScheduleScreen(
                                      lawyerId: widget.uid.toString(),
                                    ));
                              },
                              child: Container(
                                width: Get.width * .4,
                                height: 49,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Availability',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                        child: ConstantButton(
                            buttonText: 'Book now',
                            onTap: () => Get.to(() => LawyerBookingScreen(
                                  lawyerId: widget.uid.toString(),
                                  name: widget.name,
                                  image: widget.image,
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
