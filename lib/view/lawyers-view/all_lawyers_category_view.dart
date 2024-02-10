import 'package:catch_case/constant-widgets/constant_appbar.dart';
import 'package:catch_case/constant-widgets/constant_textfield2.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllLawyersCategoryView extends StatelessWidget {
  const AllLawyersCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ConstantAppBar(text: 'Lawyers'),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ConstantTextField2(
                  prefixIcon: Icons.search, suffixIcon: Icons.filter),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                'Types of lawyers',
                style: kBody1DarkBlue,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: Get.width / (Get.height / 4),
                      crossAxisSpacing: Get.width * 0.03,
                      mainAxisSpacing: Get.height * 0.02),
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: kMediumBlue,
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.02)),
                      child: Center(
                          child: Text(
                        'Labour Lawyers',
                        style: kBody4DarkBlue,
                      )),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
