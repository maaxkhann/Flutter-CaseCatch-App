import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/lawyers-view/about-view/about_view.dart';
import 'package:catch_case/user_panel/view/lawyers-view/widgets/lawyers_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant-widgets/constant_appbar.dart';

class AllLawyersView extends StatefulWidget {
  const AllLawyersView({
    super.key,
  });

  @override
  State<AllLawyersView> createState() => _FreeConsultaionScreenState();
}

class _FreeConsultaionScreenState extends State<AllLawyersView> {
  TextEditingController searchController = TextEditingController();

  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ConstantAppBar(text: 'All lawyers'),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    }),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('lawyers')
                        .orderBy('name')
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
                        return Center(
                            child: Text(
                          'Error: ${snapshot.error}',
                          style: kBody1Black,
                        ));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 233),
                          child: Text(
                            'No lawyer Registered yet',
                            style: kBody1DarkBlue,
                          ),
                        ));
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            final e = snapshot.data!.docs[index];
                            if (e["name"]
                                .toString()
                                .toLowerCase()
                                .contains(searchText.toLowerCase())) {
                              return Container(
                                margin:
                                    EdgeInsets.only(top: Get.height * 0.014),
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
                                      width: 60.w,
                                      height: 74.h,
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
                                    SizedBox(
                                      width: Get.width * 0.02,
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
                                                left: Get.width * 0.05,
                                                bottom: Get.height * 0.06),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Exp',
                                                  style: kBody4Black,
                                                ),
                                                Text(
                                                  '${e['experience']} years',
                                                  style: kBody5Grey,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Get.height * 0.05),
                                            child: LawyersButton(
                                                buttonText: 'About',
                                                onTap: () => Get.to(() =>
                                                    AboutView(
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
                                                      fcmToken: e['fcmToken'],
                                                    ))),
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
