import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/provider/provider.dart';
import 'package:management_system_final_doctor/shared/components.dart';

import 'package:provider/provider.dart';

class AttendanceListScreen extends StatefulWidget {
  final String courseID;

  const AttendanceListScreen({required this.courseID, Key? key}) : super(key: key);
  @override
  _AttendanceListScreenState createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).fetchAttendanceData(widget.courseID);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: AppBar(
          backgroundColor: const Color(0xffF7F7F7),
        ),
        body: Center(
          child: Container(
            width: 426.w,
            height: 447.h,
            color: Colors.white,
            child: Column(
              children: [
                Text('Attendance List', style: TextStyle(fontSize: 20, color: Colors.black)),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.fetchAttendData!.length,
                    itemBuilder: (context, index) {
                      final item = provider.fetchAttendData![index];
                      final code = item.code as String;
                      final timestamp = item.attendanceTimeStamp as String;
                      return InkWell(
                        onTap: () {
                          navigateTo(context, AttendDataScreen(code: code));
                          print('Code: $code' );
                        },
                        child: ListTile(
                          title: Text('Code: $code' , style: TextStyle(fontSize: 16, color: Colors.black)),
                          subtitle: Text('Timestamp: $timestamp' , style: TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class AttendDataScreen extends StatefulWidget {
  final String code;

  AttendDataScreen({required this.code});

  @override
  _AttendDataScreenState createState() => _AttendDataScreenState();
}

class _AttendDataScreenState extends State<AttendDataScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).fetchAttendSessionDetails(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xffF7F7F7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Container(
            width: 426.w,
            height: 447.h,
            color: Colors.white,
            child: ListView.builder(
              itemCount: provider.fetchSessionDetails!.length,
              itemBuilder: (context, index) {
                final item = provider.fetchSessionDetails![index];
                final studentIds = item.studentID as List<dynamic>;
                final studentNames = item.studentName as List<dynamic>;
                final attendanceTimes = item.arrayAgg as List<dynamic>;
                return Column(
                  children: [
                    Text('Attendance Details', style: TextStyle(fontSize: 20, color: Colors.black)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: studentIds.length,
                      itemBuilder: (context, subIndex) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Student Details' , style: TextStyle(fontSize: 20, color: Colors.black) ),
                                  content: Text('Name: ${studentNames[subIndex]}\nID: ${studentIds[subIndex]}\nTime: ${attendanceTimes[subIndex]}' , style: TextStyle(fontSize: 16, color: Colors.black)),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ListTile(
                            title: Text('Student: ${studentNames[subIndex]}' , style: TextStyle(fontSize: 16, color: Colors.black)),
                            subtitle: Text('ID: ${studentIds[subIndex]}, Time: ${attendanceTimes[subIndex]}' , style: TextStyle(fontSize: 16, color: Colors.black)),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
