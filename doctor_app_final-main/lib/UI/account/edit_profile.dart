import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
          color:  Colors.white,
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: 61.w,
              vertical: 36.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Profile',
                    style:Styles.styleBold22,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                   Text(
                    'First Name',
                     style:Styles.style15,
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    initialValue: provider.firstName,
                    keyboardType: TextInputType.name,
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person,
                          color: Color(0xffEF7505)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 20.h,
                  ),
                   Text(
                    'Last Name',
                     style:Styles.style15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: provider.lastName,
                    keyboardType: TextInputType.name,
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person,
                          color: Color(0xffEF7505)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 20.h,
                  ),
                   Text(
                    'Email Address',
                     style:Styles.style15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: provider.emailController.text,
                    keyboardType: TextInputType.name,
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email,
                          color: Color(0xffEF7505)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 40.h,
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



// SizedBox(
//   width: double.infinity,
//   child: SizedBox(
//     height: 52,
//     child: ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor:
//             MaterialStateProperty.resolveWith((states) {
//           return const Color(0xffEF7505);
//         }),
//         shape: MaterialStateProperty.resolveWith((states) {
//           return RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//                 10), // Adjust the radius as needed
//           );
//         }),
//         minimumSize: MaterialStateProperty.all(const Size(
//             double.infinity, 200)), // Adjust the height as needed
//       ),
//       onPressed: () {
//         DialogUtil.showMessage(
//             context, "Data Updtaed Successfully",
//             posActionTitle: "Done",
//             posAction: () {
//               Navigator.pop(context);
//             },
//             isDismissAble: true);
//       },
//       child: const Text(
//         "Save Changes",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//         ),
//       ),
//     ),
//   ),
// ),