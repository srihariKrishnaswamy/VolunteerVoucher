import 'package:flutter/material.dart';
import 'package:volunteer_voucheria/MainList/MainListpg.dart';
import 'package:volunteer_voucheria/CreateNewProject/NewProjectpg.dart';
import 'package:volunteer_voucheria/CreateNewMember/NewMemberpg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


delMem(String mem){
  for(int i = 0 ; i < myProjs.length; i++) {
    for(int j = 0; j < myProjs[i].memNames.length; j++) {
      if(mem == myProjs[i].memNames[j]){
        myProjs[i].memNames.remove(myProjs[i].memNames[j]);
      }
    }
  }

  for(int i = 0; i < members.length; i++) {
    if(mem == members[i].fullName) {
      members.remove(members[i]);
    }
  }
}

class MemListPG extends StatefulWidget {

  @override
  _MemListPGState createState() => _MemListPGState();
}

class _MemListPGState extends State<MemListPG> {
  final _firestore = Firestore.instance;
  String fullName = "";
  delMemberDB(dynamic docID) async {
    delMem(docID);
    List myMemList = [];
    var projectQuery =  _firestore.collection('Projects').where("memList", arrayContains: docID);
    projectQuery.getDocuments().then((value) {
      value.documents.forEach((element) {
        if(element.documentID != null) {
          bool isOn = element['isOn'];
          String name = element['name'];
          myMemList = element['memList'];
          print(myMemList);
          print(docID);
          List newList = new List();
          for(int i = 0; i < myMemList.length; i++) {
            if(!(docID == myMemList[i])) {
              newList.add(myMemList[i]);
            }
          }
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
    _firestore
      .collection('Members')
      .document(docID)
      .delete()
      .catchError((e)  {
        print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Member Dashboard'),
          backgroundColor: Colors.lightBlue,
            automaticallyImplyLeading: false,
            centerTitle: true
        ),
        body: SafeArea(
          child: Container(
            color: Colors.lightBlueAccent,
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Members').snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData) {
                  var docs = snapshot.data.documents;
                  return new ListView.builder (
                    itemCount: docs.length,
                    itemBuilder: (context, index){
                      return Card(
                        color: Colors.black,
                        child: ListTile(
                          leading: Icon(Icons.person_outline_outlined   , color: Colors.lightBlueAccent),
                          title: Text(docs[index].data['fullName'] , style: TextStyle(color: Colors.lightBlueAccent)),
                          onLongPress: () {
                            delMemberDB(docs[index].data['fullName']);
                          },
                        ),
                      );
                    },
                  );
                }else{
                  return null;
                }
              }
            ),
          )
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: RaisedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return MainList();
              }));
            },
            color: Colors.black,
            child: Center(
              widthFactor: 2.5,
              child: Text("Back to Project Dash",style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
          ),
        ),
    );;
  }
}
