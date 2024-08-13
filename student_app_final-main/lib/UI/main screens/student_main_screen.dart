import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class StudentMainScreen extends StatelessWidget {
  const StudentMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: provider.studentBottomScreens[provider.studentCurrentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
            items:  [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage('assets/images/icons/Vector.png'),
                  color: provider.studentCurrentIndex == 0
                      ? const Color(0xffF27B35)
                      : null,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage('assets/images/icons/Message.png'),
                  color: provider.studentCurrentIndex == 1
                      ? const Color(0xffF27B35)
                      : null,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage('assets/images/icons/Book.png'),
                  color: provider.studentCurrentIndex == 2
                      ? const Color(0xffF27B35) // Change color when selected
                      : null,
                ),
                label: 'Classwork',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage('assets/images/icons/settings.png'),
                  color: provider.studentCurrentIndex == 3
                      ? const Color(0xffF27B35)
                      : null,
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: provider.studentCurrentIndex,
            iconSize: 35,
            onTap: provider.changeStudentBottomNav,
            selectedItemColor: const Color(0xffF27B35),
          ),
        ),
      ),
    );
  }
}
