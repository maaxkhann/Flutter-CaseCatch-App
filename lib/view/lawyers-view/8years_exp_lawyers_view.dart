import 'package:catch_case/constant-widgets/constant_appbar.dart';
import 'package:catch_case/constant-widgets/constant_textfield2.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyers-view/about-view/about_view.dart';
import 'package:catch_case/view/lawyers-view/widgets/lawyers_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EightYearsExpLawyersView extends StatelessWidget {
  const EightYearsExpLawyersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ConstantAppBar(text: 'Lawyers'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.015,
                ),
                const ConstantTextField2(
                    prefixIcon: Icons.search, suffixIcon: Icons.settings),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: Get.height * 0.02),
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.02,
                            vertical: Get.height * 0.01),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 238, 238),
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.02)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/home/person.png',
                              //    height: Get.height * 0.1,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: Get.height * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rako',
                                    style: kBody4Black,
                                  ),
                                  Text(
                                    'Family lawyer',
                                    style: kBody5Grey,
                                  ),
                                  Text(
                                    'Tax lawyer',
                                    style: kBody5Grey,
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: Get.width * 0.05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Exp',
                                          style: kBody4Black,
                                        ),
                                        Text(
                                          '8+ Years',
                                          style: kBody5Grey,
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '4.7',
                                        style: kBody4Black,
                                      ),
                                      Text(
                                        'Free',
                                        style: kBody444DarkBlue,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      LawyersButton(
                                          buttonText: 'Book Now',
                                          onTap: () =>
                                              Get.to(() => const AboutView()))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
