import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../provider/provider.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/UI/login/login_screen.dart';
import 'package:management_system_final_doctor/shared/components.dart';
import 'package:management_system_final_doctor/shared/dialogUtil/dialog_util.dart';
import 'package:management_system_final_doctor/style/fonts.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({Key? key}) : super(key: key);

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).doctorCurrentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 40.h,
                  horizontal: 34.w,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        provider.changeDoctorBottomNav(0);
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/onboarding/login_logo@1x.png', height: 50.h),
                          SizedBox(width: 20.w),
                          Text(
                              'O6U',
                              style: Styles.styleBold32.copyWith(
                                  color: const Color(0xffF27B35)
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    InkWell(
                      onTap: () => provider.changeDoctorBottomNav(0),
                      child: BottomNavTile(
                        iconPath: 'assets/images/icons/Vector.png',
                        label: 'Home',
                        isSelected: provider.doctorCurrentIndex == 0,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () => provider.changeDoctorBottomNav(1),
                      child: BottomNavTile(
                        iconPath: 'assets/images/icons/Message.png',
                        label: 'Chats',
                        isSelected: provider.doctorCurrentIndex == 1,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () => provider.changeDoctorBottomNav(2),
                      child: BottomNavTile(
                        iconPath: 'assets/images/icons/Book.png',
                        label: 'Classwork',
                        isSelected: provider.doctorCurrentIndex == 2,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () => provider.changeDoctorBottomNav(3),
                      child: BottomNavTile(
                        iconPath: 'assets/images/icons/settings.png',
                        label: 'Settings',
                        isSelected: provider.doctorCurrentIndex == 3,
                      ),
                    ),
                    const Spacer(),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        DialogUtil.showMessage(
                          context,
                          'Logout \n Are you sure you want to logout?',
                          isDismissAble: true,
                          posAction: () async {
                            if (CacheHelper.getData(key: 'doctorToken') != null) {
                              CacheHelper.removeData(key: 'doctorToken');
                              provider.clearAllData();
                              CacheHelper.removeData(key: 'doctorID');
                              CacheHelper.removeData(key: 'doctorName');
                              CacheHelper.removeData(key: 'photo');
                              navigateAndFinish(context, LoginScreen());
                            }
                          },
                          negAction: () {
                            Navigator.pop(context);
                          },
                          negActionTitle: 'Cancel',
                          posActionTitle: 'Log out',
                        );
                      },
                      child: Row(
                        children: [
                          ImageIcon(
                            const AssetImage('assets/images/icons/logout.png'),
                            color: const Color(0xff4D4D4D),
                            size: 35.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Log out',
                            style: TextStyle(
                              color: const Color(0xff4D4D4D),
                              fontSize: 18.sp,
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
          Expanded(
            flex: 4,
            child: provider.doctorBottomScreens[provider.doctorCurrentIndex],
          ),
        ],
      ),
    );
  }
}

class BottomNavTile extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;

  const BottomNavTile({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? const Color(0xffFBD8C3) : null,
      ),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(iconPath),
            color: isSelected ? const Color(0xffF27B35) : const Color(0xff797C7B),
            size: 35.sp,
          ),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xffF27B35) : const Color(0xff797C7B),
              fontSize: 18.sp,
              fontWeight: isSelected ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }
}
