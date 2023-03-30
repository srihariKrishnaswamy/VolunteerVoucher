import 'package:flutter/material.dart';
import 'package:volunteer_voucheria/CreateNewProject/NewProjectpg.dart';
import 'package:volunteer_voucheria/MainList/MainListpg.dart';
import 'package:volunteer_voucheria/CreateNewMember/NewMemberpg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final _firestore = Firestore.instance;
List getMemListNoDB() {
  List myMemList = new List ();
  for(int i = 0; i < myProjs.length; i ++) {
    if(myProjs[i].on == true) {
      for(int j = 0; j < myProjs[i].memNames.length; j++) {
        myMemList.add(myProjs[i].memNames[j]);
      }
    }
  }
  return myMemList;
}

updateAll(String memName) {
  int nump = 0;
  for(int i = 0; i < members.length; i++) {
    if(members[i].fullName == memName) {
      // nump = members[i].NumProj + 1;
      // members[i].plusProj();
    }
  }
  String projName = "";
  for(int i = 0; i < myProjs.length; i ++) {
    if(myProjs[i].on == true) {
      myProjs[i].addMember(memName);
      projName = myProjs[i].name;
    }
  }

  _firestore.collection('Members').document(memName).updateData({
    'NumProj' : nump
  });
  List myMemList = new List();
  var projectQuery =  _firestore.collection('Projects').where("name", isEqualTo: projName); //where("memList", arrayContains: docID)
  projectQuery.getDocuments().then((value) {
    value.documents.forEach((element) {
      if(element.documentID != null) {
        bool isOn = element['isOn'];
        String name = element['name'];
        myMemList = element['memList'];
        List newList = new List(myMemList.length + 1);
        for(int i = 0; i <myMemList.length; i++) {
          newList[i] = myMemList[i];
        }
        newList[myMemList.length] = memName;
        element.reference.setData({
          'memList': newList,
          'isOn': isOn,
          'name': name,
        });
      } else {
        print("something went wrong");
      }
    });
  });



}
List getRightMems() {
  List toRender = new List();
  for(int i = 0; i < getMemListNoDB().length; i++) {
      for(int j = 0; j < members.length; j++) {
        if((members[j].fullName == getMemListNoDB()[i])) {
          members[j].seton(false);
        }
      }
  }
  for(int i = 0; i < members.length; i++) { //
    if(members[i].on == true ) {
      toRender.add(members[i].fullName);
    }
  }
  for(int i = 0; i < members.length; i++) {
    members[i].seton(true);
  }
  return toRender;
}



turnOff() {
  for(int i = 0; i < myProjs.length; i++) {
    myProjs[i].seton(false);
  }
  List myMemList = [];
  var projectQuery =  _firestore.collection('Projects').where("isOn", isEqualTo: true);
  projectQuery.getDocuments().then((value) {
    value.documents.forEach((element) {
      if(element.documentID != null) {
        String name = element['name'];
        myMemList = element['memList'];
        print(myMemList);
        element.reference.setData({
          'memList': myMemList,
          'isOn': false,
          'name': name,
        });
      } else {
        print("something went wrong");
      }
    });
  });
}


class Pgthree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Project Members'),
            // automaticallyImplyLeading: false,
            centerTitle: true
        ),
        body: Container(
            color: Colors.lightBlueAccent,
            width: double.infinity,
            child: ListView.builder (
              itemCount: getRightMems().length,
              itemBuilder: (context, index){
                  return Card(
                      color: Colors.black,
                    child: ListTile(
                      leading: Icon(Icons.person_add_outlined , color: Colors.lightBlueAccent),
                      title: Text(getRightMems()[index] , style: TextStyle(color: Colors.lightBlueAccent)),
                      onTap: () {
                        print('Member Added to Project');
                        updateAll(getRightMems()[index]);
                      },
                    ),
                  );

              },
            )
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: RaisedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return MainList();
              }));
              turnOff();
            },
            color: Colors.black,
            child: Center(
              widthFactor: 2.5,
              child: Text("Finish Editing",style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
          ),
        )
    );
  }
}
