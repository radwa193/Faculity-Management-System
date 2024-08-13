import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/attend.dart';
import 'package:management_system_final_doctor/provider/provider.dart';
import 'package:management_system_final_doctor/shared/components.dart';
import 'package:management_system_final_doctor/shared/dialogUtil/dialog_util.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AssignmentsScreen extends StatefulWidget {
  final String? courseId;

  const AssignmentsScreen({this.courseId, Key? key}) : super(key: key);

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  File? _selectedFile;
  Uint8List? bytes;
  int? fullMark = 1;
  dynamic url = '';
  String? downloadUrl = '';
  GlobalKey<FormState> assignmentFormKey = GlobalKey<FormState>();

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
            key: assignmentFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Make Assignment',
                      style: Styles.styleBold20,
                    ),
                    SizedBox(height: 20.h),
                    defaultTextForm(
                      controller: provider.assignmentTitleController,
                      type: TextInputType.text,
                      label: 'Assignment Title',
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
                      controller: provider.assignmentDescriptionController,
                      type: TextInputType.text,
                      label: 'Assignment Description',
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
                      controller: provider.assignmentDeadlineIdController,
                      decoration: InputDecoration(
                        labelText: 'Due Date',
                        hintText: 'Enter the due date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(provider, context),
                        ),
                      ),
                      validator: (String? value) => value!.isEmpty ? 'Please enter the due date' : null,
                    ),
                    SizedBox(height: 20.h),
                    _selectedFile != null ? GestureDetector(
                      onTap: _openFileExplorer,
                      child: SizedBox(
                        width: 292,
                        height: 170,
                        child: Stack(
                          children: [
                            CustomPaint(
                              painter: DashedRectPainter(),
                              child: Container(
                                width: 292,
                                height: 170,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: _selectedFile == null ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ImageIcon(
                                    AssetImage('assets/images/classwork_icons/assignment.png'),
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Drag & Drop or choose file to upload',
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Select Zip, image, pdf or ms.word',
                                    style: TextStyle(color: Color(0xff515978), fontSize: 14),
                                  ),
                                ],
                              ) : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.attach_file, size: 50),
                                  const SizedBox(height: 10),
                                  Text(
                                    path.basename(_selectedFile!.path),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )  : GestureDetector(
                      onTap: _openFileExplorer,
                      child: SizedBox(
                        width: 292,
                        height: 170,
                        child: Stack(
                          children: [
                            CustomPaint(
                              painter: DashedRectPainter(),
                              child: Container(
                                width: 292,
                                height: 170,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: _selectedFile == null ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ImageIcon(
                                    AssetImage('assets/images/classwork_icons/assignment.png'),
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Drag & Drop or choose file to upload',
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Select Zip, image, pdf or ms.word',
                                    style: TextStyle(color: Color(0xff515978), fontSize: 14),
                                  ),
                                ],
                              ) : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.attach_file, size: 50),
                                  const SizedBox(height: 10),
                                  Text(
                                    path.basename(_selectedFile!.path),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    defaultButton(
                      background: const Color(0xffEF7505),
                      width: 320.w,
                      radius: 15,
                      function: () async {
                        if (assignmentFormKey.currentState!.validate()) {
                          await provider.assignAssignment(
                            provider.assignmentTitleController.text,
                            provider.assignmentDescriptionController.text,
                            widget.courseId,
                            CacheHelper.getData(key: 'doctorID'),
                            1,
                            fullMark,
                            provider.assignmentDeadlineIdController.text,
                            DateTime.now().toString(),
                            downloadUrl,
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
                      text: 'Add Assignment',
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
  String _sanitizeFileName(String fileName) {
    // Replace invalid characters with underscores or remove them
    return fileName.replaceAll(RegExp(r'[^\w\s.-]'), '_');
  }
  void _openFileExplorer() async {
    print('Starting file selection...');
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true);
      if (result != null) {
        print('File selected: ${result.files.single.name}');
        String originalFileName = result.files.single.name;
        String fileName = _sanitizeFileName(originalFileName);

        if (kIsWeb) {
          Uint8List fileBytes = result.files.single.bytes!;
          print('Uploading file on web...');
          try {
            final response = await Supabase.instance.client.storage
                .from('Files')
                .uploadBinary(fileName, fileBytes);

            if (response != null) {
              print('Error uploading file: ${response}');
            } else {
              print('File Uploaded');
              final downloadUrlResponse = await Supabase.instance.client.storage
                  .from('Files')
                  .createSignedUrl(fileName, 60);
              if (downloadUrlResponse != null) {
                print('Error creating signed URL: ${downloadUrlResponse}');
              } else {
                downloadUrl = downloadUrlResponse ?? '';
                print('Download URL: $downloadUrl');
              }
            }
          } catch (e) {
            print('Exception while uploading file: $e');
          }
        } else {
          File file = File(result.files.single.path!);
          print('Uploading file on mobile/desktop...');
          try {
            final response = await Supabase.instance.client.storage
                .from('Files')
                .upload(fileName, file);

            if (response != null) {
              print('uploaded file: ${response}');
            } else {
              print('File Uploaded');
              final downloadUrlResponse = await Supabase.instance.client.storage
                  .from('Files')
                  .createSignedUrl(fileName, 60);
              if (downloadUrlResponse != null) {
                print('Error creating signed URL: ${downloadUrlResponse}');
              } else {
                downloadUrl = downloadUrlResponse ?? '';
                print('Download URL: $downloadUrl');
              }
            }
          } catch (e) {
            print('Exception while uploading file: $e');
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
