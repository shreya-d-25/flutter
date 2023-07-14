import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/size_config.dart';
import 'package:scrc/widgets/details_title.dart';
import 'package:scrc/widgets/summary_details_card.dart';

import '../providers/verticals.dart';

class Weather extends StatelessWidget {
  var details;
  Weather({this.details});
  @override
  Widget build(BuildContext context) {
    final we = int.parse(details['relative_humidity'].split(" ")[0]);
    print(we);

    String backgroundImage;
    if (we < 60 && we >= 20) {
      backgroundImage = 'assets/background/gwe.png';
    } else if (we <= 80 && we >= 60) {
      backgroundImage = 'assets/background/okwe.png';
    } else {
      backgroundImage = 'assets/background/bwe.png';
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
              //imagePath: 'assets/icon/we.png',
              title: '                    Weather'),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SummaryDetailsCard(
              name: "Temperature",
              value: details["temperature"],
              textColor: Colors.black

              //cardColor: temperature > 20 ? Colors.red : null,
              ),
          SummaryDetailsCard(
              name: "rHumidity",
              value: details["relative_humidity"],
              textColor: Colors.black),
          SummaryDetailsCard(
              name: "Solar Radiation",
              value: details["solar_radiation"],
              textColor: Colors.black),
        ],
      ),
    );
  }
}
