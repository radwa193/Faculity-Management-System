import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/shared/components.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';
import '../../models/chat_users.dart';
import '../../provider/provider.dart';
import 'search.dart';
import 'user_chat_screen.dart';

class RecentChatScreen extends StatefulWidget {
  const RecentChatScreen({Key? key}) : super(key: key);

  @override
  State<RecentChatScreen> createState() => _RecentChatScreenState();
}

class _RecentChatScreenState extends State<RecentChatScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

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
        title: Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            Text('Chats', style: Styles.styleBold20),
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
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: const [
                      Tab(text: "Students"),
                      Tab(text: "Support"),
                    ],
                    controller: _tabController,
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    labelColor: const Color(0xffEF7505),
                    indicatorColor: const Color(0xffEF7505),
                    unselectedLabelColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(
              color: Colors.grey,
              height: 3.h,
            ),
          ),
          Expanded(
            flex: 2,
            child: Consumer<AppProvider>(
              builder: (context, provider, _) {
                if (provider.receiverUserId.isNotEmpty) {
                  return UserChatScreen(
                    receiverUserId: provider.receiverUserId,
                    receiverUserEmail: provider.receiverUserEmail,
                  );
                } else {
                  return const SizedBox();
                }
              },
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
          .eq('role', 'student'),
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
