import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        title: Row(
          children: [
            Text(
              'Settings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        color: const Color(0xffF7F7F7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Settings",
              style: TextStyle(
                color: Color(0xffEF7505),
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,),
            ),
             SizedBox(
              height: 40.h,
            ),
             Text(
              "Language",
              style:  TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,),
            ),
             SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffEF7505),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.isEnglish == 'en' ? "English" : "Arabic",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Icon(Icons.arrow_drop_down_outlined)
                  ],
                ),
              ),
            ),
             SizedBox(height: 25.h),
             Text(
              "Theme",
              style:  TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,),
            ),
             SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffEF7505),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.isDark ? "Dark" : "Light",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Icon(Icons.arrow_drop_down_outlined)
                  ],
                ),
              ),
            ),
             SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheet(),
    );
  }
}

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Container(
      color: const Color(0xffEF7505),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.changeAppLanguage();
            },
            child: Text(
              "English",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: provider.isDark ? Colors.white : Colors.black,
                  ),
            ),
          ),
           SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {
              provider.changeAppLanguage();
            },
            child: Text(
              "Arabic",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: provider.isDark ? Colors.white : Colors.black,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Container(
      color: const Color(0xffEF7505),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.changeAppTheme();
            },
            child: Text(
              "Light",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: provider.isDark ? Colors.white : Colors.black,
                  ),
            ),
          ),
           SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {
              provider.changeAppTheme();
            },
            child: Text(
              "Dark",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: provider.isDark ? Colors.white : Colors.black,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

