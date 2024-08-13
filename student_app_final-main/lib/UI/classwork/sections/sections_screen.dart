import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../models/classwork/Section/Sectionn.dart';
import '../../../provider/provider.dart';
import '../../pdf_screen.dart';

class SectionsScreen extends StatefulWidget {
  String subjectID;
  SectionsScreen({required this.subjectID , Key? key}) : super(key: key);

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getCourseSections(widget.subjectID);
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
                'Sections',
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
                    separatorBuilder: (context , index) => SizedBox(height: 10.h),
                    itemBuilder: (context , index) => lectureItemBuilder(
                      context,
                        provider.courseSections[index],
                    ),
                    itemCount: provider.courseSections.length,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget lectureItemBuilder(BuildContext context, Sectionn section) => InkWell(
    onTap: () async {
      if (section.attachment != null) {
        final localPath = await downloadFile(section.attachment!);
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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
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
                    section.title!,
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
              section.uploadDate!,
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
      return null;
    }
  }

}
