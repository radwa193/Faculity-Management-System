import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Network/local/cache_helper.dart';
import '../../../provider/provider.dart';
import '../../../shared/dialogUtil/dialog_util.dart';

class TeamCreatedScreen extends StatefulWidget {
  const TeamCreatedScreen({Key? key}) : super(key: key);

  @override
  State<TeamCreatedScreen> createState() => _TeamCreatedScreenState();
}

class _TeamCreatedScreenState extends State<TeamCreatedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? title = Provider.of<AppProvider>(context, listen: false).projectTitleController.text;
    Provider.of<AppProvider>(context, listen: false).getGraduationProjectSecretKey(title);
    String? studentId = CacheHelper.getData(key: 'userId');
    int? projectId = Provider.of<AppProvider>(context, listen: false).graduationProjectId;
    Provider.of<AppProvider>(context, listen: false).addStudentGraduationProject(studentId, projectId!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/images/classwork_icons/team_created.png'),
                width: 210.w,
                height: 210.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text('Team Created Successfully' ,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color : Colors.black
                  ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You can now invite your friends to join your team' ,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff999999)
                  ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      Provider.of<AppProvider>(context, listen: false).secretKey == '' ? "" :'Your team secret key is : ${Provider.of<AppProvider>(context, listen: false).secretKey}' ,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xff999999)
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffEF7505),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: Provider.of<AppProvider>(context, listen: false).secretKey!));
                        DialogUtil.showMessage(context, "The secret key has been copied to your clipboard" , posActionTitle: "OK" , posAction: () {
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffEF7505),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                      ),
                      child: const Text('Copy to Clipboard'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        ),
    );
  }
}
