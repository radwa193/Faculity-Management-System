import 'package:final_student_version/UI/classwork/project/team_created_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Network/local/cache_helper.dart';
import '../../../provider/provider.dart';

class CreateTeamScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  CreateTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar : AppBar(
          backgroundColor: const Color(0xffF7F7F7),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:  Row(
            children: [
              Text(
                'Create Team',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xffF7F7F7),
        body : Padding(
          padding: EdgeInsets.all(24.0.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Project Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: provider.projectTitleController,
                  decoration: InputDecoration(
                      hintText: 'Enter Project Name',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffCCCCCC),
                          width: 0.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      )
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter project name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 22.h,
                ),
                Text('Project Description',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  maxLines: 10,
                  controller: provider.projectDescriptionController,
                  decoration: InputDecoration(
                      hintText: 'Enter Project Description',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      )
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter project description';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await provider.getGraduationProjectSecretKey(provider.projectTitleController.text);
                      if (provider.secretKey != '') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Alert"),
                              content: const Text("You have already created a team for this project."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        await provider.studentRegisterGraduationProject(
                          provider.projectTitleController.text,
                          provider.projectDescriptionController.text,
                          CacheHelper.getData(key: 'userId'),
                        ).then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TeamCreatedScreen()),
                          );
                        }).catchError((error) {
                          print("Failed to register project: $error");
                        });
                      }
                    }
                  },
                  child: const Text('Create Team'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffEF7505),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sw),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}