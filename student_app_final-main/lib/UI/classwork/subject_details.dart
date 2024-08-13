import 'package:final_student_version/UI/classwork/sections/sections_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../ayyend.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';
import '../../shared/qrCodeFunctions/qrCodeFunctions.dart';
import 'Assignment/assignments_page.dart';
import 'lectures/lectures_screen.dart';
import 'results/results_screen.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final String subjectID;

  const SubjectDetailsScreen({Key? key, required this.subjectID}) : super(key: key);

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
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
        title: Row(
          children: [
            Text(
              'Classwork',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ServiceTile(
            path : 'assets/images/classwork_icons/attendance.png',
            serviceName: 'Take Attendance',
            onTap: () {
              dynamic dataScanned = QrCodeFunctions.scanQrCode();
              navigateTo(context, DecryptionWidget(
                encryptedText: dataScanned,
              ));
            },
          ),
          ServiceTile(
            path: 'assets/images/classwork_icons/assignment.png',
            serviceName: 'Assignments',
            onTap: () {
              navigateTo(context, AssignmentsScreen(subjectID: widget.subjectID));
            },
          ),
          ServiceTile(
            path: 'assets/images/classwork_icons/lectures.png',
            serviceName: 'View Lectures',
            onTap: () {
              navigateTo(context, LecturesScreen(subjectID: widget.subjectID));
            },
          ),
          ServiceTile(
            path: 'assets/images/classwork_icons/section.png',
            serviceName: 'View Sections',
            onTap: () {
              navigateTo(context, SectionsScreen(subjectID: widget.subjectID));
            },
          ),
          ServiceTile(
            path:'assets/images/classwork_icons/result.png',
            serviceName: 'View Results',
            onTap: () {
              navigateTo(context, ResultsScreen(
                subjectID: widget.subjectID,
              ));
            },
          ),
        ],
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
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            AssetImage('$path'),
            color: Colors.orange,
          ),
          title: Text(
            serviceName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          tileColor: Colors.transparent,
          onTap: onTap,
        ),
      ),
    );
  }
}


