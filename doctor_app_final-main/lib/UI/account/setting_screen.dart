import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/UI/account/notification.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';
import 'app_setings.dart';
import 'change_password_page.dart';
import 'edit_profile.dart';
import 'terms&conditions_screen.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<AccountScreen> {
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
                        '${CacheHelper.getData(key: 'photo')}',
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
                      '${CacheHelper.getData(key: 'doctorName')}',
                      style: Styles.style20,
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
                      provider.emailController.text,
                      style:  Styles.style15.copyWith(
                        color: const Color(0xff86878B)
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
                        style: Styles.style20,
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
                        style: Styles.style20,
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
                        style: Styles.style20,
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
                        style: Styles.style20,
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
                        style: Styles.style20,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xffEF7505),
                      )
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

