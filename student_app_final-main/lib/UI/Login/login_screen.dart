import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import '../../Network/local/cache_helper.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';
import '../../shared/validationUtil/validation_util.dart';
import 'forget_password_Screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Scan your fingerprint (or face) to authenticate',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    print("Building TextFormField with isPassword = ${provider.isPassword}");
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(2),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20.w),
              margin: EdgeInsets.only(top: 30.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(
                      height: 39.h,
                    ),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Log into your account !",
                      style: TextStyle(
                        color: Color(0xff7A7A7A),
                        fontSize: 17.sp,
                        fontFamily: 'Poppins-Medium',
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
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
                      obscure: false,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    defaultTextForm(
                      pre: const Icon(Icons.lock_outline, color: Colors.black),
                      suf: Provider.of<AppProvider>(context, listen: false).suffix,
                      controller:  provider.passwordController,
                      type: TextInputType.visiblePassword,
                      label: "Password",
                      isPassword: Provider.of<AppProvider>(context, listen: true).isPassword,
                      obscure: Provider.of<AppProvider>(context, listen: true).isPassword,
                      validate: (text) {
                        if (text!.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        if (text.length < 6) {
                          return " Password Should be at least 6 characters";
                        }
                        return null;
                      },
                      suffixPressed: () {
                        provider.changeSuffixVisibility();
                      },
                      hintText: "hkljhaduy12784!@#",
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: SizedBox(
                        height: 40.h,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              return const Color(0xffEF7505);
                            }),
                            shape: MaterialStateProperty.resolveWith((states) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              );
                            }),
                            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 200)),
                          ),
                          onPressed: () async {
                            // if (await authenticate()) {
                              if (formKey.currentState!.validate()) {
                                CacheHelper.removeData(key: 'studentToken');
                                provider.loginToAccount(context, provider);
                              }
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text("Biometric authentication failed")),
                            //   );
                            // }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
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
          ),
        ),
      ),
    );
  }
}
