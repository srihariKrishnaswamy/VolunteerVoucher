import 'package:volunteer_voucheria/CreateNewProject/NewProjectpg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;

class Project {
  String _name;
  List <String> _memNames;
  bool _on;

  Project(String name, List<String> memNames, bool on) {
    this._name = name;
    this._memNames = memNames;
    this._on = on;
    myProjs.add(this);

    _firestore.collection('Projects').document(name).setData({
      'name': _name,
      'memList': _memNames,
      'isOn' : _on
    });
  }
  addMember(String memName) {
    this._memNames.add(memName);
  }
  minusMem(String memStr) {
    for(int i = 0; i < this._memNames.length; i++){
      if(memStr == this._memNames[i]) {
        this._memNames.remove(this._memNames[i]);
      }
    }
  }
  //-------------------

  bool get on => _on;

  seton(bool value) {
    _on = value;
  }

  String get name => _name;

  setname(String value) {
    _name = value;
  }

  List<String> get memNames => _memNames;

  setmembers(List<String> value) {
    _memNames = value;
  }




}