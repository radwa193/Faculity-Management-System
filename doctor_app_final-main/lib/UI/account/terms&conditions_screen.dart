import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/style/fonts.dart';


class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _EditProfileState();
}

class _EditProfileState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
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
      body:  Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 24.0.w ,
            vertical: 20.0.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: Styles.styleBold22,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
    'L15.1 Thank you for visiting our Application Doctor 24×7 and enrolling as a member \n \n'
    '15.2 Your privacy is important to us. To better protect your privacy, we are providing this notice explaining our policy with regards to the information you share with us. This privacy policy relates to the information we collect, online from Application, received through the email, by fax or telephone, or in person or in any other way and retain and use for the purpose of providing you services. If you do not agree to the terms in this Policy, we kindly ask you not to use these portals and/or sign the contract document\n \n'
    '15.3 In order to use the services of this Application, You are required to register yourself by verifying the authorised device. This Privacy Policy applies to your information that we collect and receive on and through Doctor 24×7; it does not apply to practices of businesses that we do not own or control or people we do not employ',
                style: Styles.style14,
                ),
          ],
        ),
      ),
    );
  }
}



