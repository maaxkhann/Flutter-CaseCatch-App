import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyers-view/time&date-schedule-view/time&date_schedule_view.dart';
import 'package:catch_case/view/lawyers-view/widgets/lawyers_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const LawyersAppBar(text: 'About'),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/lawyer/lawyer.png',
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
                height: Get.height * 0.65,
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
                            'Rako Christian',
                            style: kHead2Black,
                          ),
                          const Spacer(),
                          Text(
                            '4.7',
                            style: kBody1MediumBlue,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.greenAccent,
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
                          Text(
                            '198 Reviews',
                            style: kBody3Grey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: kMediumBlue)),
                            child: Text(
                              'Family matters',
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
                              'Corporate business',
                              style: kBody3DarkBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: kMediumBlue)),
                        child: Text(
                          'Immigration case',
                          style: kBody3DarkBlue,
                        ),
                      ),
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
                        'This passionate lawyer dedicated their life to fighting for justice and advocating for their clients rights.',
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
                            'Bengaluru',
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
                            Icons.lock_open,
                            color: kMediumBlue,
                          ),
                          SizedBox(
                            width: Get.width * 0.012,
                          ),
                          Text(
                            '6+ Years of experience',
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
                            'Bengaluru',
                            style: kBody44DarkBlue,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                        child: ConstantButton(
                            buttonText: 'Book now for free',
                            onTap: () =>
                                Get.to(() => const TimeScheduleView())),
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Back to search',
                              style: kBody1MediumBlue,
                            )),
                      )
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
