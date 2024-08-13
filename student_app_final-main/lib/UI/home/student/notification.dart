import 'package:flutter/material.dart';

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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Notification Center',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: ListView.separated(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifications[index].message,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      if (notifications[index].text != null)
                        Row(
                          children: [
                            Text(
                              notifications[index].text!,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13.0,
                                color: Color(0xff828282),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              notifications[index].time,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                                color: Color(0xff828282),
                              ),
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
    message: 'Email Verfication',
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
    message: 'Email Verfication',
    text: 'Please verify your Email',
    time: '2 minutes ago',
  ),
  NotificationModel(
    message: 'Email Verfication',
    text: 'Please verify your Email',
    time: '2 minutes ago',
  ),
  NotificationModel(
    message: 'Phone Number Verfication',
    text: 'Please verify your phone number',
    time: '10 minutes ago',
  ),
  NotificationModel(
    message: 'Check your grades',
    text: 'Marketing grades',
    time: '58 minutes ago',
  ),
  NotificationModel(
    message: 'New Masseges',
    text: 'You have Unread massege',
    time: '1 hour ago',
  ),
];





