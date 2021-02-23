import 'package:flutter/material.dart';

class IconGit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Image.asset(
        'assets/explore.png',
        height: 100,
        width: 200,
      ),
    );
  }
}
