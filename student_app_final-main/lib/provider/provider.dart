// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Network/local/cache_helper.dart';
import '../Network/remote/dio_helper.dart';
import '../UI/Chats/chats_screen.dart';
import '../UI/Settings/setting_screen.dart';
import '../UI/classwork/classwork_screen.dart';
import '../UI/home/student/student_home_screen.dart';
import '../UI/main screens/student_main_screen.dart';
import '../models/Announcement/Announcement.dart';
import '../models/Attendance/AttendanceResult.dart';
import '../models/CourseTeachinStaff.dart';
import '../models/Graduation_Project/JoinGP.dart';
import '../models/Graduation_Project/StudentEnrolledToGP.dart';
import '../models/chat_users.dart';
import '../models/classwork/Assignment/Assignment.dart';
import '../models/classwork/Course.dart';
import '../models/classwork/Grades/Quiz.dart';
import '../models/classwork/Grades/Result.dart';
import '../models/classwork/Section/Section.dart';
import '../models/classwork/Section/Sectionn.dart';
import '../models/classwork/lecture/Lecture.dart';
import '../models/classwork/lecture/Lecturee.dart';
import '../shared/components.dart';
import '../shared/dialogUtil/dialog_util.dart';


class AppProvider extends ChangeNotifier {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(text: '123456');
  TextEditingController resetPasswordEmailController = TextEditingController();
  String userId = '';


  void clearAllData (){
    courses = [];
    teachingStaff = [];
    support = [];
    announcements = [];
    assignments = [];
    courseLectures = [];
    courseSections = [];
    courseTeachingStaff = [];
    search = [];
    upcomingQuizzes = [];
    upcomingSections = [];
    upcomingLectures = [];
    courseAssignments = [];
    courses = [];
    courseResults = [];
    secretKey = '';
  }
  int studentCurrentIndex = 0;

  List<Widget> studentBottomScreens = [
    StudentHomeScreen(),
    const RecentChatScreen(),
    const ClassworkScreen(),
    const SettingsScreen(),
  ];

  List<UserModel> search = [];

  List<UserModel> teachingStaff = [];

  List<UserModel> support = [];

  List<UserModel> recentSearchUsers = [
    UserModel(
      image: 'assets/images/icons/4.png',
      name: 'Doctor Kareem Yehia',
      phone: '+201203780688',
    ),
    UserModel(
      image: 'assets/images/icons/5.png',
      name: 'Eng. Natly Magdy',
      phone: '+201203780688',
    ),
    UserModel(
      image: 'assets/images/icons/6.png',
      name: 'Eng. Mariam Gamal',
      phone: '+201203780688',
    ),
  ];

  void changeStudentBottomNav(int index) {
    studentCurrentIndex = index;
    notifyListeners();
  }

  bool isDark = false;

