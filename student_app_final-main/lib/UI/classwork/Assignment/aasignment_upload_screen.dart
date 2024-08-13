import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:final_student_version/ayyend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import '../../../Network/local/cache_helper.dart';
import '../../../models/classwork/Assignment/Assignment.dart';
import '../../../provider/provider.dart';
import '../file_upload_decoration.dart';


class FileUploadScreen extends StatefulWidget {
  final Assignment assignment;

  FileUploadScreen(this.assignment, {super.key});

  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _selectedFile;
  dynamic studentId = '';
  String? downloadUrl = '';

  @override
  void initState() {
    super.initState();
    studentId = CacheHelper.getData(key: 'userId');
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        title: SizedBox(
          width: 200,
          child: Text(
            widget.assignment.title!,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xffF7F7F7),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Add New Files',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
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
                          child: _selectedFile == null
                              ? Column(
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
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Select Zip, image, pdf or ms.word',
                                style: TextStyle(
                                  color: Color(0xff515978),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                              : Column(
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: const Color(0xffECEDF2),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _openFileExplorer(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: const Color(0xffEF7505),
                          foregroundColor: Colors.white,
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
    );
  }

  void _openFileExplorer() async {
    print('Starting file selection...');
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true);
      if (result != null) {
        print('File selected: ${result.files.single.name}');

        if (kIsWeb) {
          Uint8List fileBytes = result.files.single.bytes!;
          print('Uploading file on web...');
          try {
            final response = await supabase.storage
                .from('Files')
                .uploadBinary(result.files.single.name, fileBytes);
            print('File Uploaded');
            downloadUrl = response.toString();
            print('Download URL: $downloadUrl');
          } catch (e) {
            print('Error uploading file: $e');
          }
        } else {
          File file = File(result.files.single.path!);
          print('Uploading file on mobile/desktop...');
          try {
            final response = await supabase.storage
                .from('Files')
                .upload(result.files.single.name, file);
            print('File Uploaded');
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

}



