import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/models/upcoming/Upcoming.dart';
import 'package:management_system_final_doctor/provider/provider.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';

import '../../models/Announcement/Announcemnet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()  async {
      await Provider.of<AppProvider>(context, listen: false).getDoctorData(CacheHelper.getData(key: 'email'));
      int doctorID = CacheHelper.getData(key: 'doctorID');
      await Provider.of<AppProvider>(context, listen: false).getDoctorUpcoming(doctorID);
      await Provider.of<AppProvider>(context, listen: false).getTsAnnouncements(doctorID);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          vertical: 40.h,
          horizontal: 53.w,
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text('Good Morning, ${CacheHelper.getData(key: 'doctorName')}' ,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
                ),
                SizedBox(height: 30.h),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(height: 20.h),
                const Text('Upcoming Events',
                  style: TextStyle(
                    color: Color(0x94000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 21.h),
                SizedBox(
                  height: 230.h,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 20.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildUpcomingEvent(provider.doctorUpcomingLectures[index]),
                    itemCount: provider.doctorUpcomingLectures.length,
                  ),
                ),
                SizedBox(height: 20.h),
                const Text('Announcements',
                  style: TextStyle(
                    color: Color(0x94000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 21.h),
                SizedBox(
                  height: 230.h,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 20.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildAnnouncement(provider.tsAnnouncement![index]),
                    itemCount: provider.tsAnnouncement!.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUpcomingEvent(Upcoming event) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    height: 214.h,
    width: 380.w,
    child: Padding(
      padding:  EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 20.w,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                 Text('Course Name' ,
                  style: Styles.style14.copyWith(
                    color: const Color(0xff1C1F34)
                  ),
                ),
                const Spacer(),
                Text(' ${event.courseName} ',
                    style: Styles.style14.copyWith(
                        color: const Color(0xff999999)
                    ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            color: Colors.grey,
            thickness: 0.2,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Row(
              children: [
                 Text('Hall Number' ,
                   style: Styles.style14.copyWith(
                       color: const Color(0xff1C1F34)
                   ),
                ),
                const Spacer(),
                Text(' ${event.room} ',
                  style: Styles.style14.copyWith(
                      color: const Color(0xff999999)
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            color: Colors.grey,
            thickness: 0.2,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Row(
              children: [
                 Text('Duration' ,
                   style: Styles.style14.copyWith(
                       color: const Color(0xff1C1F34)
                   ),
                ),
                const Spacer(),
                Text(' ${event.periodStart} - ${event.periodEnd} ',
                  style:  TextStyle(
                    color: const Color(0xff999999),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            color: Colors.grey,
            thickness: 0.2,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Row(
              children: [
                 Text('Level' ,
                   style: Styles.style14.copyWith(
                       color: const Color(0xff1C1F34)
                   ),
                ),
                const Spacer(),
                Text(' ${event.level} ',
                    style: Styles.style14.copyWith(
                        color: const Color(0xff999999)
                    ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    ),
  );

  Widget buildAnnouncement(Announcemnet announcement) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    height: 214.h,
    width: 380.w,
    child: Padding(
      padding:  EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Announcement Title : ${announcement.announcementTitle!}" ,
            style: Styles.style14.copyWith(
                color: const Color(0xff1C1F34)
            ),
          ),
          SizedBox(height: 10.h),
          Text(" Announcement Description : ${announcement.announcementContent!}",
            style: Styles.style14.copyWith(
                color: const Color(0xff1C1F34)
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            color: Colors.grey,
            thickness: 0.2,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text('Date' ,
                style: Styles.style14.copyWith(
                    color: const Color(0xff1C1F34)
                ),
              ),
              const Spacer(),
              Text(' ${announcement.announcementTimeStamp} ',
                style: Styles.style14.copyWith(
                    color: const Color(0xff999999)
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
