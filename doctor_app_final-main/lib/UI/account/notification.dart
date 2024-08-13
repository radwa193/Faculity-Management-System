import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/style/fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Center(
            child: Container(
              height: 555.h,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification Center',
                    style:Styles.styleBold22,
                  ),
                   SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notifications[index].message,
                                  style:Styles.styleBold16,
                                ),
                                 SizedBox(height: 5.0.h),
                                if (notifications[index].text != null)
                                  Row(
                                    children: [
                                      Text(
                                        notifications[index].text!,
                                        style:Styles.style13,
                                      ),
                                      const Spacer(),
                                      Text(
                                        notifications[index].time,
                                        style:Styles.style12,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            onTap: () {
                              // Handle notification tap
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationModel {
  final String message;
  final String text;
  final String time;
  NotificationModel({
    required this.message,
    required this.text,
    required this.time,
  });
}

List<NotificationModel> notifications = [
  NotificationModel(
    message: 'Email Verification',
    text: 'Please verify your Email',
    time: '2 minutes ago',
  ),
  NotificationModel(
    message: 'Confirmation',
    text: 'Check your confirmation',
    time: '2 minutes ago',
  ),
  NotificationModel(
    message: 'New Massage',
    text: 'you have new massage from DR.Hala',
    time: '2 minutes ago',
  ),
  NotificationModel(
    message: 'Email Verification',
    text: 'Please verify your Email',
    time: '2 minutes ago',
  ),
  NotificationModel(
    message: 'Email Verification',
    text: 'Please verify your Email',
    time: '2 minutes ago',
  ),
  NotificationModel(
    message: 'Phone Number Verification',
    text: 'Please verify your phone number',
    time: '10 minutes ago',
  ),
  NotificationModel(
    message: 'Check your grades',
    text: 'Marketing grades',
    time: '58 minutes ago',
  ),
  NotificationModel(
    message: 'New Messages',
    text: 'You have Unread massage',
    time: '1 hour ago',
  ),
];





