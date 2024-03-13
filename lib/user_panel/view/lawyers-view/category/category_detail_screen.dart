import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constant-widgets/constant_appbar.dart';
import '../../../constants/textstyles.dart';
import '../about-view/about_view.dart';
import '../widgets/lawyers_button.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  TextEditingController searchController = TextEditingController();

  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ConstantAppBar(text: widget.category),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 22,
                ),
                TextFormField(
                    controller: searchController,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      hintText: 'Search for lawyers',
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.02),
                        borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.02),
                        borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
                      ),
                      prefixIcon: (searchText.isEmpty)
                          ? const Icon(Icons.search)
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchText = '';
                                searchController.clear();
                                setState(() {});
                              },
                            ),
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        // color: const Color(0xFF353535),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    }),
                22.heightBox,
                const SizedBox(height: 10),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('lawyers')
                        .orderBy('name')
                        .where('category', isEqualTo: widget.category)
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
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            final e = snapshot.data!.docs[index];
                            if (e["name"]
                                .toString()
                                .toLowerCase()
                                .contains(searchText.toLowerCase())) {
                              String fcmToken = '';
                              try {
                                fcmToken = e['fcmToken'];
                              } catch (e) {
                                fcmToken = '';
                              }
                              return Container(
                                margin: EdgeInsets.only(top: Get.height * 0.02),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.02,
                                    vertical: Get.height * 0.01),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 243, 238, 238),
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.02)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 76,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(e['image']),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Get.height * 0.06),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            e['name'],
                                            style: kBody4Black,
                                          ),
                                          Text(
                                            e['category'],
                                            style: kBody5Grey,
                                          ),
                                          // Text(
                                          //   'Tax lawyer',
                                          //   style: kBody5Grey,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.05),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Exp',
                                                  style: kBody4Black,
                                                ),
                                                Text(
                                                  e['experience'],
                                                  style: kBody5Grey,
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
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
                                                  onTap: () => Get.to(() =>
                                                      AboutView(
                                                        fcmToken: fcmToken,
                                                        lawyerId: e['lawyerId'],
                                                        image: e['image'],
                                                        name: e['name'],
                                                        category: e['category'],
                                                        experience:
                                                            e['experience'],
                                                        address: e['address'],
                                                        practice: e['practice'],
                                                        contact: e['contact'],
                                                        bio: e['bio'],
                                                      )))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
