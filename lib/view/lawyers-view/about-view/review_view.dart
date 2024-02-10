import 'package:catch_case/constant-widgets/constant_appbar.dart';
import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool isMaxLines = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ConstantAppBar(
          text: 'Reviews',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Top Reviews',
                    style: kBody1MediumBlue,
                  ),
                  SizedBox(width: 3)
                ],
              ),
              reviewContainer(),
              reviewContainer(),
              reviewContainer(),
              reviewContainer(),
              reviewContainer(),
              reviewContainer(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstantButton(
            buttonText: 'Load more',
            onTap: () {},
          ),
        ),
      ),
    );
  }

  Widget reviewContainer() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            width: Get.width,
            child: FittedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: AssetImage(
                      'assets/images/lawyer/lawyer.png',
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shanti K M',
                            style: kHead2Black,
                          ),
                          SizedBox(width: Get.width * 0.35),
                          ratingBar(4.3)
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.7,
                        child: Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using  making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                          maxLines: isMaxLines ? 5 : 2,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isMaxLines = !isMaxLines;
                          });
                        },
                        child: Text(
                          isMaxLines ? "See less" : 'See more',
                          style: kBody2MediumBlue,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        divider()
      ],
    );
  }

  Widget ratingBar(double rating) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        size: 10,
        color: Colors.blue.shade200,
      ),
      itemCount: 5,
      itemSize: 15.0,
      direction: Axis.horizontal,
    );
  }

  Widget divider() {
    return Divider(
      thickness: 3,
      color: Colors.grey.shade300,
    );
  }
}