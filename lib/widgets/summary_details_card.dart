import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';

import '../providers/verticals.dart';

class SummaryDetailsCard extends StatelessWidget {
  var name;
  var value;
  Color textColor;
  SummaryDetailsCard({this.name, this.value, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name + ": ",
          style: TextStyle(color: textColor),
        ),
        Text(
          value,
          style: TextStyle(color: textColor),
        )
      ],
    );
  }
}
