import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String? receiverId;
  final String? message;
  final Timestamp? timestamp;
  final bool? read;

  Message({
    required this.senderId,
    required this.senderEmail,
    this.receiverId,
    this.message,
    this.timestamp,
    this.read,
  });

  Map<String , dynamic> toMap(){
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}