import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/theme.dart';
import 'package:scrc/widgets/Water_quality.dart';
import 'package:scrc/widgets/air_quality.dart';
import 'package:scrc/widgets/deployment.dart';
import 'package:scrc/widgets/solar_energy.dart';
import 'package:scrc/widgets/summary_details_card.dart';
import 'package:scrc/widgets/water_usage.dart';
import 'package:scrc/widgets/weather.dart';

import '../providers/verticals.dart';

class SummaryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final summaryData = Provider.of<Summaries>(context);
    final summary = summaryData.items;

    return SingleChildScrollView(
        //theme: ThemeData(primarySwatch: Colors.blue),
        child: Column(
      children: [
        SizedBox(height: 10),
        Container(
          height: 200,
          child: AirQuality(
            details: summary["aq"],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: Weather(
            details: summary["we"],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: SolarEnergy(
            details: summary["sl"],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: WaterQuality(
            details: summary["wd"],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: WaterUsage(
            details: summary["wf"],
          ),
        ),
        SizedBox(height: 10),
        Deployment(details: summary),
      ],
    ));
  }
}
