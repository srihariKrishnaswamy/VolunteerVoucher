import 'package:flutter/material.dart';
import 'NewProjectpg.dart';

class NewProjtwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Name New Project'),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true
        ),
        body: SafeArea(
            child: Container(
              width: double.infinity,
              color: Colors.lightBlueAccent,
              child: Column(
                children: <Widget>[
                  Container(
                      width: 350,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 220
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white70)
                                )
                            ),
                            child: TextField(
                              controller: projNameCon,
                              decoration: InputDecoration(
                                  hintText: "Project Name",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 100
                          ),
                          RaisedButton(
                            onPressed: (){
                              checkDuplicateCreateProj(projNameCon.text, context);
                              intermed = [];
                              print('Project Created: ' + projNameCon.text + intermed.toString());
                            },
                            color: Colors.black,
                            child: Center(
                              widthFactor: 2.5,
                              child: Text("Create Project!",style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            )
        )
    );
  }
}


