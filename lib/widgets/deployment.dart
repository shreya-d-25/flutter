import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/size_config.dart';
import 'package:scrc/widgets/details_title.dart';
import 'package:scrc/widgets/summary_details_card.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../providers/verticals.dart';

class Deployment extends StatelessWidget {
  var details;
  Deployment({this.details});
  @override
  Widget build(BuildContext context) {
    var summ = details["sr_ac"]["nodes"] +
        details["sr_aq"]["nodes"] +
        details["sr_em"]["nodes"] +
        details["sr_oc"]["nodes"];
    print(details);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              //     // image: SvgPicture.assetNetwork('assets/background/winners.svg')
              //     //     .image,
              //     fit: BoxFit.cover)
              image: AssetImage('assets/background/deployment.jpg'),
              fit: BoxFit.cover)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsTitle(imagePath: 'assets/icon/s.png', title: 'Deployment'),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SummaryDetailsCard(
              name: "Weather Station",
              //value: details["we"]["nodes"].toString(),
              value: '3',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "Wi-SUN",
              //value: details["wn"]["nodes"].toString(),
              value: '60',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "Air Quality",
              //value: details["aq"]["nodes"].toString(),
              value: '10',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "Water Distribution",
              //value: details["wd"]["nodes"].toString(),
              value: '8',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "Water Flow",
              //value: details["wf"]["nodes"].toString(),
              value: '20',
              textColor: Colors.white),
          // SummaryDetailsCard(
          //     name: "Weather Station",
          //     value: details["we"]["nodes"].toString(),
          //     textColor: Colors.white),
          SummaryDetailsCard(
              name: "Solar Energy",
              //value: details["sl"]["nodes"].toString(),
              value: '6',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "Energy Monitoring",
              //value: details["em"]["nodes"].toString(),
              value: '50',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "Smart Room (total)",
              //value: summ.toString(),
              value: '112',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "  - Air Conditioning",
              value: '91',

              //value: details["sr_ac"]["nodes"].toString(),
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "  - Occupancy",
              value: '6',

              //value: details["sr_oc"]["nodes"].toString(),
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "  - Air Quality",
              //value: details["sr_aq"]["nodes"].toString(),
              value: '12',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "  - Energy Monitoring",
              //value: details["sr_em"]["nodes"].toString(),
              value: '3',
              textColor: Colors.white),
          SummaryDetailsCard(
              name: "Crowd Monitoring",
              //value: details["cm"]["nodes"].toString(),
              value: '6',
              textColor: Colors.white),
        ],
      ),
    );
  }
}
