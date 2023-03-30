import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        height: 160.0,
        child: Column (
            children: <Widget>[
              SizedBox(
                height: 45,
                width: double.infinity,
              ),
              Center(
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            )
        ),
      )
    );
  }
}