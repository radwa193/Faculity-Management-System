import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';


class AllAnnouncementsScreen extends StatelessWidget {
  const AllAnnouncementsScreen({Key? key}) : super(key: key);

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Announcement',
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
                itemCount: provider.announcements.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(provider.announcements[index].announcementTitle! , style : TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Color(0xffF28444)
                      ) ),
                      subtitle: Text(provider.formatDate(provider.announcements[index].announcementTimeStamp! ) , style: TextStyle(color: Colors.grey[500] , fontSize: 12.sp),),
                      isThreeLine: true,
                      trailing: Icon(Icons.announcement),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(provider.announcements[index].announcementTitle! , style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: Color(0xffF28444)
                              )),
                              content: SingleChildScrollView(
                                child: Text(provider.announcements[index].announcementContent!),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Close'),
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
