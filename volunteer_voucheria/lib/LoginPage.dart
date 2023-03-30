import 'package:flutter/material.dart';

import 'Header.dart';
import 'package:volunteer_voucheria/MainList/MainListpg.dart';
import 'package:volunteer_voucheria/Non_LogIn_pg/Non_login_pg.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int numTries = 1;
  String legitUN = "VTS";
  String legitPW = "Org";
  String entryUN;
  String entryPW;

  final unCon = new TextEditingController();
  final pwCon = new TextEditingController();
  String displayMessage = '';
  // login function
  hardLogIn(String legitUN, String legitPW, String entryUN, String entryPW) {
    bool isLoggedIn = false;
    if(numTries <= 5) {
      if(!(entryUN == "") && !(entryPW =="")){
        if(entryUN == legitUN) {
          if(entryPW == legitPW) {
            isLoggedIn = true;
            print('User is Logged In');
          } else {
            numTries ++;
              if(5 - numTries >= 0) {
                displayMessage = 'Wrong Password, you have ${6 - numTries} tries remaining';
              }
          }
        } else {
          displayMessage = 'This Username doesn\'t exist';
        }
      } else if (entryUN.isEmpty && entryPW.isNotEmpty){
        displayMessage = "Enter a Username";
      } else if (entryPW.isEmpty && entryUN.isNotEmpty){
        displayMessage = "Enter a Password";
      } else {
        displayMessage = "Enter a Username and Password";
      }
    }

    if(isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return MainList();
      }));
    } else if (!(numTries <= 5)) {
      displayMessage = 'Too many faulty submissions';
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Nonloginpg();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container (
          width: double.infinity,
          color: Colors.lightBlueAccent,
          child: Column(
            children: <Widget>[
              Header(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.white70)
                          )
                      ),
                      child: TextField(
                        controller: unCon,
                        decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 10
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.white70)
                          )
                      ),
                      child: TextField(
                        controller: pwCon,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(
                height: 20
              ),
              Center(
                child: Text(
                    displayMessage,
                  style: TextStyle(
                    color: Colors.red,
                  )
                ),
              ),
              SizedBox(
                  height: 20
              ),
            RaisedButton(
              onPressed: (){
                setState(() {
                  entryUN = unCon.text;
                  entryPW = pwCon.text;
                });
                print(entryUN);
                print(entryPW);
                hardLogIn(legitUN, legitPW, entryUN, entryPW);
              },
              color: Colors.black,
              child: Center(
                widthFactor: 6.2,
                heightFactor: 3,
                child: Text("Log In",style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                )),
              ),
            ),
              SizedBox(
                  height: 40
              ),
              // RaisedButton(
              //   onPressed: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context){
              //       return SignUppg();
              //     }));
              //   },
              //   color: Colors.black,
              //   child: Center(
              //     widthFactor: 2.5,
              //     child: Text("Make Account",style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 15,
              //     )),
              //   ),
              // )
            ],
          )
        ),
      ),
    );
  }
}


