import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/UI/classwork/Project/project_subject_screen.dart';
import 'package:management_system_final_doctor/models/course/Course.dart';
import 'package:management_system_final_doctor/provider/provider.dart';
import 'package:management_system_final_doctor/shared/components.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';

import 'subject_details.dart';



class ClassworkScreen extends StatefulWidget {
  const ClassworkScreen({Key? key}) : super(key: key);

  @override
  State<ClassworkScreen> createState() => _ClassworkScreenState();
}

class _ClassworkScreenState extends State<ClassworkScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int? doctorID = CacheHelper.getData(key: 'doctorID');
    Provider.of<AppProvider>(context, listen: false).getDoctorCourses(doctorID);
  }
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
        title:  Row(
          children: [
            Expanded(
              child: Text(
                'Classwork',
                style: Styles.style24,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Registered Courses',
                style: Styles.style14.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 16.h),
              Column(
                children: provider.doctorCourses.map((course) {
                  return courseWidget(context, course);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget courseWidget(BuildContext context, Course course) => InkWell(
    onTap: () {
      if(course.coursesID == "FRM 416" ||course.coursesID == "FRM 426"){
        navigateTo(context, ProjectSubjectScreen());
        return;
      } else {
        navigateTo(
            context, SubjectDetailsScreen(subjectId: '${course.coursesID}'));
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150.h,
        width: 382.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(course.photo! , width: 100.w, height: 100.h, fit: BoxFit.cover),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      course.courseName!,
                      style: Styles.styleBold16,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Number of Students : ${course.numberOfStudents}',
                        style: Styles.style12
                    ),
                     SizedBox(height: 8.h),
                    Flexible(
                      child: Text(
                        'TA: ${course.tANames}',
                          style: Styles.style12
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}



