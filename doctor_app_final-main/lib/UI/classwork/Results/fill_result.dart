import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/shared/dialogUtil/dialog_util.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';

class FillResultsScreen extends StatefulWidget {
  final num? assignmentId;
  final String? subjectID;

  const FillResultsScreen({required this.subjectID, required this.assignmentId, Key? key})
      : super(key: key);

  @override
  State<FillResultsScreen> createState() => _FillResultsScreenState();
}

class _FillResultsScreenState extends State<FillResultsScreen> {
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AppProvider>(context, listen: false)
            .assignResults(widget.subjectID!, widget.assignmentId!)).then((_) {
      initializeControllers();
    });
  }

  void initializeControllers() {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    setState(() {
      provider.ids!.forEach((id) {
        if (!controllers.containsKey(id.toString())) {
          controllers[id.toString()] = TextEditingController();
        }
      });
    });
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void submitMarks() {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    provider.ids!.forEach((id) {
      var mark = controllers[id.toString()]?.text ?? '';
      if (mark.isNotEmpty) {
        print("ID: $id, Mark: $mark");  // Debug print
        provider.uploadResults(widget.assignmentId, widget.subjectID, id, mark, CacheHelper.getData(key: 'doctorID')).then((value) {
          DialogUtil.showMessage(context, 'Results Uploaded Successfully' , posAction: (){
            Navigator.pop(context);
            Navigator.pop(context);
          } , posActionTitle: 'OK');
        });
      }
    });
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
            Provider.of<AppProvider>(context, listen: false).assignResult = [];
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: submitMarks,
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: 555.h,
          width: 800.w,
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Student Name',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Student ID',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Mark',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.names?.length ?? 0,
                  itemBuilder: (context, index) {
                    String id = provider.ids![index].toString();
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            provider.names![index],
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            id,
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: controllers[id],
                            onChanged: (value) {
                              setState(() {
                                // Trigger UI updates
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter mark',
                              hintStyle: TextStyle(fontSize: 14.sp),
                              border: const OutlineInputBorder(),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: (){
                  submitMarks();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
