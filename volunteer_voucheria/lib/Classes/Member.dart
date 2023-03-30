import 'package:volunteer_voucheria/CreateNewMember/NewMemberpg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  String _fullName;
  bool _on;

  Member(String fullName) {
    this._fullName = fullName;
    this._on = true;
    members.add(this);



    final _firestore = Firestore.instance;
    _firestore.collection('Members').document(fullName).setData({
      'fullName': fullName,
    });

  }

  String get fullName => _fullName;

  set firstName(String value) {
    _fullName = value;
  }
  bool get on => _on;

  seton(bool value) {
    _on = value;
  }

  String toString() {
    return this._fullName;
  }


}