// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:management_system_final_doctor/Network/remote/dio_helper.dart';
import 'package:management_system_final_doctor/UI/Chats/chats_screen.dart';
import 'package:management_system_final_doctor/UI/account/setting_screen.dart';
import 'package:management_system_final_doctor/UI/classwork/classwork_Screen.dart';
import 'package:management_system_final_doctor/UI/home/home_screen.dart';
import 'package:management_system_final_doctor/UI/main%20screen/doctor_main_screen.dart';
import 'package:management_system_final_doctor/models/Announcement/Announcemnet.dart';
import 'package:management_system_final_doctor/models/Attendance/AttendSessionDetails.dart';
import 'package:management_system_final_doctor/models/Attendance/PastAttendanceSession.dart';
import 'package:management_system_final_doctor/models/ExamData/ExamData.dart';
import 'package:management_system_final_doctor/models/assign%20result/AssignResult.dart';
import 'package:management_system_final_doctor/models/chat_users.dart';
import 'package:management_system_final_doctor/models/course/Course.dart';
import 'package:management_system_final_doctor/models/project/ProjectAssigned.dart';
import 'package:management_system_final_doctor/models/upcoming/Upcoming.dart';
import '../Network/local/cache_helper.dart';
import '../models/doctor data/DoctorData.dart';
import '../models/project/Project.dart';
import '../models/studemt_enrolled/StudentsEnrolledToCourse.dart';
import '../shared/components.dart';
import '../shared/dialogUtil/dialog_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppProvider extends ChangeNotifier {

  TextEditingController emailController = TextEditingController(text: 'hossam.elbhiery.csis@o6u.edu.eg');
  TextEditingController resetPasswordEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(text: '123456');

  int doctorCurrentIndex = 0;
  String doctorId = '';


  List<Widget> studentBottomScreens = [

  ];
  List<Widget> doctorBottomScreens = [
    const HomeScreen(),
    const RecentChatScreen(),
    const ClassworkScreen(),
    const AccountScreen(),
  ];

  void changeDoctorBottomNav(int index) {
    if (index < 0 || index >= doctorBottomScreens.length || index == null) {
      doctorCurrentIndex = 0;
    } else {
      doctorCurrentIndex = index;
    }
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

  List<UserModel> students = [
    UserModel(
      image: 'assets/images/icons/1.png',
      name: 'Doctor Nada Mohamed',
      phone: '+201203780688',
    ),
    UserModel(
      image: 'assets/images/icons/2.png',
      name: 'Eng. Kirolos Magdy',
      phone: '+201203780688',
    ),
    UserModel(
      image: 'assets/images/icons/3.png',
      name: 'Eng. Bassem saeed',
      phone: '+201203780688',
    ),
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

  List<UserModel> support = [
    UserModel(
      image: 'assets/images/icons/1.png',
      name: 'Support 1',
      phone: '+201203780688',
    ),
    UserModel(
      image: 'assets/images/icons/2.png',
      name: 'Support 2',
      phone: '+201203780688',
    ),
  ];

  void clearAllData() {
    doctorData = [];
    doctorUpcomingLectures = [];
    doctorCourses = [];
    assignmentTitleController.clear();
    assignmentDescriptionController.clear();
    tsAnnouncement = [];
    projectAssigned = [];
    allProjects = [];
    assignmentFullMarkController.clear();


    notifyListeners();
  }

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

  void removeRecentSearchUser(int index) {
    recentSearchUsers.removeAt(index);
    notifyListeners();
  }

  bool isPassword = true;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  IconData suffix = Icons.visibility_off_outlined;

  void changeSuffixVisibility() {
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
  void loginToAccount(BuildContext context, AppProvider provider) async {
    try {
      DialogUtil.showLoading(context, "Loading...");
      final email = provider.emailController.text;
      final password = provider.passwordController.text;

      if (email.contains('.csis')) {
        // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: email,
        //   password: password,
        // );
        final credential = await supabse.auth.signInWithPassword(email: email,password: password);
        if (credential.user != null) {
          DialogUtil.hideDialog(context);
          DialogUtil.showMessage(context,
              'This data is so confidential please press confirm to continue',
              isDismissAble: false,
              posActionTitle: "Confirm",
              negActionTitle: "Cancel",
              negAction: () {
                DialogUtil.hideDialog(context);
              },

              posAction: () async {
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

                CacheHelper.saveData(key: "doctorToken", value: credential.user!.id);
                CacheHelper.saveData(key: "email", value: email);

                final existingUser = await supabse.from('users').select().eq('email', email);
                if (existingUser.isEmpty) {
                  doctorId = emailController.text.split('@').first;
                  await supabse.from('users').insert({
                    'uid': emailPrefix,
                    'email': email,
                    'role': 'doctor',
                    'first_name': firstName,
                    'last_name': lastName,
                  });
                } else {
                  doctorId = emailController.text.split('@').first;
                  print('User already exists in the database');
                }
                navigateAndFinish(context, const DoctorMainScreen());
              });
        } else {
          DialogUtil.showMessage(context, 'Wrong E-mail or Password',
              posActionTitle: "ok", posAction: () {
                Navigator.pop(context);
              });
        }
      } else {
        DialogUtil.showMessage(context, 'Incorrect Email Format',
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

  String _receiverUserId = '';
  String _receiverUserEmail = '';

  String get receiverUserId => _receiverUserId;
  String get receiverUserEmail => _receiverUserEmail;

  void setReceiverUser({required String receiverUserId, required String receiverUserEmail}) {
    _receiverUserId = receiverUserId;
    _receiverUserEmail = receiverUserEmail;
    notifyListeners();
  }

  List<DoctorData> doctorData = [];

  Future<void> getDoctorData(String? doctorEmail) async {

    try {
       await DioHelper.getData(
          url: 'rest/v1/TSEmails',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Email': 'eq.$doctorEmail',
          }
      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        doctorData = jsonData.map((teachingStaffData) => DoctorData.fromJson(teachingStaffData)).toList();
        CacheHelper.saveData(key: 'doctorID', value: doctorData[0].teachingStaffID);
        CacheHelper.saveData(key: 'doctorName', value: doctorData[0].teachingStaffName);
        CacheHelper.saveData(key: 'photo', value: doctorData[0].photo);
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  List<Upcoming> doctorUpcomingLectures = [];

  Future<void> getDoctorUpcoming(int? doctorId) async {

    try {
      await DioHelper.getData(
          url: 'rest/v1/DocSchedules',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'TeachingStaff_ID': 'eq.$doctorId',
          }
      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        doctorUpcomingLectures = jsonData.map((teachingStaffData) => Upcoming.fromJson(teachingStaffData)).toList();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  List<Course> doctorCourses = [];

  Future<void> getDoctorCourses(int? doctorId) async {

    try {
      await DioHelper.getData(
          url: 'rest/v1/CoursesDocTeach',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'TeachingStaff_ID': 'eq.$doctorId',
          }
      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        doctorCourses = jsonData.map((teachingStaffData) => Course.fromJson(teachingStaffData)).toList();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  TextEditingController assignmentTitleController = TextEditingController();
  TextEditingController  assignmentDescriptionController = TextEditingController();
  TextEditingController  assignmentFullMarkController = TextEditingController();
  TextEditingController  assignmentDeadlineIdController = TextEditingController();

  Future<void> assignAssignment(
      String? title,
      String? description,
      String? coursesId,
      int? teachingStaffID,
      int? attType,
      int? fullMark,
      String? deadLine,
      String? datePublished,
      String? attachment,
      ) async {
    try {
      await DioHelper.postData(
          url: 'rest/v1/Assignments',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          data: {
            'Title': '$title',
            'Description': '$description',
            'Courses_ID': coursesId,
            'TeachingStaff_ID': '$teachingStaffID',
            'attType': '$attType',
            'Full_Mark': fullMark,
            'Date': '$deadLine',
            'Date_Published': '$datePublished',
            'Attachment': '$attachment',
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

  TextEditingController lectureTitleController = TextEditingController();
  Future<void> uploadMaterial(
      String? title,
      String? coursesId,
      int? teachingStaffID,
      int? attType,
      String? uploadDate,
      String? attachment,
      ) async {
    try {
      await DioHelper.postData(
          url: 'rest/v1/Material',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          data: {
            'Title': '$title',
            'Course_ID': '$coursesId',
            'TeachingStaff_ID': '$teachingStaffID',
            'AttType': '$attType',
            'UploadDate': '$uploadDate',
            'Attachment': '$attachment',
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

  TextEditingController announcementTitleController = TextEditingController();
  TextEditingController announcementDescriptionController = TextEditingController();

  Future<void> makeAnnouncement(
      String? announcementTitle,
      String? announcementContent,
      String? announcementTimeStamp,
      int? authorId,
      List<num>? targetIds,
      ) async {
    try {
      String formattedTargetIds = '{$targetIds}'.replaceAll('[', '').replaceAll(']', '');
      await DioHelper.postData(
          url: 'rest/v1/Announcements',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          data: {
            'Announcement_Title': announcementTitle,
            'Announcement_Content': announcementContent,
            'Announcement_TimeStamp': announcementTimeStamp,
            'Author_ID': authorId,
            'target_ID': formattedTargetIds,
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

  List <StudentsEnrolledToCourse> studentsEnrolledInCourse = [];
  List<num>? courseStudents = [];

  Future<void> getCourseStudents(String? courseId) async {
    try {
      await DioHelper.getData(
          url: 'rest/v1/StudentsEnrolledForCourse',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Courses_ID': 'eq.$courseId',
          }
      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        studentsEnrolledInCourse = jsonData.map((teachingStaffData) => StudentsEnrolledToCourse.fromJson(teachingStaffData)).toList();
        courseStudents = studentsEnrolledInCourse[0].studentID;
        notifyListeners();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  List<Project>? allProjects = [];

  Future<void> getAllProjects() async {
    try {
      await DioHelper.getData(
          url: 'rest/v1/GradProjectAvailableViewDoc',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },

      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        allProjects = jsonData.map((teachingStaffData) => Project.fromJson(teachingStaffData)).toList();
        notifyListeners();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  List<ProjectAssigned>? projectAssigned = [];

  Future<void> getProjectAssigned(int? doctorId) async {
    try {
      await DioHelper.getData(
        url: 'rest/v1/GradProject_DocEnrolled',
        headers: {
          'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
        },
        query: {
          'prof ID': 'eq.$doctorId',
        }

      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        projectAssigned = jsonData.map((teachingStaffData) => ProjectAssigned.fromJson(teachingStaffData)).toList();
        notifyListeners();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  List<Announcemnet>? tsAnnouncement = [];

  Future<void> getTsAnnouncements(int? doctorId) async {
    try {
      await DioHelper.getData(
        url: 'rest/v1/AnnouncementsTS',
        headers: {
          'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
        },
        query: {
          'target_ID': 'cs.{$doctorId}',
        }

      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        tsAnnouncement = jsonData.map((teachingStaffData) => Announcemnet.fromJson(teachingStaffData)).toList();
        notifyListeners();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  Future<void> assignDoctor(int? teachingStaffId , num? projectId ) async {
    try {
      await DioHelper.patchData(
        url: 'rest/v1/Graduation_Projects',
        headers: {
          'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
        },
        data: {
          'TeachingStaff_ID(Prof)': teachingStaffId,
        },
        query: {
          'Project_ID': 'eq.$projectId',
        }

      )?.then((value) {
        print(value?.data);
      }).catchError(((error) {
        print(error.toString());
      }));

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }


  TextEditingController examTitleController = TextEditingController();
  TextEditingController examDescriptionController = TextEditingController();
  TextEditingController examDateController = TextEditingController();


  Future<void> makeExam(
      String? examTitle,
      String? examDescription,
      String? courseId,
      int? fullMark,
      int? teachingStaffId,
      int? attType,
      String? examDate,
      String? datePublished,
      ) async {
    try {
      await DioHelper.postData(
          url: 'rest/v1/Exams',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          data: {
            'Title': examTitle,
            'Description': examDescription,
            'Courses_ID': courseId,
            'Full_Mark': fullMark,
            'TeachingStaff_ID': teachingStaffId,
            'attType': attType,
            'Date': examDate,
            'Date_Published': datePublished,
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

  List<ExamData> examData = [];
  List<num?> examsIds = [];
  List<String?> examsTitle = [];
  num? selctedId;

  Future<void> getExamData(int? doctorId , String? courseId) async {
    try {
      await DioHelper.getData(
        url: 'rest/v1/LoadExamsAssigmnets',
        headers: {
          'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
        },
        query: {
          'TeachingStaff_ID' : 'eq.$doctorId',
          'Courses_ID' : 'eq.$courseId'
        }
      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        examData = jsonData.map((teachingStaffData) => ExamData.fromJson(teachingStaffData)).toList();
        examData.forEach((element) {examsIds.add(element.id); });
        examData.forEach((element) {examsTitle.add(element.title); });
        notifyListeners();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  List<AssignResult> assignResult = [];
  List<String>? names = [];
  List<num>? ids = [];

  Future<void> assignResults(String? courseId , num? assignmentId) async {
    try {
      await DioHelper.getData(
        url: 'rest/v1/Assign_Results',
        headers: {
          'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
        },
        query: {
          'ID' : 'eq.$assignmentId',
          'Courses_ID' : 'eq.$courseId'
        }
      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        assignResult = jsonData.map((teachingStaffData) => AssignResult.fromJson(teachingStaffData)).toList();
        names = assignResult[0].studentName;
        ids = assignResult[0].arrayAgg;
        notifyListeners();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  Future<void> uploadResults(
      num? examId,
      String? courseId,
      num? studentId,
      String? mark,
      num? teachingStaffId,
      ) async {
    try {
      await DioHelper.postData(
          url: 'rest/v1/Results',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          data: {
            'Exam_Assignment_ID': examId,
            'Courses_ID': courseId,
            'Student_ID': studentId,
            'Mark': mark,
            'TeachingStaff_ID': teachingStaffId,
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


  List<PastAttendanceSession>? fetchAttendData = [];

  Future<void> fetchAttendanceData(String? courseId) async {
    try {
      await DioHelper.getData(
          url: 'rest/v1/Attendance',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'Attended_course_ID' : 'eq.$courseId',
          }
      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        fetchAttendData = jsonData.map((teachingStaffData) => PastAttendanceSession.fromJson(teachingStaffData)).toList();
        notifyListeners();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }

  List<AttendSessionDetails>? fetchSessionDetails = [];

  Future<void> fetchAttendSessionDetails(String? courseId) async {
    try {
      await DioHelper.getData(
          url: 'rest/v1/Attend',
          headers: {
            'apiKey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
          },
          query: {
            'code' : 'eq.$courseId',
          }
      )?.then((value) {
        final jsonData = value?.data as List<dynamic>;
        fetchSessionDetails = jsonData.map((teachingStaffData) => AttendSessionDetails.fromJson(teachingStaffData)).toList();
        notifyListeners();
      });

    } catch (error) {
      print("Error retrieving Teaching Staff Data: $error");
    }
    notifyListeners();
  }


}

