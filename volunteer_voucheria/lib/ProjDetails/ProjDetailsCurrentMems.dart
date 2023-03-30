import 'package:flutter/material.dart';
import 'package:volunteer_voucheria/CreateNewProject/NewProjectpg.dart';
import 'package:volunteer_voucheria/CreateNewMember/NewMemberpg.dart';
import 'Proj_Details_Prospectives.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;



class ProjDetailsPgTwo extends StatefulWidget {
  @override
  _ProjDetailsPgTwoState createState() => _ProjDetailsPgTwoState();
}

class _ProjDetailsPgTwoState extends State<ProjDetailsPgTwo> {
  List getMemListNoDB() {
    List myMemList = [];
    for(int i = 0; i < myProjs.length; i ++) {
      if(myProjs[i].on == true) {
        myMemList = myProjs[i].memNames;
      }
    }
    return myMemList;
  }
  onTappedCurrentMem(String memName) {
    int nump = 0;
    for(int i = 0; i < members.length; i++) {
      if(members[i].fullName == memName) {
        // nump = members[i].NumProj - 1;
        // members[i].minusProj();
      }
    }
    for(int i = 0; i < myProjs.length; i ++) {
      if(myProjs[i].on == true) {
          myProjs[i].memNames.remove(memName);
      }
    }
    _firestore.collection('Members').document(memName).updateData({
      'NumProj' : nump
    });

    List myMemList = [];
    var projectQuery =  _firestore.collection('Projects').where("memList", arrayContains: memName); //where("memList", arrayContains: docID)
    projectQuery.getDocuments().then((value) {
      value.documents.forEach((element) {
        if(element.documentID != null) {
          bool isOn = element['isOn'];
          String name = element['name'];
          myMemList = element['memList'];
          print(myMemList);
          print(memName);
          List newList = new List();
          for(int i = 0; i < myMemList.length; i++) {
            if(!(memName == myMemList[i])) {
              newList.add(myMemList[i]);
            }
          }
          print("SEEEEETHIS------------------------------------------------------");
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

  List getMemList() {
    List myMemList = [];
    String str = "";
    var projectQuery = _firestore.collection('Projects').where(
        "isOn", isEqualTo: true); //where("memList", arrayContains: docID)
    projectQuery.getDocuments().then((value) {
      value.documents.forEach((element) {
        if (element.documentID != null) {
          myMemList = element['memList'];
          str = element['name'];
          print(myMemList); // prints out correct memList
        } else {
          print("something went wrong");
        }
      });
    });
    print(myMemList); // prints out empty list
    print(str);
    return myMemList;

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Project Members'),
          automaticallyImplyLeading: false,
          centerTitle: true
      ),
      body: Container(
        color: Colors.lightBlueAccent,
        width: double.infinity,
        child: ListView.builder (
          itemCount: getMemListNoDB().length,
          itemBuilder: (context, index){
            return Card(
              color: Colors.black,
              child: ListTile(
                leading: Icon(Icons.person_remove_outlined , color: Colors.lightBlueAccent),
                title: Text(getMemListNoDB()[index] , style: TextStyle(color: Colors.lightBlueAccent)),
                onTap: () {
                  onTappedCurrentMem(getMemListNoDB()[index]);
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
            return Pgthree();
          }));
        },
        color: Colors.black,
        child: Center(
          widthFactor: 2.5,
          child: Text("Add New Members",style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          )),
        ),
      ),
    )
    );
  }
}
