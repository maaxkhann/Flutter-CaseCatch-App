import 'package:catch_case/user_panel/constant-widgets/constant_appbar.dart';
import 'package:catch_case/user_panel/constant-widgets/constant_textfield2.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category/category_detail_screen.dart';

class AllLawyersCategoryView extends StatefulWidget {
  const AllLawyersCategoryView({super.key});

  @override
  State<AllLawyersCategoryView> createState() => _AllLawyersCategoryViewState();
}

class _AllLawyersCategoryViewState extends State<AllLawyersCategoryView> {
  TextEditingController searchController = TextEditingController();

  String searchText = "";
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
               ConstantTextField2(
                controller: searchController,
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
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('lawyers')
                      .orderBy('category')
                      .startAt([searchText.toUpperCase()]).endAt(
                          ['$searchText\uf8ff']).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 233),
                        child: CircularProgressIndicator(),
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 233),
                        child: Text(
                          'No lawyer Registered yet',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.amber.shade700),
                        ),
                      ));
                    } else {
                      Set<String> categories = Set<String>();
                      for (var doc in snapshot.data!.docs) {
                        var category = doc['category'];
                        if (category != null) {
                          categories.add(category);
                        }
                      }
                      return Expanded(
                        child: GridView.builder(
                          itemCount: categories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      Get.width / (Get.height / 4),
                                  crossAxisSpacing: Get.width * 0.03,
                                  mainAxisSpacing: Get.height * 0.02),
                          itemBuilder: (BuildContext context, int index) {
                            var category = categories.elementAt(index);
                            return GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      CategoryDetailScreen(category: category));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kMediumBlue,
                                      borderRadius: BorderRadius.circular(
                                          Get.width * 0.02)),
                                  child: Center(
                                      child: Text(
                                    category,
                                    style: kBody4DarkBlue,
                                  )),
                                ));
                          },
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
