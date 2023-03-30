import 'package:flutter/material.dart';
import 'package:volunteer_voucheria/Classes/Member.dart';
import 'package:volunteer_voucheria/MainList/MainListpg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List <Member> members = [];

class NewMember extends StatefulWidget {

  @override
  _NewMemberState createState() => _NewMemberState();
}
String errorMessage = '';
class _NewMemberState extends State<NewMember> {

  final fullNameCon = new TextEditingController();
  final mnpCon = new TextEditingController();
  String fullName;
  String maxNumProj;
  String str = "";


  createMember() {
    Member mem = new Member(fullName);
  }

  checkDuplicateCreate(String name, BuildContext context)  {
    bool noDups = true;
    for(int i = 0; i < members.length; i++) {
      if(name == members[i].fullName) {
        noDups = false;
      }
    }
    if(noDups) {
      createMember();
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return MainList();
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
          child: Column( // ------------------------this is where everything's nested
            children: <Widget>[
              AppBar(
                title: Text('Create new Member'),
                backgroundColor: Colors.lightBlue,
                  centerTitle: true
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                  width: 350,
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
                          controller: fullNameCon,
                          decoration: InputDecoration(
                              hintText: "Member full Name",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 100
                      ),
                    ],
                  )
              ),
              Center(
                child: Text(errorMessage, style: TextStyle(
                  color: Colors.red,
                )),
              ),
              SizedBox(
                  height: 100
              ),
              RaisedButton(
                onPressed: (){
                  fullName = fullNameCon.text;
                  maxNumProj = mnpCon.text;
                  checkDuplicateCreate(fullName, context);
                },
                color: Colors.black,
                child: Center(
                  widthFactor: 2.5,
                  child: Text("Create Member!",style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  )),
                ),
              )
            ],
          ), // ---------------------------------------
        ),
      ),
    );
  }
}



