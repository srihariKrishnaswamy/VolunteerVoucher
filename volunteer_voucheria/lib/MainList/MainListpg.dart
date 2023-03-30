import 'package:flutter/material.dart';
import 'package:volunteer_voucheria/MainList/BelowBar.dart';
import 'package:volunteer_voucheria/CreateNewProject/NewProjectpg.dart';
import 'package:volunteer_voucheria/ProjDetails/ProjDetailsCurrentMems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List <String> names = [];

class MainList extends StatelessWidget {

  final _firestore = Firestore.instance;


  delProjectDB(docID) {
    List  projMemList = new List();
    for(int i = 0; i < myProjs.length; i++) {
      if(myProjs[i].name == docID) {
        for(int j = 0; j < myProjs[i].memNames.length; j++) {
          projMemList.add(myProjs[i].memNames[j]);
        }
        myProjs.remove(myProjs[i]);
      }
    }

    print("Project MEM LIST");
    print(projMemList);
    for(int i = 0; i < projMemList.length; i++) {
      var projectQuery =  _firestore.collection('Members').where("fullName", isEqualTo: projMemList[i]);
      projectQuery.getDocuments().then((value) {
        value.documents.forEach((element) {
          int NumProj = element['NumProj'];
          int maxNumProj = element['maxNumProj'];
          String fullName = element['fullName'];
          NumProj--;
          element.reference.setData({
            'NumProj': NumProj,
            'maxNumProj': maxNumProj,
            'fullName': fullName,
          });
        });
      });
    }
    _firestore
        .collection('Projects')
        .document(docID)
        .delete()
        .catchError((e)  {
      print(e);
    });
  }
  turnOn(String str) {
    for(int i = 0; i < myProjs.length; i++) {
      if(myProjs[i].name == str) {
        myProjs[i].seton(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Dashboard'),
            backgroundColor: Colors.lightBlue,
          automaticallyImplyLeading: false,
          centerTitle: true
      ),
      body: SafeArea(
        child: Container(
          color: Colors.lightBlueAccent,
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('Projects').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                var docs = snapshot.data.documents;
                return new ListView.builder (
                  itemCount: docs.length,
                  itemBuilder: (context, index){
                    return Card(
                      color: Colors.black,
                      child: ListTile(
                        leading: Icon(Icons.workspaces_outline, color: Colors.lightBlueAccent),
                        title: Text(docs[index].data['name'], style: TextStyle(color: Colors.lightBlueAccent)),
                        trailing: Icon(Icons.pending_outlined, color: Colors.lightBlueAccent),
                        onTap: () {
                          try {
                            _firestore
                                .collection('Projects')
                                .document(docs[index].data['name'])
                                .updateData({'isOn': true});
                          } catch (e) {
                            print(e.toString());
                          }
                          turnOn(docs[index].data['name']);
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ProjDetailsPgTwo();
                          }));
                        },
                        onLongPress: () {
                          delProjectDB(docs[index].data['name']);
                        },
                      ),
                    );
                  },
                );
              } else {
                return null;
              }
            },
          ),
        )
        ),
        bottomNavigationBar: BelowBar()
    );
  }
}
