import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lawyers-view/category/category_detail_screen.dart';

class LawyersCategory extends StatelessWidget {
  const LawyersCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
          //  Container(
          //               padding: EdgeInsets.symmetric(
          //                   vertical: Get.height * 0.005),
          //               width: Get.width * 0.24,
          //               height: Get.height * 0.1,
          //               decoration: BoxDecoration(
          //                   color: const Color.fromARGB(137, 233, 225, 225),
          //                   borderRadius:
          //                       BorderRadius.circular(Get.width * 0.02)),
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                 children: [
          //                   Text(
          //                     'Category',
          //                     style: kBody5Black,
          //                   ),
          //                   Image.asset('assets/images/home/home_cubes.png'),
          //                 ],
          //               )),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('lawyers')
                .orderBy('category')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(
                      'No lawyer Registered yet',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.amber.shade700),
                    ));
              } else {
                Set<String> categories = Set<String>();
                for (var doc in snapshot.data!.docs) {
                  var category = doc['category'];
                  if (category != null) {
                    categories.add(category);
                  }
                }
                return Container(
                  // width: double.infinity,
                            height: Get.height * 0.1,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var category = categories.elementAt(index);
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => CategoryDetailScreen(category: category));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Get.width * 0.02),
                            padding:
                                EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                            width: Get.width * 0.24,
                            height: Get.height * 0.1,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(137, 233, 225, 225),
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.02)),
                            child: Center(
                              child: Text(
                                category,
                                style: kBody5Grey,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ));
                    },
                  ),
                );
              }
            });
      
  }
}
