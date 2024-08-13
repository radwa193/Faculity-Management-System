
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Network/remote/dio_helper.dart';
import 'models/classwork/Course.dart';


void checkNotifications(String? text, String userId) {
  List<Course> courses = [];

  Future<void> getCourses(String studentId) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/CoursesStudentsStudy',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Student_ID': 'eq.$studentId',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;
        courses = jsonData.map((courseData) => Course.fromJson(courseData)).toList();
        print("Courses retrieved successfully");
      } else {
        print("Failed to retrieve courses. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving courses: $error");
    }
  }

  final supabase = Supabase.instance.client;

  supabase
      .channel('todos')
      .onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: '$text',
      callback: (payload) {
        List<String>? courseID;
        if (payload?.newRecord?['Course_ID'] != null && payload.newRecord['Course_ID'] is Iterable) {
          courseID = List<String>.from(payload.newRecord['Course_ID'].map((e) => e.toString()));
        }

        if (courseID != null) {
          String? coursesString = courses.toString();
          // if (courseID.any((id) => coursesString.contains(id))) {
          //   NotificationHelper.showBigTextNotification(
          //       title: 'New Material',
          //       id: 0,
          //       body: 'New Material has been added',
          //       payload: flutterLocalNotificationsPlugin);
          // }
        } else {
          print('No Course_ID available in payload or Course_ID is not iterable.');
        }
      }
  )
      .subscribe();
}
