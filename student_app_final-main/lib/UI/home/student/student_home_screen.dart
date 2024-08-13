import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Network/local/cache_helper.dart';
import '../../../models/classwork/Grades/Quiz.dart';
import '../../../models/classwork/Section/Section.dart';
import '../../../models/classwork/lecture/Lecture.dart';
import '../../../provider/provider.dart';
import '../../../shared/components.dart';
import 'allAnnouncements_screen.dart';
import 'allAssignments_screen.dart';
import 'notification.dart';


// ignore: must_be_immutable
class StudentHomeScreen extends StatefulWidget {
  StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {

 @override
  void initState() {
    super.initState();
    String uid = CacheHelper.getData(key: 'userId');
    Provider.of<AppProvider>(context, listen: false).clearAllData();
    Provider.of<AppProvider>(context, listen: false).getUpcomingLectures(uid);
    Provider.of<AppProvider>(context, listen: false).getUpcomingSections(uid);
    Provider.of<AppProvider>(context, listen: false).getUpcomingQuizzes(uid);
    Provider.of<AppProvider>(context, listen: false).getAnnouncements(uid);
    Provider.of<AppProvider>(context, listen: false).getAllAssignments(uid);
    Provider.of<AppProvider>(context, listen: false).getUserName(uid);
    _loadStudentName();
  }

 String? studentName;
 Future<void> _loadStudentName() async {
   setState(() {
     studentName = CacheHelper.getData(key : 'studentName');
   });
 }
  
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF27B35),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.0),  // Adjusted for proper scaling without using .w
          child: Row(
            children: [
              Image.asset(
                'assets/images/icons/home_logo.png',
                width: 45,  // Reduced size
                height: 45,  // Reduced size
              ),
            ],
          ),
        ),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 12, end: 12),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none_rounded,
                size: 35,  // Slightly reduced icon size
              ),
              onPressed: () {
                navigateTo(context, const NotificationScreen());
              },
            ),
          ),
          SizedBox(
            width: 8.0,  // Reduced spacing if necessary
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          String uid = CacheHelper.getData(key: 'userId');
          Provider.of<AppProvider>(context, listen: false).getUpcomingLectures(uid);
          Provider.of<AppProvider>(context, listen: false).getUpcomingSections(uid);
          Provider.of<AppProvider>(context, listen: false).getUpcomingQuizzes(uid);
          Provider.of<AppProvider>(context, listen: false).getAnnouncements(uid);
          Provider.of<AppProvider>(context, listen: false).getAllAssignments(uid);
          Provider.of<AppProvider>(context, listen: false).getUserName(uid);
          _loadStudentName();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color:  Color(0xffF27B35),
                    height:180,
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Good Morning  $studentName! ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                       SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 230,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                               Image(
                                image: AssetImage('assets/images/icons/home_photo.jpeg'),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       SizedBox(height: 35,),
                                       Text('Upcoming Lectures: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Color(0xff0B0101)
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      SizedBox(
                                        height: 150,
                                        width: MediaQuery.of(context).size.width,
                                        child: provider.upcomingLectures.isEmpty ? Column(
                                          children: [
                                            const SizedBox(height: 20,),
                                            const Center(
                                              child: Text('No Upcoming Lectures',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: Color(0xff0B0101)
                                                ),
                                              ),
                                            ),
                                          ],
                                        ) :SingleChildScrollView(
                                          child: ListView.builder(
                                            itemCount: provider.upcomingLectures.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) => buildUpcomingEvent(
                                              lecture: provider.upcomingLectures[index],
                                            ),
                                          ),
                                        ) ,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      SizedBox(height: 45,),
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image(
                                  image: NetworkImage('https://media.licdn.com/dms/image/C4E0BAQGOQTvHXZwu3A/company-logo_200_200/0/1631329837288?e=2147483647&v=beta&t=AHUImCb3x94FZMve-87iv28A3d3ZTEq3Hi1HXFgI2s4'),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      height: 230,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          const Image(
                            image: AssetImage('assets/images/icons/studentt.jpg'),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Upcoming Sections: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Color(0xff0B0101)
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  provider.upcomingSections.isEmpty ?Column(
                                    children: [
                                      const SizedBox(height: 20,),
                                      const Center(
                                        child: Text('No Upcoming Sections',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Color(0xff0B0101)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ):SizedBox(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width, // Ensure the ListView has the same width as its parent
                                    child: ListView.builder(
                                      itemCount: provider.upcomingSections.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => buildUpcomingEvent(
                                        section: provider.upcomingSections[index],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      height: 230,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          const Image(
                            image: AssetImage('assets/images/icons/student-logo-vector.jpg'),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 35,),
                                  const Text('Upcoming Quizzes: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Color(0xff0B0101)
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  SizedBox(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: provider.upcomingQuizzes.isEmpty ?Column(
                                      children: [
                                        const SizedBox(height: 20,),
                                        const Center(
                                          child: Text('No Upcoming Quizes',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Color(0xff0B0101)
                                            ),
                                          ),
                                        ),
                                      ],
                                    ) :ListView.builder(
                                      itemCount: provider.upcomingQuizzes.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => buildUpcomingEvent(
                                        quiz: provider.upcomingQuizzes[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal:20
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Announcements',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: 16
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, AllAnnouncementsScreen());
                      },
                      child: Row(
                        children: [
                          Text(
                            'Show all',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                                fontSize: 16
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey[500],),
                        ],
                      ),
                    )
                  ],

                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: provider.announcements.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(provider.announcements[index].announcementTitle! ,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xffF28444)
                          ) ),
                          subtitle: Text(provider.formatDate(provider.announcements[index].announcementTimeStamp! ) , style: TextStyle(color: Colors.grey[500] , fontSize: 12),),
                          isThreeLine: true,
                          trailing: Icon(Icons.announcement),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(provider.announcements[index].announcementTitle! , style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
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
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal:20
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Assignments',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: 16
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, AllAssignmentsScreen());
                      },
                      child: Row(
                        children: [
                          Text(
                            'Show all',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                                fontSize: 16
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey[500],),
                        ],
                      ),
                    )
                  ],

                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: provider.assignments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(provider.assignments[index].title!,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xffF28444)
                          )),
                          subtitle: Text('${provider.assignments[index].courseName!} ${provider.assignments[index].coursesID!}', style: TextStyle(color: Colors.grey[500] , fontSize: 12),),
                          isThreeLine: true,
                          trailing: Icon(Icons.assignment),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(provider.assignments[index].title! , style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    color: Color(0xffF28444)
                                  ),),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(provider.formatDate(provider.assignments[index].deadline!)),
                                        const SizedBox(height: 10,),
                                        Text(provider.assignments[index].description!),
                                      ],
                                    ),
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildUpcomingEvent({Lecture? lecture, Section? section, Quiz? quiz}) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 5, backgroundColor: Color(0xffF28444)),
            const SizedBox(width: 9),
            Flexible(
              child: Text(
                section != null
                    ? '${section.courseName!} Section'
                    : (lecture != null
                    ? '${lecture.courseName} Lecture'
                    : '${quiz!.courseName} Quiz'
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 20),
            Flexible(
              child: Text(
                section != null
                    ? '${formatTime(section.periodStart ?? '')} - ${formatTime(section.periodEnd ?? '')}'
                    : (lecture != null
                    ? '${formatTime(lecture.periodStart ?? '')} - ${formatTime(lecture.periodEnd ?? '')}'
                    : '${formatDate(quiz!.date ?? '')}'
                ),
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xffF28444),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  String formatTime(String timeString) {
    DateTime parsedTime = DateTime.parse("1970-01-01 $timeString");

    // Format the parsed time as desired
    String formattedTime = "${parsedTime.hour}:${parsedTime.minute}";

    return formattedTime;
  }

  String formatDate(String isoString) {
    DateTime parsedDate = DateTime.parse(isoString);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }

}
