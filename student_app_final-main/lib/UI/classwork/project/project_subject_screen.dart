import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../../../Network/local/cache_helper.dart';
import '../../../provider/provider.dart';
import '../../../shared/components.dart';
import '../../states/team_joined_screen.dart';
import 'create_team_screen.dart';

class ProjectSubjectScreen extends StatefulWidget {
  String subjectID;
   ProjectSubjectScreen({required this.subjectID , Key? key}) : super(key: key);

  @override
  State<ProjectSubjectScreen> createState() => _ProjectSubjectScreenState();
}

class _ProjectSubjectScreenState extends State<ProjectSubjectScreen> {
  @override
  void initState() {
    super.initState();
    String? studentId = CacheHelper.getData(key: 'userId');
    Provider.of<AppProvider>(context, listen: false).joinJp = [];
    Provider.of<AppProvider>(context, listen: false).studentEnrolledToGp =[];
    Provider.of<AppProvider>(context, listen: false).studentEnrolledToGP(studentId);
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
        title: Text(
          'Project 1',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
      ),
      backgroundColor: const Color(0xffF7F7F7),
      body: Padding(
        padding: EdgeInsets.all(24.0.w),
        child: provider.studentEnrolledToGp.isEmpty ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                navigateTo(context, CreateTeamScreen());
              },
              child: Container(
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage('assets/images/classwork_icons/create_team.png'),
                      size: 100.sp,
                      color: const Color(0xffEF7505),
                    ),
                    const SizedBox(height: 13),
                    Text(
                      'Create Team',
                      style: TextStyle(
                        color: const Color(0xff2C2828),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 17.h),
            InkWell(
              onTap: () {
                _showJoinTeamDialog(context);
              },
              child: Container(
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage('assets/images/classwork_icons/join_team.png'),
                      size: 100.sp,
                      color: const Color(0xffEF7505),
                    ),
                    SizedBox(height: 13.h),
                    Text(
                      'Join Team',
                      style: TextStyle(
                        color: const Color(0xff2C2828),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ) : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Title : ',
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w800,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                provider.studentEnrolledToGp[0].projectTitle!,
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w500,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                'Project Description : ',
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w800,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                provider.studentEnrolledToGp[0].projectDescription!,
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                'Team Members : ',
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w800,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(height: 17.h),
              Row(
                children: [
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(provider.studentEnrolledToGp[0].studentName![index]),
                      );
                    },
                      itemCount: provider.studentEnrolledToGp[0].studentName!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(child: Image.asset('assets/images/icons/grad.png'))
                ],
              ),
              Text(
                'Supervisor Doctor : ',
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w800,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                provider.studentEnrolledToGp[0].profName == '   ' ? 'No Supervisor Doctor' : provider.studentEnrolledToGp[0].profName!,
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                'Supervisor Teaching Assistant : ',
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w800,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                provider.studentEnrolledToGp[0].tAName == '   ' ? 'No Supervisor Doctor' : provider.studentEnrolledToGp[0].tAName!,
                style: TextStyle(
                  color: const Color(0xff2C2828),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJoinTeamDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        context: context,
        title: 'Join Team',
        message: 'Enter the team code to join the team',
        onPositive: () {
          print('Join Team');
        },
        positiveButtonText: 'Join',
        onNegative: () {
          Navigator.pop(context);
        },
        negativeButtonText: 'Cancel',
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String message;
  final Function()? onPositive;
  final Function()? onNegative;
  final String? positiveButtonText;
  final String? negativeButtonText;

   CustomDialog({
    Key? key,
    required this.context,
    required this.title,
    required this.message,
    this.onPositive,
    this.onNegative,
    this.positiveButtonText,
    this.negativeButtonText,
  }) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
                fontWeight: FontWeight.bold , color: Colors.black),
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
              style:  TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal , color: Colors.grey),
            ),
            SizedBox(height: 20.h),
            defaultTextForm(
                controller: provider.secretCodeController,
                type: TextInputType.text,
                label: "Secret Code",
                validate: (value){
                  if(provider.secretCodeController.text.isEmpty){
                    return 'Please enter the secret code';
                  }
                  return null;
                },
                hintText: "Enter the secret code"
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
              onPressed: () async{
                onPositive?.call();
                if(formKey.currentState!.validate()){
                  provider.studentJoinGP(
                    provider.secretCodeController.text,
                  ).then((value) {
                    if(provider.joinJp.isEmpty){
                      return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Invalid Secret Code'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Provider.of<AppProvider>(context, listen: false).joinJp = [];
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }if(provider.joinJp[0].studentsCount == 7){
                      return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Team is full'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }else{
                      provider.studentJoinGraduationProject(
                          provider.joinJp[0].projectID,
                          CacheHelper.getData(key: 'userId'),
                      ).then((value) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text('You have successfully joined the team'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        navigateTo(context, const TeamJoinedScreen());
                      });
                    }
                  });
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
