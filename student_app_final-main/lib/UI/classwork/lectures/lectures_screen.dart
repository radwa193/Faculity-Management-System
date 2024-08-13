import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/classwork/lecture/Lecturee.dart';
import '../../../provider/provider.dart';
import '../../pdf_screen.dart';

class LecturesScreen extends StatefulWidget {
  String subjectID;
  LecturesScreen({required this.subjectID , Key? key}) : super(key: key);

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getCourseLectures(widget.subjectID);
  }
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
          title: Row(
            children: [
              Text(
                'Lectures',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
        body : Container(
          decoration: const BoxDecoration(
              color: Color(0xffF7F7F7),
          ),
          child : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context , index) => const SizedBox(height: 10),
                    itemBuilder: (context , index) => lectureItemBuilder(
                        provider.courseLectures[index]
                    ),
                    itemCount:  provider.courseLectures.length,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget lectureItemBuilder(Lecturee lecture) =>  InkWell(
    onTap: () async {
      if (lecture.attachment != null) {
        final localPath = await downloadFile(lecture.attachment!);
        if (localPath != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerScreen(filePath: localPath),
            ),
          );
        }
      }
    },
    child: Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.0.h,
          horizontal: 16.0.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ImageIcon(
                  const AssetImage('assets/images/classwork_icons/lectures.png'),
                  color: Colors.orange,
                  size: 30.sp,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                   lecture.title!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: 10.h),
            Text(
             lecture.uploadDate!,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Future<String?> downloadFile(String url) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(url);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/temp.pdf');
      await ref.writeToFile(file);
      return file.path;
    } catch (e) {
      print('Failed to download PDF: $e');
      return null;
    }
  }

}
