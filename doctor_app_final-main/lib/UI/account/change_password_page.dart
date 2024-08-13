import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';

import '../../shared/dialogUtil/dialog_util.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          height: 555.h,
          width: 458.w,
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: 61.h,
              vertical: 36.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Password',
                    style:Styles.style22,
                  ),
                   SizedBox(
                    height: 20.h,
                  ),
                   Text(
                    'Old Password',
                     style:Styles.style15,
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  defaultTextForm(
                    pre: const Icon(Icons.lock_outline, color: Color(0xffEF7505)),
                    suf: provider.suffix,
                    controller: provider.oldPasswordController,
                    type: TextInputType.visiblePassword,
                    obsecure: true,
                    label: "Old Password",
                    isPassword: provider.isPassword,
                    validate: (text) {
                      if (text!.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (text.length < 6) {
                        return "Password should be at least 6 characters";
                      }
                      return null;
                    },
                    suffixPressed: () {
                      provider.changeSuffixVisibility();
                    },
                    hintText: "Enter old password",
                  ),
                   SizedBox(
                    height: 20.h,
                  ),
                   Text(
                    'New Password',
                     style:Styles.style15,
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  defaultTextForm(
                    pre: const Icon(Icons.lock_outline, color: Color(0xffEF7505)),
                    suf: provider.suffix,
                    controller: provider.newPasswordController,
                    type: TextInputType.visiblePassword,
                    obsecure: true,
                    label: "New Password",
                    isPassword: provider.isPassword,
                    validate: (text) {
                      if (text!.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (text.length < 6) {
                        return "Password should be at least 6 characters";
                      }
                      return null;
                    },
                    suffixPressed: () {
                      provider.changeSuffixVisibility();
                    },
                    hintText: "Enter new password",
                  ),
                   SizedBox(
                    height: 20.h,
                  ),
                   Text(
                    'Confirm Password',
                     style:Styles.style15,
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  defaultTextForm(
                    pre: const Icon(Icons.lock_outline, color: Color(0xffEF7505)),
                    suf: provider.suffix,
                    controller: provider.confirmPasswordController,
                    type: TextInputType.visiblePassword,
                    obsecure: true,
                    label: "Confirm Password",
                    isPassword: provider.isPassword,
                    validate: (text) {
                      if (text!.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (text.length < 6) {
                        return "Password should be at least 6 characters";
                      }
                      return null;
                    },
                    suffixPressed: () {
                      provider.changeSuffixVisibility();
                    },
                    hintText: "Confirm new password",
                  ),
                   SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SizedBox(
                      height: 52.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                            return const Color(0xffEF7505);
                          }),
                          shape: MaterialStateProperty.resolveWith((states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10),
                            );
                          }),
                          minimumSize: MaterialStateProperty.all( Size(
                              double.infinity, 200.h)),
                        ),
                        onPressed: () async{
                          if (provider.newPasswordController.text !=
                              provider.confirmPasswordController.text) {
                            DialogUtil.showMessage(
                              context,
                              "Password does not match",
                              posActionTitle: "Done",
                              posAction: () {
                                Navigator.pop(context);
                              },
                              isDismissAble: true,
                            );
                          } else {
                            // Passwords match, update the password
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              await user.updatePassword(provider.newPasswordController.text).then((value) =>
                                  DialogUtil.showMessage(
                                    context,
                                    "Password Updated Successfully",
                                    posActionTitle: "Done",
                                    posAction: () {
                                      Navigator.pop(context);
                                      provider.newPasswordController.clear();
                                      provider.confirmPasswordController.clear();
                                      provider.oldPasswordController.clear();
                                    },
                                    isDismissAble: true,
                                  )).catchError((e) {
                                DialogUtil.showMessage(
                                  context,
                                  e.toString(),
                                  posActionTitle: "Done",
                                  posAction: () {
                                    Navigator.pop(context);
                                  },
                                  isDismissAble: true,
                                );
                              }
                              );
                            }
                          }
                        },
                        child:  Text(
                          "Save",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
