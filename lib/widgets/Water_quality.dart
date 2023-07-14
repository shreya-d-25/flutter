import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/size_config.dart';
import 'package:scrc/widgets/details_title.dart';
import 'package:scrc/widgets/summary_details_card.dart';

import '../providers/verticals.dart';

class WaterQuality extends StatelessWidget {
  var details;
  WaterQuality({this.details});
  @override
  Widget build(BuildContext context) {
    final wq = int.parse(details['compensated_tds_value'].split(" ")[0]);
    print(wq);

    String backgroundImage;
    if (wq < 150) {
      backgroundImage = 'assets/background/gwq.png';
    } else if (wq >= 150 && wq <= 300) {
      backgroundImage = 'assets/background/okwq.png';
    } else {
      backgroundImage = 'assets/background/bwq.png';
    }

    print(details);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: AssetImage(backgroundImage), fit: BoxFit.fill)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetailsTitle(
              //imagePath: 'assets/icon/wd.png',
              title: '                    Water Quality'),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SummaryDetailsCard(
              name: "TDS",
              value: details["compensated_tds_value"],
              textColor: Colors.black),
        ],
      ),
    );
  }
}
