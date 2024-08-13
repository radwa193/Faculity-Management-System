import 'package:flutter/material.dart';

class TeamJoinedScreen extends StatelessWidget {
  const TeamJoinedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/classwork_icons/regiteres_team.png'),
                width: 210,
                height: 210,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You are Registered to  a team' ,
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
                  Text('Team Name : The Sharks' ,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff999999)
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
