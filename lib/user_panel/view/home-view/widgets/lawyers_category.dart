import 'package:catch_case/constants/textstyles.dart';
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('lawyers')
            .orderBy('category')
            .limit(5)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child:
                    Text('No Category Registered yet', style: kBody1DarkBlue));
          } else {
            Set<String> categories = Set<String>();
            for (var doc in snapshot.data!.docs) {
              var category = doc['category'];
              if (category != null) {
                categories.add(category);
              }
            }
            return SizedBox(
              // width: double.infinity,
              height: Get.height * 0.1,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
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
