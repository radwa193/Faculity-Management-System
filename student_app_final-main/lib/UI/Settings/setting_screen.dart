import 'dart:typed_data';
import 'package:final_student_version/UI/Settings/terms&conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Network/local/cache_helper.dart';
import '../../shared/dialogUtil/dialog_util.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';
import '../Login/login_screen.dart';
import 'edit_profile.dart';
import '../home/student/notification.dart';
import 'app_setings.dart';
import 'change_password_page.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadStudentName();
    String? studentId = CacheHelper.getData(key: 'userId');
    Provider.of<AppProvider>(context, listen: false).getStudentPhoto(studentId);
    print(CacheHelper.getData(key: 'studentPhoto'));
  }

  String? studentName;
  Future<void> _loadStudentName() async {
    setState(() {
      studentName = CacheHelper.getData(key : 'studentName');
    });
  }

  Uint8List decodeHex(String hexString) {
    // Remove the "\\x" characters if present
    if (hexString.startsWith('\\x')) {
      hexString = hexString.substring(3);
    }
    return Uint8List.fromList(List<int>.from(hexString.split('').map<int>((e) => int.parse(e, radix: 16))));
  }



  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: NetworkImage(
                        '${CacheHelper.getData(key: 'studentPhoto')}',
                      ),
                    ),                  ],
                ),
                  SizedBox(
                    height: 20.h,
                  ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      studentName!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: 5.h,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${CacheHelper.getData(key: 'userId')}@o6u.edu.eg',
                      style:  TextStyle(
                        color: const Color(0xff86878B),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const EditProfile());
                  },
                  child:  Row(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/images/icons/edit.png'),
                        size: 40,
                        color: Color(0xffEF7505),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xffEF7505),
                      )
                    ],
                  ),
                ),
                 SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const ChangePasswordScreen());
                  },
                  child:  Row(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/images/icons/Lock .png'),
                        size: 40,
                        color: Color(0xffEF7505),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Change Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xffEF7505),
                      )
                    ],
                  ),
                ),
                 SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const AppSettingsScreen());
                  },
                  child:  Row(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/images/icons/settings.png'),
                        size: 40,
                        color: Color(0xffEF7505),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'App Settings',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xffEF7505),
                      )
                    ],
                  ),
                ),
                 SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const NotificationScreen());
                  },
                  child:  Row(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/images/icons/noti.png'),
                        size: 40,
                        color: Color(0xffEF7505),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Recent Notifications',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xffEF7505),
                      )
                    ],
                  ),
                ),
                 SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const TermsScreen());
                  },
                  child:  Row(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/images/icons/terms.png'),
                        size: 40,
                        color: Color(0xffEF7505),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Terms & Conditions',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xffEF7505),
                      )
                    ],
                  ),
                ),
               SizedBox(
                height : 30.h
              ),
              InkWell(
                onTap: () {
                  DialogUtil.showMessage(
                    context,
                    'Logout \n Are you sure you want to logout?',
                    isDismissAble: true,
                    posAction: () async{
                      if(CacheHelper.getData(key: 'studentToken') != null) {
                        CacheHelper.removeData(key: 'studentToken');
                        provider.userId = '';
                        CacheHelper.removeData(key: 'userId');
                        provider.studentCurrentIndex = 0;
                        provider.clearAllData();
                        CacheHelper.removeData(key : 'studentName');
                        navigateTo(context, LoginScreen());
                      }
                    },
                    negAction: () {
                      Navigator.pop(context);
                    },
                    negActionTitle: 'Cancel',
                    posActionTitle: 'Log out',
                  );
                },
                child:  Row(
                  children: [
                    const ImageIcon(
                      AssetImage('assets/images/icons/logout.png'),
                      size: 40,
                      color: Color(0xffEF7505),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xffEF7505),
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
}


