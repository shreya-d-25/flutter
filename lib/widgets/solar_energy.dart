import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/size_config.dart';
import 'package:scrc/widgets/details_title.dart';
import 'package:scrc/widgets/summary_details_card.dart';

import '../providers/verticals.dart';

class SolarEnergy extends StatelessWidget {
  var details;
  SolarEnergy({this.details});
  @override
  Widget build(BuildContext context) {
    // final se = int.parse(details['eac_today']);
    // print(se);

    // String backgroundImage;
    // if (se > 400) {
    //   backgroundImage = 'assets/background/se.png';
    // } else if (se >= 250 && se <= 400) {
    //   backgroundImage = 'assets/background/okse.p.ng';
    // } else {
    //   backgroundImage = 'assets/background/bse.png';
    // }

    print(details);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: AssetImage('assets/background/se.png'), fit: BoxFit.fill)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetailsTitle(
              //imagePath: 'assets/icon/se.png',
              title: '                    Solar Energy'),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SummaryDetailsCard(
              name: "Energy Generated",
              value: details["eac_today"] + "kWh",
              textColor: Colors.black),
        ],
      ),
    );
  }
}
