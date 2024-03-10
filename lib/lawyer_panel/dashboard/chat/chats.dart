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
                        // Navigator.pop(context);
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
                        .collection('chats')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      QuerySnapshot chatSnapshot =
                          snapshot.data as QuerySnapshot;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: chatSnapshot.docs.length,
                          itemBuilder: (context, index) {
                            final chatData = snapshot.data?.docs[index].data()
                                as Map<String, dynamic>;
                            dynamic group = chatData['group'];
                            List<dynamic> groupIds = group.toList();
                            String targetUserId1 = groupIds[0];
                            String targetUserId2 =
                                groupIds.length > 1 ? groupIds[1] : "";

                            groupIds
                                .remove(FirebaseAuth.instance.currentUser!.uid);

                            return targetUserId1 ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid ||
                                    targetUserId2 ==
                                        FirebaseAuth.instance.currentUser!.uid
                                ? FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(groupIds[0])
                                        .get(),
                                    builder: (context, userData) {
                                      if (userData.connectionState ==
                                              ConnectionState.waiting ||
                                          !userData.hasData) {
                                        return const SizedBox();
                                      }
                                      if (userData.hasError ||
                                          !userData.data!.exists) {
                                        return const SizedBox();
                                      }
                                      final targetUser = userData.data;
                                      if (targetUser == null) {
                                        return const SizedBox();
                                      }

                                      return ListTile(
                                        onTap: () {
                                          Get.to(() => Chat(
                                                fcmToken:
                                                    targetUser['fcmToken'],
                                                name: targetUser['username'],
                                                image: targetUser['image'],
                                                uid: targetUser['userId'],
                                                groupId: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              ));
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              NetworkImage(targetUser['image']),
                                        ),
                                        title: Text(
                                          targetUser['username'],
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Text(
                                          chatData['lastMessage'],
                                          // style: GoogleFonts.poppins(),
                                        ),
                                        trailing: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: Text(
                                            chatData['timeStamp'],
                                            // style: GoogleFonts.poppins(),
                                          ),
                                        ),
                                      );
                                    })
                                : const SizedBox();
                            // return ListView(
                            //     shrinkWrap: true,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     scrollDirection: Axis.vertical,
                            //     children: snapshot.data?.docs.map((e) {
                            //           String fcmToken = '';

                            //           try {
                            //             fcmToken = e['fcmToken'];
                            //           } catch (e) {
                            //             fcmToken = '';
                            //           }
                            //           return Column(
                            //             children: [
                            //               Card(
                            //                 shadowColor: Colors.black,
                            //                 color: Colors.white,
                            //                 elevation: 13,
                            //                 child: Container(
                            //                   padding: const EdgeInsets.only(
                            //                       left: 6),
                            //                   decoration: BoxDecoration(
                            //                     color: Colors.white,
                            //                     borderRadius:
                            //                         BorderRadius.circular(14),
                            //                   ),
                            //                   child: ListTile(
                            //                     onTap: () {
                            //                       Get.to(() => Chat(
                            //                             fcmToken: fcmToken,
                            //                             name: e['username'],
                            //                             image: e['image'],
                            //                             uid: e['userId'],
                            //                             groupId: FirebaseAuth
                            //                                 .instance
                            //                                 .currentUser!
                            //                                 .uid,
                            //                           ));
                            //                     },
                            //                     contentPadding: EdgeInsets.zero,
                            //                     leading: CircleAvatar(
                            //                       radius: 30,
                            //                       backgroundImage:
                            //                           NetworkImage(e['image']),
                            //                     ),
                            //                     title: Text(
                            //                       e['username'],
                            //                       style: const TextStyle(
                            //                         fontSize: 17,
                            //                       ),
                            //                     ),
                            //                     subtitle: const Text(
                            //                       'Hi There!',
                            //                       // style: GoogleFonts.poppins(),
                            //                     ),
                            //                     trailing: const Padding(
                            //                       padding: EdgeInsets.only(
                            //                         right: 10,
                            //                       ),
                            //                       child: Text(
                            //                         '10:03 AM',
                            //                         // style: GoogleFonts.poppins(),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           );
                            //         }).toList() ??
                            //         []);
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
