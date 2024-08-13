import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/models/project/Project.dart';
import 'package:management_system_final_doctor/models/project/ProjectAssigned.dart';
import 'package:management_system_final_doctor/provider/provider.dart';
import 'package:management_system_final_doctor/shared/dialogUtil/dialog_util.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';

class ProjectSubjectScreen extends StatefulWidget {
  ProjectSubjectScreen({ Key? key}) : super(key: key);

  @override
  State<ProjectSubjectScreen> createState() => _ProjectSubjectScreenState();
}

class _ProjectSubjectScreenState extends State<ProjectSubjectScreen> {
  @override
  void initState() {
    super.initState();
    int? doctorId = CacheHelper.getData(key: 'doctorID');
    Provider.of<AppProvider>(context, listen: false).getAllProjects();
    Provider.of<AppProvider>(context, listen: false).getProjectAssigned(doctorId);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Project 1',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: const Color(0xffF7F7F7),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('All Available Projects' , style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.allProjects!.length,
                      itemBuilder: (context, index) {
                        return ProjectWidget(context, provider.allProjects![index] , provider);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                children: [
                  Text('Assigned Projects' , style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.projectAssigned!.length,
                      itemBuilder: (context, index) {
                        return ProjecttWidget(context, provider.projectAssigned![index] , provider);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ProjectWidget(BuildContext context, Project project , AppProvider provider) => Padding(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    project.projectTitle!,
                    style: Styles.styleBold16,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                      '${project.projectDescription}' ,
                      style: Styles.style12
                  ),
                  SizedBox(height: 8.h),
                  Flexible(
                    child: Text(
                        ' ${project.enrolledStudents}',
                        style: Styles.style12
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Flexible(
                    child: Text(
                        'Leader Name ; ${project.leader}',
                        style: Styles.style12
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: ()async{
                  await provider.assignDoctor(
                    CacheHelper.getData(key: 'doctorID'),
                    project.projectID,
                  ).then((value) {
                    DialogUtil.showMessage(
                        context,
                        'Success',
                        posActionTitle: 'ok',
                        posAction: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }

                    );
                  });
                },
                child: Text('Assign the project to me '), style: ElevatedButton.styleFrom(
              primary: const Color(0xffEF7505),

            ),
            ),
          ],
        ),
      ),
    ),
  );
  
  Widget ProjecttWidget(BuildContext context, ProjectAssigned project , AppProvider provider) => Padding(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    project.projectTitle!,
                    style: Styles.styleBold16,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                      '${project.projectDescription}' ,
                      style: Styles.style12
                  ),
                  SizedBox(height: 8.h),
                  Flexible(
                    child: Text(
                        ' ${project.enrolledStudents}',
                        style: Styles.style12
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Flexible(
                    child: Text(
                        'Leader Name ; ${project.leader}',
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
  );
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onPositive;
  final Function()? onNegative;
  final String? positiveButtonText;
  final String? negativeButtonText;

  CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    this.onPositive,
    this.onNegative,
    this.positiveButtonText,
    this.negativeButtonText,
  }) : super(key: key);

  TextEditingController secretCodeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Styles.styleBold18,
          ),
        ],
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: Styles.style14.copyWith(
                  color: Colors.grey
              ),
            ),
            SizedBox(height: 20.h),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter the secret code',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                onNegative?.call();
                Navigator.of(context).pop();
              },
              child: Text(
                negativeButtonText ?? 'Cancel',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 30.w
                ),
                primary: const Color(0xffEF7505),
              ),
              onPressed: () {
                onPositive?.call();
                if(formKey.currentState!.validate()){
                  // navigateTo(context, const TeamJoinedScreen());
                }
              },
              child: Text(
                positiveButtonText ?? 'OK',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
