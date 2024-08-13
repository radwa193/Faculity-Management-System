import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/UI/classwork/Announcement/announcement_screen.dart';
import 'package:management_system_final_doctor/UI/classwork/Assignment/aasignment_screen.dart';
import 'package:management_system_final_doctor/UI/classwork/Attendance/Past%20Attendance.dart';
import 'package:management_system_final_doctor/UI/classwork/Exam/exam.dart';
import 'package:management_system_final_doctor/UI/classwork/Lecture/lecture_screen.dart';
import 'package:management_system_final_doctor/UI/classwork/Results/results_screen.dart';
import 'package:management_system_final_doctor/attend.dart';
import 'package:management_system_final_doctor/shared/components.dart';
import '../../Network/local/cache_helper.dart';
import '../../style/fonts.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final String subjectId;

  const SubjectDetailsScreen({Key? key, required this.subjectId}) : super(key: key);

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Row(
          children: [
            Text(
              'Classwork',
                style: Styles.style20
            ),
          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(22.0.h),
        child: Column(
          children: [
             SizedBox(
              height: 20.h,
            ),
            ServiceTile(
              path : 'assets/images/classwork_icons/attendance.png',
              serviceName: 'Take Attendance',
              onTap: () {
                print('123');
                int? doctorId  = CacheHelper.getData(key: 'doctorID');
                navigateTo(context, EncryptionWidget(
                  courseId: widget.subjectId,
                ));
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            ServiceTile(
              path : 'assets/images/classwork_icons/attendance.png',
              serviceName: 'Past Attendance',
              onTap: () {
                navigateTo(context, AttendanceListScreen(
                  courseID: widget.subjectId,
                ));
                print(widget.subjectId);

              },
            ),
            SizedBox(
              height: 15.h,
            ),
            ServiceTile(
              path: 'assets/images/classwork_icons/assignment.png',
              serviceName: 'Assign Assignments',
              onTap: () {
                navigateTo(context, AssignmentsScreen(
                  courseId: widget.subjectId,
                ));
              },
            ),
             SizedBox(
              height: 15.h,
            ),
            ServiceTile(
              path: 'assets/images/classwork_icons/lectures.png',
              serviceName: 'Upload Material',
              onTap: () {
                navigateTo(context, LectureScreen(
                  courseId: widget.subjectId,
                ));
              },
            ),
             SizedBox(
              height: 15.h,
            ),
            ServiceTile(
              path: 'assets/images/classwork_icons/section.png',
              serviceName: 'Upload Results',
              onTap: () {
                navigateTo(context, ResultsScreen(
                  courseId: widget.subjectId,
                ));
              },
            ),
             SizedBox(
              height: 15.h,
            ),
            ServiceTile(
              path:'assets/images/icons/announcement.png',
              serviceName: 'Make Announcement',
              onTap: () {
                navigateTo(context, AnnouncementScreen(
                  courseId: widget.subjectId,
                ));
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            ServiceTile(
              path: 'assets/images/icons/announcement.png',
              serviceName: 'Make Exam',
              onTap: () {
                navigateTo(context, ExamScreen(subjectID: widget.subjectId,));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String serviceName;
  final String path;
  final VoidCallback onTap;

  const ServiceTile({Key? key, required this.serviceName, required this.path, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50.h,
        width: 382.w,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: ImageIcon(
            AssetImage(path),
            color: Colors.orange,
          ),
          title: Text(
            serviceName,
              style: Styles.styleBold14
          ),
          tileColor: Colors.transparent,
          onTap: onTap,
        ),
      ),
    );
  }
}


