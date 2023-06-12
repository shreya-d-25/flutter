import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrc/widgets/main_drawer.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = "/about";
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.blue,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            //statusBarColor: Colors.blue,
          ),
          title: Text("About", style: TextStyle(color: Colors.black)),

          //elevation: 0.0,
        ),
        drawer: MyDrawer(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "The Smart City Research Center is setup with support from MEITY (Government of India), Smart City Mission and Government of Telangana at IIITH. The research center includes a Living Lab, that is a setup with support from EBTC and Amsterdam Innovation Arena.\n\n"
            "There is a huge push for smart cities in India under the Smart Cities Mission, a new initiative by the Government of India to drive economic growth and improve the quality of life of people by enabling local development and harnessing technology to create smart outcomes for citizens. In this ambitious project, 100 cities are being covered for the duration of 5 years with a budget of Rs.100 crore per city per year. The goal of the Living Lab plan is to create an urban area enhancing three value domains: social, economic and environmental.",
            textScaleFactor: 1.16,
            //style: TextStyle(decoration: ),
          ),
        ));
  }
}
