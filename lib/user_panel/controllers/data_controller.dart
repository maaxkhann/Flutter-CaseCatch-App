import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  DocumentSnapshot? myDocument;

  var isMessageSending = false.obs;
  //
  //
  sendMessageToFirebase(
      {Map<String, dynamic>? data,
      String? lastMessage,
      required String userId,
      required String name,
      required String fcmToken,
      required String image,
      required String otherUserId}) async {
    //
    //
    isMessageSending(true);
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('chatroom')
        .add(data!);
    await FirebaseFirestore.instance.collection('chats').doc(chatRoomId).set({
      'lastMessage': lastMessage,
      'name': name,
      'image': image,
      'fcmToken': fcmToken,
      'groupId': chatRoomId,
      'group': chatRoomId.split('_'),
    }, SetOptions(merge: true));

    isMessageSending(false);
  }

//
//
  Stream<QuerySnapshot> getMessage(userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('chatroom')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
// 
// 
 Stream<QuerySnapshot> getChats(userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return FirebaseFirestore.instance
        .collection('chats')
        .where('groupId',arrayContains: [chatRoomId])
        .snapshots();
  }
//
//
  Stream<QuerySnapshot> getNotificatiom(String uuidToRetrieve) {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: uuidToRetrieve)
        // .orderBy('time', descending: true)

        .snapshots();
  }

//
//
  Future<String> getUserProfileImage(String userId) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('profile_images/$userId.png');
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  
     
//
//
  Future<void> createNotification({
    required String userId,
    required String message,
  }) async {
    var uuid = const Uuid();
    var myId = uuid.v6();
    User? user = auth.currentUser;
    String uid = user!.uid;



 DocumentSnapshot<Map<String, dynamic>> document=await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
    final data = document.data()!;
      String userName = data['username'] ;


    String userProfileImage = await getUserProfileImage(uid);
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(myId)
          .set({
        'notificationUid': FirebaseAuth.instance.currentUser!.uid,
        'userId': userId,
        'image': userProfileImage,
        'message': message,
        'name': userName,
        'time': DateTime.now()
      });
    } catch (e) {
      print(" Error: ${e.toString()}");
    }
  }

//
//
  Future<void> deleteNotification(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(id)
          .delete()
          .then((value) {});
    } catch (e) {
      Get.snackbar('Error', 'Error deleting document: $e');
    }
  }
  //

//
  Future<String> uploadImageToFirebase(File file) async {
    String fileUrl = '';
    String fileName = Path.basename(file.path);
    var reference = FirebaseStorage.instance.ref().child('myfiles/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      fileUrl = value;
    });
    print("Url $fileUrl");
    return fileUrl;
  }
//
//

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  var isUsersLoading = false.obs;

  getUsers() {
    isUsersLoading(true);
    FirebaseFirestore.instance
        .collection('lawyers')
        .snapshots()
        .listen((event) {
      isUsersLoading(false);
    });
  }
}
