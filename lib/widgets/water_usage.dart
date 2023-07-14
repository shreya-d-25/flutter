import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/size_config.dart';
import 'package:scrc/widgets/details_title.dart';
import 'package:scrc/widgets/summary_details_card.dart';

import '../providers/verticals.dart';

class WaterUsage extends StatelessWidget {
  var details;
  WaterUsage({this.details});
  @override
  Widget build(BuildContext context) {
    // final wf = int.parse(details['total_flow'].split(" ")[0]);
    // print(wf);

    // String backgroundImage;
    // if (wf > 15000) {
    //   backgroundImage = 'assets/background/gwater.png';
    // } else if (wf < 15000 && wf > 10000) {
    //   backgroundImage = 'assets/background/okwu.png';
    // } else {
    //   backgroundImage = 'assets/background/bwu.png';
    // }

    print(details);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: AssetImage('assets/background/gwater.png'),
              fit: BoxFit.fill)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetailsTitle(
              imagePath: 'assets/icon/w.png',
              title: '                    Water Usage'),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SummaryDetailsCard(
              name: "Total Flow",
              value: details["total_flow"],
              textColor: Colors.black),
        ],
      ),
    );
  }
}
