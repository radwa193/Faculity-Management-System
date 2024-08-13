import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/UI/classwork/Results/fill_result.dart';
import 'package:management_system_final_doctor/provider/provider.dart';
import 'package:management_system_final_doctor/shared/components.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:provider/provider.dart';


class ResultsScreen extends StatefulWidget {
  final String? courseId;

  const ResultsScreen({this.courseId, Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<ResultsScreen> {
  int? fullMark = 1;
  dynamic url = '';
  String? downloadUrl = '';
  String? examTitle;
  GlobalKey<FormState> resultFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int? doctorId = CacheHelper.getData(key: 'doctorID');
    Provider.of<AppProvider>(context, listen: false).examData = [];
    Provider.of<AppProvider>(context, listen: false).getExamData(doctorId , widget.courseId);
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
          onPressed: () {
            Navigator.pop(context);
            Provider.of<AppProvider>(context, listen: false).examsTitle = [];
          },
        ),
      ),
      body: Center(
        child: Container(
          height: 555.h,
          width: 600.w,
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          child: Form(
            key: resultFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Select Assignment or Quiz',
                      style: Styles.styleBold20,
                    ),
                    SizedBox(height: 20.h),
                    DropdownButtonFormField<String>(
                    value: examTitle, // Current selected exam title
                    decoration: InputDecoration(
                      labelText: 'Exam Title',
                      hintText: 'Select the Exam Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    items: (provider.examsTitle).map((examTitle) => DropdownMenuItem<String>(
                      value: examTitle,
                      child: Text(examTitle!),
                    )).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        examTitle = newValue;
                        int selectedIndex = provider.examsTitle.indexOf(newValue);
                        provider.selctedId = provider.examsIds[selectedIndex];
                      });
                    },
                    validator: (value) => value == null ? 'Please select the Exam Title' : null,
                  ),
                    SizedBox(
                      height : 20
                    ),
                    defaultButton(
                      background: const Color(0xffEF7505),
                      width: 320.w,
                      radius: 15,
                      function: () async {
                        if (resultFormKey.currentState!.validate()) {
                          navigateTo(context , FillResultsScreen(
                            subjectID: widget.courseId,
                            assignmentId: provider.selctedId,
                          ) );
                        }
                      },
                      text: 'Next',
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


  void _openFileExplorer() async {
    print('Starting file selection...');
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true);
      if (result != null) {
        print('File selected: ${result.files.single.name}');
        final storageRef = FirebaseStorage.instance.ref();
        final fileRef = storageRef.child(result.files.single.name);

        if (kIsWeb) {
          Uint8List fileBytes = result.files.single.bytes!;
          print('Uploading file on web...');
          try {
            TaskSnapshot uploadTaskSnapshot = await fileRef.putData(fileBytes);
            print('File Uploaded');
            // Update the class-level downloadUrl variable
            downloadUrl = await fileRef.getDownloadURL();
            print('Download URL: $downloadUrl');
          } catch (e) {
            print('Error uploading file: $e');
          }
        } else {
          // Ensure this block is only for non-web platforms since 'path' is not supported on web
          File file = File(result.files.single.path!);
          print('Uploading file on mobile/desktop...');
          try {
            TaskSnapshot uploadTaskSnapshot = await fileRef.putFile(file);
            print('File Uploaded');
            // Update the class-level downloadUrl variable
            downloadUrl = await fileRef.getDownloadURL();
            print('Download URL: $downloadUrl');
          } catch (e) {
            print('Error uploading file: $e');
          }
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }


  Future<void> _selectDate(AppProvider provider, BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      provider.assignmentDeadlineIdController.text = picked.toString();
    }
  }
}

class DashedRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
