import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/provider.dart';
import '../../shared/components.dart';
import '../../shared/validationUtil/validation_util.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
      ),
      ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text('Forget Your Password' ,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  ),
                  SizedBox(height: 20.h),
                  Text('Enter your email address and we will send you a link to reset your password' ,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: const Color(0xff7A7A7A),
                    fontWeight: FontWeight.w400,
                  ),
                  ),
                  SizedBox(height: 24.h),
                  defaultTextForm(
                    controller: provider.resetPasswordEmailController,
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
                  const Spacer(),
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: provider.resetPasswordEmailController.text)
                              .then((value) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Reset Password'),
                                  content: const Text('Reset Password Email has been sent to your email address'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
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
