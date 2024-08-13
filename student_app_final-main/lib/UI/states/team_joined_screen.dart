import 'package:flutter/material.dart';

class TeamJoinedScreen extends StatelessWidget {
   const TeamJoinedScreen({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/classwork_icons/team_created.png'),
              width: 210,
              height: 210,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Team Joined Successfully' ,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color : Colors.black
                ),
                ),
              ],
            ),
            SizedBox(height: 16),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You can now invite your friends to join your team' ,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff999999)
                ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            },
                child: Text(
                  'OK'
                ))
          ],
        )
        ),
    );
  }
}
