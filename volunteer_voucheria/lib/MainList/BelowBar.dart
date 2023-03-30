import 'package:flutter/material.dart';
import 'package:volunteer_voucheria/CreateNewMember/NewMemberpg.dart';
import 'package:volunteer_voucheria/CreateNewProject/NewProjectpg.dart';
import 'package:volunteer_voucheria/LoginPage.dart';
import 'package:volunteer_voucheria/MemberDash/MemberListPG.dart';
class BelowBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            IconButton(
                icon:Icon(Icons.list),
                color: Colors.lightBlue,
                onPressed: () {
                  print('Member Dash');
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return MemListPG();
                  }));
                }
            ),
            IconButton(
                icon:Icon(Icons.people),
                color: Colors.lightBlue,
                onPressed: () {
                  print('Member');
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return NewMember();
                  }));
                }
            ),
            IconButton(
                color: Colors.lightBlue,
                icon:Icon(Icons.work),
                onPressed: () {
                  intermed = [];
                  print('Projects');
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return NewProject();
                  }));
                }
            ),
            IconButton(
                color: Colors.red,
                icon:Icon(
                    Icons.home
                ),
                onPressed: () {
                  print('Home');
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return LoginPage();
                  }));
                }
            )
          ],
        ),
    );
  }
}


