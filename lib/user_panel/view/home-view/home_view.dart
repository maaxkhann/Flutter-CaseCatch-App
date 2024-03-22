import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/home-view/widgets/home_appbar.dart';
import 'package:catch_case/user_panel/view/home-view/widgets/home_button.dart';
import 'package:catch_case/user_panel/view/home-view/widgets/lawyers_category.dart';
import 'package:catch_case/user_panel/view/lawyers-view/all_lawyers_category_view.dart';
import 'package:catch_case/user_panel/view/lawyers-view/all_lawyers_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchText = "";
  TextEditingController searchController = TextEditingController();

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
              horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  height: Get.height * 0.155,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('lawyers')
                          .limit(4)
                          .orderBy('name')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: CircularProgressIndicator(),
                          ));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text('No lawyer Registered yet',
                                style: kBody1DarkBlue),
                          ));
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length ?? 0,
                            itemBuilder: (context, index) {
                              final e = snapshot.data!.docs[index];
                              return Card(
                                color: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(8.r),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 80.h,
                                        width: 80.w,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            e['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 6.w, top: 9.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  e['name'],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              e['category'],
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Catrgories',
                      style: kBody1Black2,
                    ),
                    TextButton(
                      onPressed: () =>
                          Get.to(() => const AllLawyersCategoryView()),
                      child: Text(
                        'View all',
                        style: kBody3DarkBlue,
                      ),
                    ),
                  ],
                ),
                const LawyersCategory(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
