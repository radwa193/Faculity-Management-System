import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          'Change Password',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        color: const Color(0xffF7F7F7),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(
                height: 20.h,
              ),
               Text(
                'Old Password',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
               SizedBox(
                height: 10.h,
              ),
              defaultTextForm(
                pre: const Icon(Icons.lock_outline, color: Color(0xffEF7505)),
                suf: provider.suffix,
                controller: provider.oldPasswordController,
                type: TextInputType.visiblePassword,
                obscure: false,
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
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
               SizedBox(
                height: 10.h,
              ),
              defaultTextForm(
                pre: const Icon(Icons.lock_outline, color: Color(0xffEF7505)),
                suf: provider.suffix,
                controller: provider.newPasswordController,
                type: TextInputType.visiblePassword,
                obscure: true,
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
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
               SizedBox(
                height: 10.h,
              ),
              defaultTextForm(
                pre: const Icon(Icons.lock_outline, color: Color(0xffEF7505)),
                suf: provider.suffix,
                controller: provider.confirmPasswordController,
                type: TextInputType.visiblePassword,
                obscure: true,
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
                              10), // Adjust the radius as needed
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
    );
  }
}