  void changeAppTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      notifyListeners();
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark)
          .then((value) => notifyListeners());
    }
  }

  bool isPassword = false;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  IconData suffix = Icons.visibility_off_outlined;

  void changeSuffixVisibility() {
    print("Current isPassword: $isPassword");
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    notifyListeners();
  }

  String isEnglish = 'ar';
  String firstName = '';
  String lastName = '';

  void changeAppLanguage({String? fromShared}) {
    if (fromShared != null) {
      isEnglish = fromShared;
    } else {
      isEnglish = (isEnglish == 'en') ? 'ar' : 'en';
      CacheHelper.saveData(key: 'isEnglish', value: isEnglish);
    }
    notifyListeners();
  }

  final supabse = Supabase.instance.client;
  void loginToAccount(BuildContext context ,AppProvider provider) async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: provider.emailController.text,
      //   password: provider.passwordController.text,
      // );
      DialogUtil.showLoading(context, "Loading...");
      final email = provider.emailController.text;
      final password = provider.passwordController.text;
      final credential = await supabse.auth.signInWithPassword(email: email,password: password);
      if (credential.user != null) {
        DialogUtil.hideDialog(context);
        DialogUtil.showMessage(context,
            'This data is so confidential please press confirm to continue',
            isDismissAble: false,
            posActionTitle: "Confirm",
            negActionTitle: "Cancel", negAction: () {
              DialogUtil.hideDialog(context);
            },
            posAction: () async{
              DialogUtil.showLoading(context, 'Loading ....', isDismissAble: false);

              final email = provider.emailController.text;
              final emailPrefix = email.split('@').first;

              final nameParts = emailPrefix.split('.');
              firstName = '';
              lastName = '';

              if (nameParts.isNotEmpty) {
                firstName = nameParts[0];
                if (nameParts.length > 1) {
                  lastName = nameParts[1];
                }
              }

              print('First Name: $firstName');
              print('Last Name: $lastName');
              CacheHelper.saveData(key: "studentToken", value: credential.user!.id);
              try {
                userId = emailController.text.split('@').first;
                CacheHelper.saveData(key: 'studentName', value: studentName);
                CacheHelper.saveData(key: "userId", value: userId);
                CacheHelper.saveData(key: "email", value: provider.emailController.text);
                final existingUser = await supabse.from('users').select().eq('email', provider.emailController.text);
                if (existingUser.isEmpty) {
                  await supabse.from('users').insert({
                    'uid': provider.emailController.text.split('@').first,
                    'email': provider.emailController.text,
                    'role': 'student',
                  });
                } else {
                  print('User already exists in the database');
                }
              } catch (e) {
                // Handle any errors
                print('Error: $e');
              }
              catch(e){
                print(e);
              }
              navigateAndFinish(context,  const StudentMainScreen());
            });
      }
      else {
        DialogUtil.showMessage(context, 'Wrong E-mail or Password',
            posActionTitle: "ok", posAction: () {
              Navigator.pop(context);
            });
      }
    } catch (e, stackTrace) {
      print("Exception: $e\n$stackTrace");
      DialogUtil.showMessage(
          context, "Authentication failed. Please try again later.");
    }
  }

  List<Course> courses = [];
  List<String?> courseIds = [];

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
    notifyListeners();
  }

  String getCurrentDayOfWeek() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE').format(now);
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  String formatDate(String isoString) {
    DateTime parsedDate = DateTime.parse(isoString);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }

  List<Lecture> upcomingLectures = [];

  Future<void> getUpcomingLectures(String? uid) async {
    String currentDayOfWeek = getCurrentDayOfWeek();

    if (currentDayOfWeek.toLowerCase() == 'friday') {
      upcomingLectures = [];
      return;
    }

    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/StudentsLecSchedules',
          query: {
            'Student_ID': 'eq.$uid',
            'Day': 'eq.$currentDayOfWeek',
          });

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;
        upcomingLectures =
            jsonData.map((lectureData) => Lecture.fromJson(lectureData)).toList();
      } else {
        print(
            "Failed to retrieve UpcomingLectures. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving UpcomingLectures: $error");
    }
    notifyListeners();
  }

  List<Section> upcomingSections = [];

  Future<void> getUpcomingSections(String? uid) async {
    String currentDayOfWeek = getCurrentDayOfWeek();

    if (currentDayOfWeek.toLowerCase() == 'friday') {
      upcomingLectures = [];
      return;
    }

    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/StudentsSecSchedules',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
           'Student_ID' : 'eq.$uid',
            'Day': 'eq.$currentDayOfWeek'
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;
        upcomingSections = jsonData.map((sectionData) => Section.fromJson(sectionData)).toList();
      } else {
        print("Failed to retrieve Upcoming Sections. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Upcoming Sections: $error");
    }
    notifyListeners();
  }

  List<Quiz> upcomingQuizzes = [];

  Future<void> getUpcomingQuizzes(String? uid) async {
    DateTime now = DateTime.now();

    String currentDate = DateFormat('d/M/yyyy').format(now);

    String currentWeekday = DateFormat('EEEE').format(now);

    if (currentWeekday.toLowerCase() == 'friday' || currentWeekday.toLowerCase() == 'saturday') {
      upcomingQuizzes = [];
      return;
    }

    try {
      final response = await DioHelper.getData(
        url: 'rest/v1/UpComing',
        headers: {
          'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
        },
        query: {
          'Student_ID': 'eq.$uid',
          'Date': 'eq.$currentDate',
        },
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;
        upcomingQuizzes = jsonData.map((quizData) => Quiz.fromJson(quizData)).toList();
      } else {
        print("Failed to retrieve Upcoming Quizzes. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Upcoming Quizzes: $error");
    }
    notifyListeners();
  }

  List<Announcement> announcements = [];

  Future<void> getAnnouncements(String? uid) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/Announcements',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'target_ID' : 'cs.{$uid}',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;
        announcements = jsonData.map((announcementData) => Announcement.fromJson(announcementData)).toList();
      } else {
        print("Failed to retrieve Announcement. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Announcement: $error");
    }
    notifyListeners();
  }

  List<Assignment> assignments = [];

  Future<void> getAllAssignments(String? uid) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/Assignments for Students',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Student_ID' : 'eq.$uid',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;
        assignments = jsonData.map((assignmentData) => Assignment.fromJson(assignmentData)).toList();
      } else {
        print("Failed to retrieve Assignments. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Assignments: $error");
    }
    notifyListeners();
  }

  List<Assignment> courseAssignments = [];

  Future<void> getCourseAssignments(String? uid , String? courseID) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/Assignments for Students',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Student_ID' : 'eq.$uid',
            'Courses_ID' : 'eq.$courseID',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          courseAssignments = jsonData.map((assignmentData) => Assignment.fromJson(assignmentData)).toList();
        } else {
          courseAssignments.clear();
          notifyListeners();
          print("No Courses Assignments found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Courses Assignments. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Courses Assignments: $error");
    }
    notifyListeners();
  }

  List<Result> courseResults = [];

  Future<void> getCourseResults(String? uid , String? courseID) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/ResultsQ',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Student_ID' : 'eq.$uid',
            'Courses_ID' : 'eq.$courseID',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          courseResults = jsonData.map((courseResultData) => Result.fromJson(courseResultData)).toList();
        } else {
          courseResults.clear();
          notifyListeners();
          print("No Courses Results found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Courses Results. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Courses Results: $error");
    }
    notifyListeners();
  }

  String formatResult(String degree) {
    List<String> degreeParts = degree.split(" / ");

    if (degreeParts.length == 2) {
      String studentGrade = degreeParts[0];
      String totalGrade = degreeParts[1];
      return "$studentGrade / $totalGrade";
    }else{
      return degree;
    }
  }

  List<Lecturee> courseLectures = [];

  Future<void> getCourseLectures(String? courseID) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/MaterialLoadingLec',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Course_ID' : 'eq.$courseID',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          courseLectures = jsonData.map((courseResultData) => Lecturee.fromJson(courseResultData)).toList();
        } else {
          courseResults.clear();
          notifyListeners();
          print("No Courses Lectures found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Courses Lectures. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Courses Results: $error");
    }
    notifyListeners();
  }

  List<Sectionn> courseSections = [];

  Future<void> getCourseSections(String? courseID) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/MaterialLoadingSec',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Course_ID' : 'eq.$courseID',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          courseSections = jsonData.map((courseResultData) => Sectionn.fromJson(courseResultData)).toList();
        } else {
          courseResults.clear();
          notifyListeners();
          print("No Courses Sections found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Courses Sections. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Courses Sections: $error");
    }
    notifyListeners();
  }

  List<CourseTeachinStaff> courseTeachingStaff = [];

  Future<void> getCourseTeachingStaff(String? courseID) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/CoursesDocTeach',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Courses_ID' : 'eq.$courseID',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          courseTeachingStaff = jsonData.map((teachingStaffData) => CourseTeachinStaff.fromJson(teachingStaffData)).toList();
        } else {
          notifyListeners();
          print("No Course Teaching Staff Sections found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Courses Teaching Staff. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Course Teaching Staff: $error");
    }
    notifyListeners();
  }

  TextEditingController projectTitleController = TextEditingController();
  TextEditingController leaderNameController = TextEditingController();
  TextEditingController projectDescriptionController = TextEditingController();

  Future<void> studentRegisterGraduationProject(
      String? projectTitle,
      String? projectDescription,
      String? leaderId) async {
    try {
       DioHelper.postData(
          url: 'rest/v1/Graduation_Projects',
         headers: {
           'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
         },
          data: {
            'Project_Title': projectTitle,
            'Project_Description': projectDescription,
            'Leader(Student)_ID': leaderId,
          },
      )?.then((value) {
        print(value?.data);
      }).catchError(((error)
      {
        print(error.toString());
      }));

    } catch (error) {
      print("Error Registering Graduation Project: $error");
    }
    notifyListeners();
  }

  String? secretKey ;
  int? graduationProjectId;

  Future<void> getGraduationProjectSecretKey(String? projectName) async {
    print(projectName);
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/Graduation_Projects',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Project_Title': 'eq.$projectName',
          }
      );

      if (response != null && response.statusCode == 200) {
          secretKey = response.data[0]['Secret_Key'];
          graduationProjectId = response.data[0]['Project_ID'];
          notifyListeners();
      } else {
        print("Failed to retrieve Secret Key. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Secret Key: $error");
    }
    notifyListeners();
  }

  Future<void> addStudentGraduationProject(
      String? studentId,
      int projectId,
     ) async {
    try {
      DioHelper.postData(
        url: 'rest/v1/Student_EnrolledTo_GradProject',
        headers: {
          'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
        },
        data: {
          'Project_ID': projectId,
          'Student_ID': studentId,
        },
      )?.then((value) {
        print(value?.data);
      }).catchError(((error)
      {
        print(error.toString());
      }));

    } catch (error) {
      print("Error Registering Graduation Project: $error");
    }
  }

  String? studentName = '';

  Future<void> getUserName(String? studentId) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/NamesOfStudents',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Student_ID': 'eq.$studentId',
          }
      );

      print('HTTP Status Code: ${response?.statusCode}');
      if (response != null && response.statusCode == 200) {
        if (response.data != null && response.data.isNotEmpty) {
          studentName = response.data[0]['Student_Name'];
          CacheHelper.saveData(key: 'studentName', value: studentName);
        } else {
          print("No Secret Key found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Secret Key. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Secret Key: $error");
    }
    notifyListeners();
  }

  Future<void> uploadStudentAssignment(BuildContext context, String? studentId , int? assignmentId , DateTime time , List<int>? attatchement ) async {
    try {
       await DioHelper.postData(
          url: 'rest/v1/Student_HandIn_Assignment',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          data : {
            'Student_ID': '$studentId',
            'Assignment_ID': '$assignmentId',
            'TimeStamp': '$time',
            'attachment': '$attatchement'
          }
      )?.then((value) {
        print(value?.data);
        DialogUtil.showMessage(context, 'Assignment Uploaded Successfully',
            posActionTitle:  'OK', posAction: () {
          Navigator.pop(context);
        });
      }).catchError(((error)
      {
        print(error.toString());
      }));

    } catch (error) {
      print("Error Registering Graduation Project: $error");
    }
    notifyListeners();
  }

  List<StudentEnrolledToGp> studentEnrolledToGp = [];

  Future<void> studentEnrolledToGP(String? studentId) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/StudentEnrolledGradProject',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Student_ID' : 'cs.{$studentId}',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          studentEnrolledToGp = jsonData.map((courseResultData) => StudentEnrolledToGp.fromJson(courseResultData)).toList();
          notifyListeners();
        } else {
          print("No Student found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Courses Sections. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Courses Sections: $error");
    }
    notifyListeners();
  }

  TextEditingController secretCodeController = TextEditingController();

  List<JoinGp> joinJp = [];

  Future<void> studentJoinGP(String? secretKey) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/aq_gradForEnroll',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Secret_Key' : 'eq.$secretKey',
          }
      );

      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          print("not empty");
          joinJp = jsonData.map((courseResultData) => JoinGp.fromJson(courseResultData)).toList();
          notifyListeners();
        } else {
          print("No Team found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Courses Sections. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Courses Sections: $error");
    }
    notifyListeners();
  }

  Future<void> studentJoinGraduationProject(num? secretKey , String? studentId) async {
    try {
       await DioHelper.postData(
          url: 'rest/v1/Student_EnrolledTo_GradProject',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          data: {
            'Student_ID': '$studentId',
            'Project_ID': '$secretKey',
          }
      )?.then((value) {
        print(value?.data);
      }).catchError(((error) {
        print(error.toString());
      }));
    } catch (error) {
      print("Error Registering Graduation Project: $error");
    }
    notifyListeners();
  }

  dynamic studentPhoto ;

  Future<void> getStudentPhoto(String? studentId) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/Students',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Student_ID': 'eq.$studentId',
          }
      );

      print('HTTP Status Code: ${response?.statusCode}');
      if (response != null && response.statusCode == 200) {
        if (response.data != null && response.data.isNotEmpty) {
          studentPhoto = response.data[0]['Photo'];
          CacheHelper.saveData(key: 'studentPhoto', value: studentPhoto);
        } else {
          print("No Photo found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Student Photo. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Student Photo: $error");
    }
    notifyListeners();
  }

  List<AttendanceResult> checked = [];
  Future<void> checkStudentAttendance(dynamic code) async {
    try {
      final response = await DioHelper.getData(
          url: 'rest/v1/Attendance',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'code': 'eq.$code',
          }
      );

      print('HTTP Status Code: ${response?.statusCode}');
      if (response != null && response.statusCode == 200) {
        final jsonData = response.data as List<dynamic>;

        if (response.data != null && response.data.isNotEmpty) {
          checked = jsonData.map((courseResultData) => AttendanceResult.fromJson(courseResultData)).toList();
          print(checked);
        } else {
          print("No Photo found for the specified criteria.");
        }
      } else {
        print("Failed to retrieve Student Photo. Status code: ${response?.statusCode}");
      }
    } catch (error) {
      print("Error retrieving Student Photo: $error");
    }
    notifyListeners();
  }

  String _receiverUserId = '';
  String _receiverUserEmail = '';

  String get receiverUserId => _receiverUserId;
  String get receiverUserEmail => _receiverUserEmail;

  void setReceiverUser({required String receiverUserId, required String receiverUserEmail}) {
    _receiverUserId = receiverUserId;
    _receiverUserEmail = receiverUserEmail;
    notifyListeners();
  }

}

