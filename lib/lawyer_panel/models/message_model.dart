
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
 final String senderId;
 final String senderEmail;
 final String recieverId;
 final String message;
 final String file;
 final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.message,
    required this.file,
    required this.timestamp,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'file': file,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ,
      senderEmail: map['senderEmail'] ,
      recieverId: map['recieverId'] ,
      message: map['message'] ,
      file: map['file'] ,
      timestamp: map['timestamp'] 
    );
  }


 }
