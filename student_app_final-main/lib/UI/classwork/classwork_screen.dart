import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Network/local/cache_helper.dart';
import '../../models/classwork/Course.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';
import 'project/project_subject_screen.dart';
import 'subject_details.dart';


class ClassworkScreen extends StatefulWidget {
  const ClassworkScreen({Key? key}) : super(key: key);

  @override
  State<ClassworkScreen> createState() => _ClassworkScreenState();
}

class _ClassworkScreenState extends State<ClassworkScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    String uid = CacheHelper.getData(key: 'userId');
    Provider.of<AppProvider>(context, listen: false).getCourses(uid);

  }
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF27B35),
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Registered Courses',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          String uid = CacheHelper.getData(key: 'userId');
          Provider.of<AppProvider>(context, listen: false).getCourses(uid);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              for (int index = 0; index <provider.courses.length ; index++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h , horizontal: 16.h),
                  child: CourseWidget(course: provider.courses[index]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseWidget extends StatelessWidget {
  final Course course;

  const CourseWidget({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if(course.coursesID == "FRM 416" ||course.coursesID == "FRM 426"){
            navigateTo(context, ProjectSubjectScreen(subjectID: 'course.coursesID!',));
            return;
          }else{
            navigateTo(context, SubjectDetailsScreen(subjectID: course.coursesID!));
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.sw),
                child: Image.network(course.photo! , width: 100.w, height: 100.h, fit: BoxFit.cover),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.courseName!,
                      style:  TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                     SizedBox(height: 8.h),
                    Text(
                      'Dr : ${course.fullName}',
                      style:  TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w300,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}