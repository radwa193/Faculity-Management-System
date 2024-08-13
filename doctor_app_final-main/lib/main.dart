// ignore_for_file: no_logic_in_create_state

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:management_system_final_doctor/Network/remote/dio_helper.dart';
import 'package:management_system_final_doctor/UI/login/login_screen.dart';
import 'package:management_system_final_doctor/UI/main%20screen/doctor_main_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'provider/provider.dart';
import 'style/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
  const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  DioHelper.init();
  const String supabaseUrl = 'https://ixwswhjospjukhbjqjzl.supabase.co';
  const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sRSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM';
  final SupabaseClient supabase = SupabaseClient(supabaseUrl, supabaseKey);
  await Supabase.initialize(
    url: 'https://ixwswhjospjukhbjqjzl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM',
  );
  await CacheHelper.init();
  String? doctorToken = await CacheHelper.getData(key: 'doctorToken');
  print(doctorToken);
  Widget startWidget = doctorToken != null ? const DoctorMainScreen() : LoginScreen();

  bool? isDark = await CacheHelper.getData(key: 'isDark');
  String? isEnglish = await CacheHelper.getData(key: 'isEnglish');
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider()..changeAppTheme(fromShared: isDark),
      child: MyApp(
        isDark: isDark,
        isEnglish: isEnglish,
        startWidget: startWidget,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final String? isEnglish;
  final Widget startWidget;

  const MyApp({
    Key? key,
    required this.isDark,
    required this.isEnglish,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(1440,720),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}



