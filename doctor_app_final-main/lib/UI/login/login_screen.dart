import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/UI/login/forget_password_Screen.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';
import '../../Network/local/cache_helper.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';
import '../../shared/validationUtil/validation_util.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      body: Form(
        key: formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children at the top
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/onboarding/login_logo@1x.png',
                          width: 150.w,
                          height: 150.h,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    SizedBox(height: 39.h),
                    Text(
                      "Welcome Back",
                      style: Styles.styleBold28,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Log into your account !",
                        style: Styles.style17.copyWith(
                          color: Color(0xff7A7A7A))
                        ),
                    SizedBox(height: 50.h),
                    Text(
                      'Email',
                      style: Styles.style16
                    ),
                    SizedBox(height: 10.h),
                    defaultTextForm(
                      controller: provider.emailController,
                      type: TextInputType.emailAddress,
                      label: "Email Address",
                      pre: const Icon(Icons.email_outlined, color: Colors.black),
                      validate: (text) {
                        if (text!.isEmpty) {
                          return 'Email Address cannot be empty';
                        }
                        if (!isValidEmail(provider.emailController.text)) {
                          return "Enter Email in Valid Form";
                        }
                        return null;
                      },
                      hintText: "John.smith@gmail.com",
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Password',
                        style: Styles.style16
                    ),
                    SizedBox(height: 10.h),
                    defaultTextForm(
                      pre: const Icon(Icons.lock_outline, color: Colors.black),
                      suf: provider.suffix,
                      controller: provider.passwordController,
                      type: TextInputType.visiblePassword,
                      label: "Password",
                      obsecure: provider.isPassword,
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
                      hintText: "hkljhaduy12784!@#",
                    ),
                    SizedBox(height: 40.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            return const Color(0xffEF7505);
                          }),
                          shape: MaterialStateProperty.resolveWith((states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.sh),
                            );
                          }),
                          minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 50.h),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            provider.loginToAccount(context, provider);
                          }
                        },
                        child: Text(
                          "Login",
                            style: Styles.styleBold20
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            navigateTo(context, const ForgetPasswordScreen());
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: const Color(0xff7A7A7A),
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/light/login.png',
                height: MediaQuery.of(context).size.height, // Adjust height to fill the screen
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
