import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Network/local/cache_helper.dart';
import '../../../models/classwork/Assignment/Assignment.dart';
import '../../../provider/provider.dart';
import '../../../shared/components.dart';
import 'aasignment_upload_screen.dart';

// ignore: must_be_immutable
class AssignmentsScreen extends StatefulWidget {
  String? subjectID;
  AssignmentsScreen({this.subjectID , Key? key}) : super(key: key);

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();

}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    String uid = CacheHelper.getData(key: 'userId');
    Provider.of<AppProvider>(context, listen: false).getCourseAssignments(uid , widget.subjectID!);
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
        title: const Row(
          children: [
            Text(
              'Assignmnets',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body : Container(
        decoration: const BoxDecoration(
          color:Color(0xffF7F7F7)
        ),
        child : Padding(
          padding: const EdgeInsets.all(16.0),
          child: provider.courseAssignments.isEmpty ? Center(
            child: Image(
                image: AssetImage(
                  'assets/images/icons/free.gif',
                ) ,
                fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ):Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context , index) => assignmentItemBuilder(
                      context , provider.courseAssignments[index],
                      provider ,
                      index,
                    ),
                    itemCount: provider.courseAssignments.length,
                ),
              )
            ],
          )

            ),
          ),
    );
  }

  Widget assignmentItemBuilder(BuildContext context , Assignment assignment , AppProvider provider , int index ) =>  InkWell(
    onTap : (){
      navigateTo(context, FileUploadScreen(assignment));
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ImageIcon(
                  AssetImage(
                    'assets/images/subjects/upload_aasignment.png',
                  ),
                  size: 50,
                  color: Color(0xffEF7505),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    assignment.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              assignment.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff949494),
              ),
            ),
            const SizedBox(height: 10),
            Text(
             'Deadline Date :  ${provider.formatDate(provider.announcements[index].announcementTimeStamp! ) }',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xffCD4A4A),
              ),
            ),
            const SizedBox(height: 10),
            // Row(
            //   children: [
            //     const Text(
            //       'Grade: ',
            //       style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //         color: Color(0xff949494),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    ),
  );
}
