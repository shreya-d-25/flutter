import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';

import '../providers/verticals.dart';

class DetailsTitle extends StatelessWidget {
  String imagePath;
  String title;
  DetailsTitle({this.imagePath, this.title});
  //Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Image.asset(imagePath),
        ),
        Text(
          title,
          style: (title == 'Deployment')
              ? TextStyle(color: Colors.white)
              : TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
