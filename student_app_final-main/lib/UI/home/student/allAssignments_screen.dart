import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';


class AllAssignmentsScreen extends StatelessWidget {
  const AllAssignmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar : AppBar(
        backgroundColor: const Color(0xffF27B35),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Assignments',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
      body : Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children : [
            Expanded(
              child: ListView.separated(
                itemCount: provider.assignments.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(provider.assignments[index].title!,style : TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: const Color(0xffF28444)
                      )),
                      subtitle: Text('${provider.assignments[index].courseName!} ${provider.assignments[index].coursesID!}', style: TextStyle(color: Colors.grey[500] , fontSize: 12),),
                      isThreeLine: true,
                      trailing: const Icon(Icons.announcement),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(provider.assignments[index].title! , style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: const Color(0xffF28444)
                              ),),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.formatDate(provider.assignments[index].deadline!)),
                                     SizedBox(height: 10.h,),
                                    Text(provider.assignments[index].description!),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
