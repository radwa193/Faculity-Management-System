import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../provider/provider.dart';

class UserChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;

  const UserChatScreen({
    Key? key,
    required this.receiverUserEmail,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    final currentUserId = Provider.of<AppProvider>(context, listen: false).doctorId;

    if (_messageController.text.isNotEmpty && currentUser != null) {
      print('User ID: $currentUserId');
      try {
        final response = await Supabase.instance.client.from('messages').insert({
          'user_id': currentUserId,
          'receiver_id': widget.receiverUserId,
          'content': _messageController.text,
          'timestamp': DateTime.now().toIso8601String(),
          'read': false,
        }).select();
        print('Response: ${response.toString()}');
        _messageController.clear();
        _scrollToBottom();
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print('Error: No authenticated user or message is empty.');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receiverUserEmail,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Text(
                    'online',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          Divider(
            height: 2,
            color: Colors.grey,
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    final currentUserId = Provider.of<AppProvider>(context, listen: false).doctorId;
    final receiverUserId = widget.receiverUserId;

    final messageStream = Supabase.instance.client
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: true)
        .handleError((error) {
      print('Stream error: $error');
    }).map((event) {
      if (event == null) {
        print('Null event in messageStream');
        return <Map<String, dynamic>>[];
      }
      return event.where((element) =>
      (element['user_id'] == currentUserId && element['receiver_id'] == receiverUserId) ||
          (element['user_id'] == receiverUserId && element['receiver_id'] == currentUserId)
      ).toList();
    });

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: messageStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Stream snapshot has error: ${snapshot.error}');
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('Stream snapshot has no data');
          return const Center(
            child: Text('No messages found'),
          );
        }

        final messages = snapshot.data!;
        print('Messages received: ${messages.length}');

        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

        return ListView(
          controller: _scrollController,
          children: messages.map((document) {
            if (document == null) {
              print('Null document found');
              return const ListTile(
                title: Text('Error: Null document'),
              );
            }
            return _buildMessageItem(document);
          }).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    final currentUserId = Provider.of<AppProvider>(context, listen: false).doctorId;

    var alignment = (data['user_id'] == currentUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    DateTime dateTime;
    try {
      dateTime = DateTime.parse(data['timestamp']);
    } catch (e) {
      print('Error parsing timestamp: $e');
      dateTime = DateTime.now();
    }
    String formattedTime = '${dateTime.hour}:${dateTime.minute}';

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: data['user_id'] != currentUserId,
            child: Text(
              data['user_email'] ?? 'Unknown',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 12,),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: data['user_id'] == currentUserId
                  ? const Color(0xffF28444)
                  : const Color(0xffcacdd0),
              borderRadius: data['user_id'] == currentUserId
                  ? const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
                  : const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Text(
              data['content'] ?? 'No content',
              style: TextStyle(
                color: data['user_id'] == currentUserId
                    ? Colors.white
                    : Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            formattedTime,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xffF7F7F7),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_upward, size: 40,),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
