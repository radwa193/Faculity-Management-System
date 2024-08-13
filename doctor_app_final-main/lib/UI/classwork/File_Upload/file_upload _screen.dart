import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/style/fonts.dart';
import 'package:path/path.dart' as path;

class FileUploadScreen extends StatefulWidget {
  FileUploadScreen({super.key});

  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          vertical: 50.h,
          horizontal: 100.w
        ),
        child: Center(
          child: Container(
            height: 939.h,
            width: 726.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.h),
              color: Colors.white,
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(
                vertical: 83.h,
                horizontal: 223.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Upload The Document',
                        style: Styles.style20,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () => _openFileExplorer(),
                    child: SizedBox(
                      width: 292.w,
                      height: 170.h,
                      child: Stack(
                        children: [
                          CustomPaint(
                            painter: DashedRectPainter(),
                            child: SizedBox(
                              width: 292.w,
                              height: 170.h,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: _selectedFile == null
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage(
                                      'assets/images/classwork_icons/assignment.png'),
                                  size: 50.sp,
                                  color: Colors.grey[800],
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Drag & Drop or choose file to upload',
                                      style: Styles.style14,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Select Zip, image, pdf or ms.word',
                                  style: Styles.style14.copyWith(
                                    color: const Color(0xff515978)
                                  ),
                                ),
                              ],
                            )
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.attach_file, size: 50),
                                SizedBox(height: 10.h),
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _uploadFile(),
                          style: ElevatedButton.styleFrom(
                            padding:  EdgeInsets.symmetric(
                                vertical: 12.h
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            primary: const Color(0xffECEDF2),
                            onPrimary: Colors.black,
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _uploadFile(),
                          style: ElevatedButton.styleFrom(
                            padding:  EdgeInsets.symmetric(
                                vertical: 12.h
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            primary: const Color(0xffEF7505),
                            onPrimary: Colors.white,
                          ),
                          child: const Text('Upload'),
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
    );
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
    } else {
      // User canceled the picker
    }
  }

  void _uploadFile() {
    if (_selectedFile != null) {
      print('Uploading file: ${_selectedFile!.path}');
      setState(() {
        _selectedFile = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No File Selected'),
            content: const Text('Please select a file to upload.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class DashedRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xffD5D8E2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double dashWidth = 5;
    double dashSpace = 5;

    // Top border
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }

    // Right border
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width, startY), Offset(size.width, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    // Bottom border
    startX = size.width;
    while (startX > 0) {
      canvas.drawLine(Offset(startX, size.height), Offset(startX - dashWidth, size.height), paint);
      startX -= dashWidth + dashSpace;
    }

    // Left border
    startY = size.height;
    while (startY > 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY - dashWidth), paint);
      startY -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


