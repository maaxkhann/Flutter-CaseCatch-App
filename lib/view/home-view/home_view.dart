import 'package:catch_case/constant-widgets/constant_textfield2.dart';

import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/home-view/widgets/free_consultation_widget.dart';

import 'package:catch_case/view/home-view/widgets/home_appbar.dart';
import 'package:catch_case/view/home-view/widgets/home_button.dart';
import 'package:catch_case/view/home-view/widgets/lawyers_category.dart';
import 'package:catch_case/view/lawyers-view/all_lawyers_view.dart';
import 'package:catch_case/view/lawyers-view/free_lawyers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(
          text: 'Catch',
          text2: 'Case',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02, vertical: Get.height * 0.015),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ConstantTextField2(
                    prefixIcon: Icons.search, suffixIcon: Icons.filter_alt),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Free consultation',
                      style: kBody1Black2,
                    ),
                    TextButton(
                        onPressed: () => Get.to(() => const AllLawyersView()),
                        child: Text(
                          'View all',
                          style: kBody3DarkBlue,
                        ))
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const FreeConsultationWidget(),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      const FreeConsultationWidget(),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      const FreeConsultationWidget()
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'View all',
                    style: kBody3DarkBlue,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.005),
                          width: Get.width * 0.24,
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(137, 233, 225, 225),
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.02)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Category',
                                style: kBody5Black,
                              ),
                              Image.asset('assets/images/home/home_cubes.png'),
                            ],
                          )),
                      const LawyersCategory(text: 'Divorce lawyers'),
                      const LawyersCategory(text: 'Family lawyers'),
                      const LawyersCategory(text: 'Criminal lawyers'),
                      const LawyersCategory(text: 'Labour lawyers'),
                      const LawyersCategory(text: 'Civil lawyers'),
                      const LawyersCategory(text: 'Military lawyers'),
                      const LawyersCategory(text: 'Cyber lawyers'),
                      const LawyersCategory(text: 'Contract lawyers'),
                      const LawyersCategory(text: 'Securities lawyers'),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Center(
                    child: HomeButton(
                        buttonText: 'All lawyers',
                        onTap: () => Get.to(() => const AllLawyersView()))),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.02),
                  child:
                      SvgPicture.asset('assets/images/home/chat_experts.svg'),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'Steps to book an appointment',
                  style: kBody1Black2,
                ),
                GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Get.width * 0.04,
                  ),
                  children: [
                    SvgPicture.asset('assets/images/home/Group 472.svg'),
                    SvgPicture.asset('assets/images/home/Group 473.svg'),
                    SvgPicture.asset('assets/images/home/Group 474.svg'),
                    SvgPicture.asset('assets/images/home/Group 475.svg'),
                  ],
                ),
                Center(
                    child: HomeButton(
                        buttonText: 'All lawyers',
                        onTap: () => Get.to(() => const AllLawyersView()))),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Our Lawyers',
                      style: kBody1Black2,
                    ),
                    TextButton(
                        onPressed: () => Get.to(() => const AllLawyersView()),
                        child: Text(
                          'View all',
                          style: kBody3DarkBlue,
                        ))
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const FreeConsultationWidget(),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      const FreeConsultationWidget(),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      const FreeConsultationWidget()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
