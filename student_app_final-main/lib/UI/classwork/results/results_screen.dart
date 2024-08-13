import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Network/local/cache_helper.dart';
import '../../../models/classwork/Grades/Result.dart';
import '../../../provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  final String? subjectID;
  const ResultsScreen({this.subjectID , Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    String uid = CacheHelper.getData(key: 'userId');
    Provider.of<AppProvider>(context, listen: false).getCourseResults(uid , widget.subjectID!);
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
                'Results',
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
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context , index) => const SizedBox(height: 10),
                    itemBuilder: (context , index) => lectureItemBuilder(
                       provider.courseResults[index],
                        provider
                    ),
                    itemCount: provider.courseResults.length,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}  Widget lectureItemBuilder(Result result , AppProvider provider) =>  Card(
  child: Padding(
    padding: EdgeInsets.symmetric(
      vertical: 16.0.h,
      horizontal: 16.0.w,
    ),
    child: Row(
      children: [
        ImageIcon(
          const AssetImage('assets/images/classwork_icons/result.png'),
          color: Colors.orange,
          size: 30.sp,
        ),
         SizedBox(width: 10.w),
        Flexible(
          child: Text(
            result.title!,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              provider.formatResult(result.degree!),
              style:  TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
             SizedBox(height: 5.h),
            Text(
              'Grade',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);

