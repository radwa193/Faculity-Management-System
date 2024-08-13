// ignore_for_file: no_logic_in_create_state
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_student_version/provider/provider.dart';
import 'package:final_student_version/shared/components.dart';
import 'package:final_student_version/style/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Network/local/cache_helper.dart';
import 'Network/remote/dio_helper.dart';
import 'UI/Login/login_screen.dart';
import 'UI/main screens/student_main_screen.dart';
import 'UI/onBoarding/onBoarding.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
  const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  Widget? widget;
  await CacheHelper.init();
  bool? onBoard = await CacheHelper.getData(
    key: 'onBoard',
  );
  String? studentToken = await CacheHelper.getData(key: 'studentToken');
  if (onBoard == true) {
    if (studentToken != null) {
      widget = const StudentMainScreen();
    }else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  bool? isDark = await CacheHelper.getData(key: 'isDark');
  String? isEnglish = await CacheHelper.getData(key: 'isEnglish');

  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider()
        ..changeAppTheme(fromShared: isDark)
        ..changeSuffixVisibility(),
      child: MyApp(
        isDark: isDark,
        isEnglish: isEnglish,
        startWidget: widget,
      )));
  DioHelper.init();
  const String supabaseUrl = 'https://ixwswhjospjukhbjqjzl.supabase.co';
  const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sRSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM';
  final SupabaseClient supabase = SupabaseClient(supabaseUrl, supabaseKey);
  await Supabase.initialize(
    url: 'https://ixwswhjospjukhbjqjzl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
  );
  final userId = CacheHelper.getData(key: 'userId');
  // checkNotifications('Material', userId);

}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final String? isEnglish;
  final Widget? startWidget;
  const MyApp(
      {
        super.key, required this.isDark,
        required this.isEnglish,
        required this.startWidget});


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375,812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          startWidget: startWidget,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  // initState() {
  //   NotificationHelper.initialize();
  // }
  final Widget? startWidget;
  const SplashScreen({super.key, required this.startWidget});
  @override
  State<SplashScreen> createState() =>
      SplashScreenState(startWidget: startWidget);
}

class SplashScreenState extends State<SplashScreen> {
  final Widget? startWidget;
  SplashScreenState({required this.startWidget});
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      navigateAndFinish(context, startWidget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/light/Spalsh@1x.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}


