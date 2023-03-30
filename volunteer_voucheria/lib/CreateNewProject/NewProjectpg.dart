import 'package:flutter/material.dart';
import 'package:volunteer_voucheria/Classes/Project.dart';
import 'package:volunteer_voucheria/MainList/MainListpg.dart';
import 'package:volunteer_voucheria/CreateNewMember/NewMemberpg.dart';
import 'NewProjScreenTwo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

List<Project> myProjs = [];

String projName = "";
List<String> intermed = []; //List <Member>
final projNameCon = new TextEditingController();

checkDuplicateCreateProj(String name, BuildContext context)  {
  bool noDups = true;
  for(int i = 0; i < myProjs.length; i++) {
    if(name == myProjs[i].toString()) {
      noDups = false;
      print('Can\'t create two projects with the same name');
    }
  }
  if (noDups) {
    createProj(name);
    print('created new project');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainList();
    }));
  }
}

createProj(String projName) {
  Project proj = new Project(projName, intermed, false);
  for(int i = 0; i < members.length; i++) {
    for(int j = 0; j < intermed.length; j++){
      if(members[i].fullName == intermed[j]) {
        // members[i].plusProj();
        // print(members[i].NumProj);
        var projectQuery =  _firestore.collection('Members').where('fullName', isEqualTo: members[i].fullName);
        projectQuery.getDocuments().then((value) {
          value.documents.forEach((element) {
            int NumProj = element['NumProj'];
            String fullName = element['fullName'];
            int maxNumProj = element['maxNumProj'];
            NumProj++;
            element.reference.setData({
              'NumProj': NumProj,
              'maxNumProj': maxNumProj,
              'fullName': fullName,
            });
          });
        });
      }
    }
  }
  intermed = [];
}

List<String> approMems = [];

findMems() async {
  List<String> approMems = []; //List <Member>
  await for (var snapshot in _firestore.collection('Members').snapshots()) {
    for (var doc in  snapshot.documents) {
      if (doc.data['NumProj'] < doc.data['maxNumProj']) {
        approMems.add(doc.data['fullName']);
      }
    }
  }
  return approMems;
}


class NewProject extends StatefulWidget {
  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {

  @override
  Widget build(BuildContext context) {
    findMems();
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Project Members'),
        backgroundColor: Colors.lightBlue,
          automaticallyImplyLeading: false,
          centerTitle: true
      ),
      body: Container(
          width: double.infinity,
          color: Colors.lightBlueAccent,
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Members').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var docs = snapshot.data.documents;
                  return new ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.black,
                          child: ListTile(
                              leading: Icon(Icons.people, color: Colors.lightBlueAccent),
                              title: Text(docs[index].data['fullName'] , style: TextStyle(color: Colors.lightBlueAccent)),
                              onTap: () {
                                intermed.add(docs[index].data['fullName']);
                              }),
                        );
                      });
                } else {
                  return null;
                }
              })),
      bottomNavigationBar: Container(
        height: 100,
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewProjtwo();
            }));
          },
          color: Colors.black,
          child: Center(
            widthFactor: 2.5,
            child: Text("NextStep!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                )),
          ),
        ),
      ),
    );
  }
}
