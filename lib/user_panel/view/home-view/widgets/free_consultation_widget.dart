import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/lawyers-view/about-view/about_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeConsultationWidget extends StatelessWidget {
  final String name;

  const FreeConsultationWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Get.to(() => const AboutView()),
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
          width: Get.width * 0.52,
          height: Get.height * 0.12,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 238, 238),
              borderRadius: BorderRadius.circular(Get.width * 0.02)),
          child: LayoutBuilder(builder: ((context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/home/person.png',
                  height: constraints.maxHeight * 0.8,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: kBody4Black,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.04,
                    ),
                    Text(
                      'Family lawyer',
                      style: kBody5Grey,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.04,
                    ),
                    Text(
                      'Tax lawyer',
                      style: kBody5Grey,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '4.7',
                      style: kBody4Black,
                    ),
                    Text(
                      'Free',
                      style: kBody444DarkBlue,
                    ),
                  ],
                )
              ],
            );
          }))),
    );
  }
}
