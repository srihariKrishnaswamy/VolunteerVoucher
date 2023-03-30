import 'package:flutter/material.dart';


class Nonloginpg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.lightBlueAccent,
          child: Column (
            children: <Widget> [
              SizedBox(
                height: 300.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                        'Too many faulty submissions, please close and reopen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 40,
                          color: Colors.white,
                        ),
                    )
                ),
              )
            ]
          ),
        )
      )
    );
  }
}