import 'package:catch_case/user_panel/constant-widgets/constant_textfield2.dart';

import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/home-view/widgets/free_consultation_widget.dart';

import 'package:catch_case/user_panel/view/home-view/widgets/home_appbar.dart';
import 'package:catch_case/user_panel/view/home-view/widgets/home_button.dart';
import 'package:catch_case/user_panel/view/home-view/widgets/lawyers_category.dart';
import 'package:catch_case/user_panel/view/lawyers-view/all_lawyers_category_view.dart';
import 'package:catch_case/user_panel/view/lawyers-view/all_lawyers_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

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
              horizontal: Get.width * 0.02, vertical: Get.height * 0.015),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantTextField2(
                    controller: searchController,
                    prefixIcon: Icons.search,
                    suffixIcon: Icons.filter_alt),
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
                        onPressed: () =>
                            Get.to(() => const FreeConsultaionScreen()),
                        child: Text(
                          'View all',
                          style: kBody3DarkBlue,
                        ))
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  height: 128,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('lawyers')
                          .limit(4)
                          .orderBy('name')
                          .where('price', isEqualTo: '')
                          .startAt([searchText.toUpperCase()]).endAt(
                              ['$searchText\uf8ff']).snapshots(),
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
                            child: Text(
                              'No lawyer Registered yet',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.amber.shade700),
                            ),
                          ));
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            // itemCount:snapshot.data!.docs.length
                            // <
                            //                         3
                            //                     ? snapshot.data!.docs.length
                            //                     : 3,
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
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 10,
                                    bottom: 8,
                                  ),
                                  height: 120,
                                  width: 220,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 80,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            e['image'],
                                            fit: BoxFit.cover,
                                            height: 75,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 9),
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
                                            2.heightBox,
                                            Text(
                                              e['category'],
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 10,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                left: 60,
                                                top: 10,
                                              ),
                                              child: Text(
                                                'Free',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
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
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          Get.to(() => const AllLawyersCategoryView()),
                      child: Text(
                        'View all',
                        style: kBody3DarkBlue,
                      ),
                    )),
                SizedBox(
                  height: Get.height * 0.01,
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
                      SizedBox(
                        height: 128,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('lawyers')
                                .limit(4)
                               .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                return Padding(
                                  padding: const EdgeInsets.only(left: 111),
                                  child: Text(
                                    'No lawyer Registered yet',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.amber.shade700),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  // itemCount:snapshot.data!.docs.length
                                  // <
                                  //                         3
                                  //                     ? snapshot.data!.docs.length
                                  //                     : 3,
                                  itemCount: snapshot.data?.docs.length ?? 0,

                                  itemBuilder: (context, index) {
                                    final e = snapshot.data!.docs[index];
                                    return Card(
                                      color: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 8,
                                        ),
                                        height: 120,
                                        width: 220,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 90,
                                              width: 80,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  e['image'],
                                                  fit: BoxFit.cover,
                                                  height: 75,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6, top: 9),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  2.heightBox,
                                                  Text(
                                                    e['category'],
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 60,
                                                      top: 10,
                                                    ),
                                                    child: Text(
                                                      e['price'],
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
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
