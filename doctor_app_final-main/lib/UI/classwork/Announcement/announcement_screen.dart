
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/provider/provider.dart';
import 'package:management_system_final_doctor/shared/components.dart';
import 'package:management_system_final_doctor/shared/dialogUtil/dialog_util.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';

class AnnouncementScreen extends StatefulWidget {
  final String? courseId;

  const AnnouncementScreen({this.courseId, Key? key}) : super(key: key);

  @override
  State<AnnouncementScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AnnouncementScreen> {
  GlobalKey<FormState> announcementFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getCourseStudents(widget.courseId);
  }
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          height: 555.h,
          width: 600.w,
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          child: Form(
            key: announcementFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Make Announcement',
                      style: Styles.styleBold20,
                    ),
                    SizedBox(height: 20.h),
                    defaultTextForm(
                      controller: provider.announcementTitleController,
                      type: TextInputType.text,
                      label: 'Announcement Title',
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter the title';
                        }
                        return null;
                      },
                      hintText: 'Enter the title',
                    ),
                    SizedBox(height: 20.h),
                    defaultTextForm(
                      controller: provider.announcementDescriptionController,
                      type: TextInputType.text,
                      label: 'Announcement Description',
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter the description';
                        }
                        return null;
                      },
                      hintText: 'Enter the description',
                    ),
                    SizedBox(height: 20.h),
                    defaultButton(
                      background: const Color(0xffEF7505),
                      width: 320.w,
                      radius: 15,
                      function: () async {
                        if (announcementFormKey.currentState!.validate()) {
                          await provider.makeAnnouncement(
                            provider.announcementTitleController.text,
                            provider.announcementDescriptionController.text,
                            DateTime.now().toString(),
                            CacheHelper.getData(key: 'doctorID'),
                              provider.courseStudents
                          ).then((value) {
                            print(provider.courseStudents);
                            DialogUtil.showMessage(
                                context,
                                'Success',
                                posActionTitle: 'ok',
                                posAction: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                            );
                          });
                        }
                      },
                      text: 'Add Announcement',
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
