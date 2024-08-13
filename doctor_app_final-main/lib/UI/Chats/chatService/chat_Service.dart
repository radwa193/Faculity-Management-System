import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/message.dart';

class ChatService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // send messages
  Future<void> sendMessage(String message, String receiverId) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      read: false,
    );

    List<String> membersIds = [currentUserId, receiverId];
    membersIds.sort();
    String chatRoomId = membersIds.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }
  // get messages

  Stream<QuerySnapshot> getMessages(String userId , String otherUserId){
    List<String> membersIds = [userId, otherUserId];
    membersIds.sort();
    String chatRoomId = membersIds.join('_');

    return _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').orderBy('timestamp' , descending: false).snapshots();
  }
}