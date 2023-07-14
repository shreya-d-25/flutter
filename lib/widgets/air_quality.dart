import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/size_config.dart';
import 'package:scrc/widgets/details_title.dart';
import 'package:scrc/widgets/summary_details_card.dart';

import '../providers/verticals.dart';

class AirQuality extends StatelessWidget {
  var details;
  AirQuality({this.details});

  @override
  Widget build(BuildContext context) {
    final aqi = int.parse(details['aqi']);
    //print(details['aqi']);
    String backgroundImage;

    if (aqi >= 0 && aqi <= 50) {
      backgroundImage = 'assets/background/env1.png';
    } else if (aqi >= 51 && aqi <= 100) {
      backgroundImage = 'assets/background/desert.png';
    } else {
      backgroundImage = 'assets/background/snow.png';
    }

    print(details);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // background image
          image: DecorationImage(
              image: AssetImage(backgroundImage), fit: BoxFit.cover)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DetailsTitle(imagePath: 'assets/icon/aq.png', title: 'Air Quality'),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SummaryDetailsCard(name: "PM10", value: details["pm10"]),
          SummaryDetailsCard(name: "PM25", value: details["pm25"]),
          SummaryDetailsCard(name: "AQI", value: details["aqi"]),
        ],
      ),
    );
  }
}
