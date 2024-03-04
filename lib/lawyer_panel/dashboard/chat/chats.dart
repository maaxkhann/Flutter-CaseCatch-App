import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chat_screen.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  String searchText = "";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightBox,
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * .26),
                    const Text(
                      'Chats',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                22.heightBox,
                Container(
                  height: 48,
                  width: Get.size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F7F9),
                    borderRadius: BorderRadius.circular(30),
                  ),
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
                      
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 29),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .orderBy('username')
                        .startAt([searchText.toUpperCase()]).endAt(
                            ['$searchText\uf8ff']).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
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
                                                  name: e['username'],
                                                  image: e['image'],
                                                  uid: e['userId'],
                                                  groupId  : FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                ));
                                          },
                                          contentPadding: EdgeInsets.zero,
                                          leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                NetworkImage(e['image']),
                                          ),
                                          title: Text(
                                            e['username'],
                                            style: TextStyle(fontSize: 17,),
                                          ),
                                          subtitle: const Text(
                                            'Hi There!',
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
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
