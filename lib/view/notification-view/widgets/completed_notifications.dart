import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyers-view/widgets/lawyers_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedNotifications extends StatelessWidget {
  const CompletedNotifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/home/person.png'),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rako Christian.',
                        style: kBody1Black,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range,
                            color: kMediumBlue,
                          ),
                          Text(
                            ' 31/2/2023 | 10:00AM',
                            style: kBody4Black,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '4.7',
                  style: kBody2MediumBlue,
                ),
                const Icon(
                  Icons.star,
                  color: Colors.green,
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.008,
            ),
            Text(
              'Area of practice',
              style: kBody3DarkBlue,
            ),
            Row(
              children: [
                Text(
                  'Family matters | Corporate business | \nImmigration case',
                  style: kBody5DarkBlue,
                ),
                const Spacer(),
                LawyersButton(
                    buttonText: 'Message',
                    buttonColor: kButtonColor,
                    onTap: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
