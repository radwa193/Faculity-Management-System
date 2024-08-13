import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_student_version/UI/Chats/search.dart';
import 'package:final_student_version/UI/Chats/user_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/chat_users.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';


class RecentChatScreen extends StatefulWidget {
  const RecentChatScreen({Key? key}) : super(key: key);

  @override
  State<RecentChatScreen> createState() => _RecentChatScreenState();
}

class _RecentChatScreenState extends State<RecentChatScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String search = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
        title: const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, const SearchScreen());
            },
            icon: const Icon(
              Icons.search,
              color: Color(0xffEF7505),
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: const [
                      Tab(text: "Teaching Staff"),
                      Tab(text: "Support"),
                    ],
                    controller: _tabController,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    labelColor: const Color(0xffEF7505),
                    indicatorColor: const Color(0xffEF7505),
                    unselectedLabelColor: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TabScreen1(),
                        TabScreen2(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class TabScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Supabase.instance.client
          .from('users')
          .select()
          .eq('role', 'doctor'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          final users = snapshot.data ?? [];
          return ListView(
            children: users.map<Widget>((user) => buildChatItem(user, context)).toList(),
          );
        }
      },
    );
  }
}

class TabScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Supabase.instance.client
          .from('users')
          .select()
          .eq('role', 'admin'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
                alignment: Alignment.center,
                width: 50.w,
                height: 50.h,
                child: const CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          final users = snapshot.data ?? [];
          return ListView(
            children: users.map<Widget>((user) => buildChatItem(user, context)).toList(),
          );
        }
      },
    );
  }
}


Widget buildChatItem(dynamic data, BuildContext context) {
  final supabase = Supabase.instance.client;
  String uid = data['uid'];
  String email = data['email'];

  final messageStream = supabase
      .from('messages')
      .stream(primaryKey: ['id'])
      .eq('user_id', uid)
      .order('timestamp', ascending: false)
      .limit(1);

  return StreamBuilder<List<Map<String, dynamic>>>(
    stream: messageStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Container(
            alignment: Alignment.center,
            width: 50.w,
            height: 50.h,
            child: const CircularProgressIndicator(),
          ),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        bool hasNewMessage = snapshot.data!.isNotEmpty && snapshot.data!.first['read'] == false;
        if (supabase.auth.currentUser?.email != email) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ListTile(
                  title: Text(email),
                  onTap: () {
                    Provider.of<AppProvider>(context, listen: false)
                        .setReceiverUser(
                      receiverUserId: uid,
                      receiverUserEmail: email,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserChatScreen(
                          receiverUserId: uid,
                          receiverUserEmail: email,
                        ),
                      ),
                    );
                  },
                  trailing: Visibility(
                    visible: hasNewMessage,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10.h,
                  thickness: 2.h,
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      }
    },
  );
}



