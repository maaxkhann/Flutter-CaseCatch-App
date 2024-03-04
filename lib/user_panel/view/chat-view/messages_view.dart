import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chat_screen.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  String searchText = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kButtonColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Messages',
            style: kHead2White,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
          child: Column(
            children: [
              // Center(
              //   child: Text(
              //     'Recent',
              //     style: kBody1MediumBlue,
              //   ),
              // ),
              23.heightBox,
              Container(
                height: 48,
                width: Get.size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7F9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
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
                          hintText: 'Search by name',
                          border: InputBorder.none,
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            // color: const Color(0xFF353535),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                      ),
                    ),
                    // Image.asset(
                    //   'assets/filter.png',
                    //   height: 20,
                    //   width: 20,
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('lawyers')
                      .orderBy('name')
                      // .where( 'groupId' ,isEqualTo: FirebaseAuth.instance.currentUser!.uid )
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
                      return Column(
                          children: snapshot.data?.docs.map((e) {
                                String fcmToken = '';
                                try {
                                  fcmToken = e['fcmToken'];
                                } catch (e) {
                                  fcmToken = '';
                                }
                                return Column(
                                  children: [
                                    Card(
                                      shadowColor: Colors.black,
                                      color: Colors.white,
                                      elevation: 13,
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            Get.to(() => Chat(
                                                  fcmToken: fcmToken,
                                                  groupId: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  name: e['name'],
                                                  image: e['image'],
                                                  uid: e['lawyerId'],
                                                ));
                                          },
                                          contentPadding: EdgeInsets.zero,
                                          leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                NetworkImage(e['image']),
                                          ),
                                          title: Text(
                                            e['name'],
                                            // style: GoogleFonts.poppins(),
                                          ),
                                          subtitle: const Text('Hi There'
                                              // style: GoogleFonts.poppins(),
                                              ),
                                          trailing: const Padding(
                                            padding: EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Text(
                                              '10:03 AM',
                                              // style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList() ??
                              []);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
