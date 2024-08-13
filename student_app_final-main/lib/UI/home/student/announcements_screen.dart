import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// ignore: must_be_immutable
class AnnouncementScreen extends StatelessWidget {
  AnnouncementScreen({Key? key}) : super(key: key);
  var topicsController = PageController();

  List<String> topics = [
    'assets/images/icons/Ann1.png',
    'assets/images/icons/Ann2.png',
    'assets/images/icons/Ann3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF27B35),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 30.sw,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Announcements',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          ListView.separated(
              separatorBuilder: (context , index) => const SizedBox(height: 10,),
              itemBuilder:(context , index) => buildTopics(topics[index]),
              itemCount: topics.length,
              shrinkWrap: true,
          )
        ],
      ),
    );
  }
  Widget buildTopics(String image) => SizedBox(
    width: double.infinity,
    child: Image(image: AssetImage(image),),
  );
}
