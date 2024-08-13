import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/provider/provider.dart';
import 'package:management_system_final_doctor/shared/components.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../shared/dialogUtil/dialog_util.dart';


class ExamScreen extends StatefulWidget {
  String? subjectID;
   ExamScreen({required this.subjectID , Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int? fullMark = 1;

  dynamic url = '';

  String? downloadUrl = '';

  GlobalKey<FormState> examFormKey = GlobalKey<FormState>();

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
            key: examFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Make Quiz',
                      style: Styles.styleBold20,
                    ),
                    SizedBox(height: 20.h),
                    defaultTextForm(
                      controller: provider.examTitleController,
                      type: TextInputType.text,
                      label: 'Exam Title',
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
                      controller: provider.examDescriptionController,
                      type: TextInputType.text,
                      label: 'Exam Description',
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter the description';
                        }
                        return null;
                      },
                      hintText: 'Enter the description',
                    ),
                    SizedBox(height: 20.h),
                    DropdownButtonFormField<int>(
                      value: fullMark,
                      decoration: InputDecoration(
                        labelText: 'Full Mark',
                        hintText: 'Select the full mark',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      items: List<DropdownMenuItem<int>>.generate(20, (index) => DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      )),
                      onChanged: (int? newValue) => setState(() => fullMark = newValue),
                      validator: (value) => value == null ? 'Please select the full mark' : null,
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: provider.examDateController,
                      decoration: InputDecoration(
                        labelText: 'Exam Date',
                        hintText: 'Enter the due date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(provider, context),
                        ),
                      ),
                      validator: (String? value) => value!.isEmpty ? 'Please enter the due date' : null,
                    ),
                    SizedBox(height: 20.h),
                    defaultButton(
                      background: const Color(0xffEF7505),
                      width: 320.w,
                      radius: 15,
                      function: () async {
                        if (examFormKey.currentState!.validate()) {
                          await provider.makeExam(
                            provider.examTitleController.text,
                            provider.examDescriptionController.text,
                            widget.subjectID,
                            fullMark,
                            CacheHelper.getData(key: 'doctorID'),
                            0,
                            provider.examDateController.text,
                            DateTime.now().toString(),
                          ).then((value){
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
                      text: 'Add Exam',
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

  Future<void> _selectDate(AppProvider provider, BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(picked);
      provider.examDateController.text = formattedDate;
    }
  }

}
