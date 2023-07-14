import 'dart:ui';
//import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/vertical.dart';
import 'package:scrc/screens/vertical_detail_screen.dart';
import 'package:scrc/providers/verticals.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/admin_vertical_detail_screen.dart';
import '../screens/node_management.dart';
import '../size_config.dart';

class VerticalItem extends StatefulWidget {
  @override
  _VerticalItemState createState() => _VerticalItemState();
}

class _VerticalItemState extends State<VerticalItem> {
  var readings = Map();
  Vertical vertical;
  bool _isLoading = false;
  bool _isInit = true;
  Color cardColor = Colors.white;
  int temperatureValue = 0;
  int t;
  var min;
  var max;
  int touchedReading;
  int n;

  // int solarRadiation;
  // int relHumidity;
  final gradientColors = [
    Colors.greenAccent[400],
    Colors.yellow[600],
    Color.fromARGB(255, 251, 36, 32)
  ];
  Gradient cardGradient;
  //Gradient cardGradient;
  //  = LinearGradient(
  //     begin: Alignment.topLeft,
  //     end: Alignment.bottomRight,
  //     colors: [Colors.white]);

  Future<void> fetchAvg(String name) async {
    var url = Uri.parse("https://smartcitylivinglab.iiit.ac.in/verticals/avg");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null) {
        extractedData.forEach((prodName, prodData) {
          if (prodName == name) {
            prodData.forEach((key, value) {
              // Double val = value as Double;
              // if (key != "nodes" && key != "name")
              //   readings[key] = value.toStringAsFixed(2);
              // if (key == "name") readings[key] = value;
              if (key != "nodes") readings[key] = value;
            });
            //temperature is received as "29 °C"
            //String txt = readings["temperature"];
            // List<String> substrings = txt.split(" ");
            // int val = int.parse(substrings[0]);

            //String val = "29 °C";
            //String name = "COCA COLA";

            //String val = (readings["temperature"]);
            //print((readings["temperature"]).split(" "));
            // print(val.split(" "));

            //List<String> d = val.split(" ");
            // print(d[0]);

            try {
              if (readings["temperature"] != null) {
                temperatureValue =
                    int.parse(readings["temperature"].split(" ")[0]);
              }
            } catch (e) {
              temperatureValue = 0;
            }
            print(temperatureValue);
            //temperatureValue = 25;

            /*
            if (temperatureValue <= 20 && temperatureValue > 0) {
              cardColor = Colors.green;
            } else if (40 > temperatureValue && temperatureValue > 20) {
              cardColor = Colors.orange;
              // final from = Colors.orange[400];
              // final to = Colors.orange[200];
              // final gradientColors = [from, to];

              //cardColor = Colors.orange;
              // final from = Colors.orange[400];
              // final to = Colors.orange[200];
              // final gradientColors = [from, to];

              // cardColor = LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: gradientColors,
              // ).createShader(Rect.fromLTWH(0, 0, 1, 1));
            } else if (temperatureValue >= 40) {
              cardColor = Colors.red;
            }
            */

          }
        });
      } else {
        readings["Error"] = "Error";
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (this.mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      vertical = Provider.of<Vertical>(context, listen: false);
      fetchAvg(vertical.title).then((value) {
        if (this.mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  //method for changing vcolor of vertical
  void changeVerticalColor(String key, var a, var b) {
    print("hey!!");
    print(readings[key]);
    try {
      if (readings[key] != null) {
        t = int.parse(readings[key].split(" ")[0]);
      }
    } catch (e) {
      t = 0;
    }
    print(t);
    //t = int.parse(readings[key].split(" ")[0]);
    //if (key == "temperature") {
    setState(() {
      //touched = true;
      //final t = (temperatureValue - 20) / 20;
      touchedReading = readings.keys.toList().indexOf(key);
      if (t == 0) {
        cardColor = Colors.white;
        //no color change
      } else if (t < a) {
        //temp <25
        cardColor = Colors.greenAccent[400];
      } else if (t < b) {
        //25<temp<30
        cardColor = null;
        cardGradient = LinearGradient(colors: gradientColors);
      } //temp>30
      else {
        cardColor = Color.fromARGB(255, 251, 36, 32);
      }
    });
    //}
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> r = [];
    //n = vertical.vertices.length - vertical.m;

    ///the list to add widget column
    if (!_isLoading) {
      readings.forEach((key, value) {
        if (key != "name") {
          var column3 = Column(
            /////reading 1W/m^2
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // when click on solar radiation
              FittedBox(
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight:
                        (touchedReading == readings.keys.toList().indexOf(key))
                            ? FontWeight.w900
                            : FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.2,
                    color: (touchedReading ==
                                readings.keys.toList().indexOf(key)) &&
                            (cardColor != Colors.white)
                        ? Colors.white
                        : Colors.black,

                    //Colors.black,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 6),
                // child: GestureDetector(
                //   onTap: () {
                //     print("HI");
                //     if (key == "temperature") {
                //       setState(() {
                //         // cardColor =
                //         //     temperatureValue < 20 ? Colors.green : Colors.red;

                //         if (temperatureValue <= 20 && temperatureValue > 0) {
                //           cardColor = Colors.green;
                //         } else if (40 > temperatureValue &&
                //             temperatureValue > 20) {
                //           cardColor = Colors.orange;
                //         } else if (temperatureValue >= 40) {
                //           cardColor = Colors.red;
                //         }
                //       });
                //     }
                //
                //   },
                child: FittedBox(
                  ///solar radiation
                  child: Text(
                    key.toString().toUpperCase().replaceAll("_", " "),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: (touchedReading ==
                              readings.keys.toList().indexOf(key))
                          ? FontWeight.w900
                          : FontWeight.w500,
                      fontSize: 12,
                      color: (touchedReading ==
                                  readings.keys.toList().indexOf(key)) &&
                              (cardColor != Colors.white)
                          ? Colors.white
                          : Colors.black45.withOpacity(0.7),
                      //Colors.black45.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          );
          var column2 = column3;
          var column = column2;
          //the whole box including text and reading

          r.add(GestureDetector(
            //onTap: () => print("hi"),
            onTap: () {
              print("HI");
              //weather station
              if (key == "temperature") {
                min = 25;
                max = 30;
                print(vertical.title);
              }
              if (key == "solar_radiation") {
                min = 2;
                max = 4;
              }
              if (key == "relative_humidity") {
                min = 60;
                max = 80;
              }
              if (key == "wind_direction") {
                min = 500;
                max = 1000;
              }
              if (key == "wind_speed") {
                min = 20;
                max = 40;
              }
              if (key == "gust_speed") {
                min = 20;
                max = 40;
              }
              if (key == "dew_point") {
                min = 16;
                max = 19;
              }
              if (key == "battery_dc_voltage") {
                min = 5;
                max = 8;
              }
              if (key == "rain") {
                min = 20;
                max = 40;
              }
              if (key == "pressure") {
                min = 1000;
                max = 2000;
              }
              //air quality
              if (key == "pm25") {
                min = 30;
                max = 60;
              }
              if (key == "pm10") {
                min = 50;
                max = 100;
              }
              if (key == "co") {
                min = 1.0;
                max = 2.0;
              }
              if (key == "no2") {
                min = 40;
                max = 80;
              }
              if (key == "nh3") {
                min = 200;
                max = 400;
              }
              if (key == "aqi") {
                min = 50;
                max = 100;
              }
              if (key == "aql") {
                min = 50;
                max = 100;
              }
              if (key == "aqi_mp") {
                min = 50;
                max = 100;
              }
              //wisun
              if (key == "rssi") {
                min = 60;
                max = 80;
              }
              if (key == "latency") {
                min = 2000;
                max = 5000;
              }
              if (key == "data_rate") {
                min = 60;
                max = 100;
              }
              if (key == "packet_size") {
                min = 40;
                max = 60;
              }
              if (key == "rsl_in") {
                min = 60;
                max = 80;
              }
              if (key == "etx") {
                min = 195;
                max = 250;
              }
              if (key == "rpl_rank") {
                min = 20000;
                max = 40000;
              }
              if (key == "mac_tx_failed_count") {
                min = 2;
                max = 4;
              }
              if (key == "mac_tx_count") {
                min = 5000;
                max = 9000;
              }
              //water flow
              if (key == "flowrate") {
                min = 40;
                max = 60;
              }
              if (key == "total_flow") {
                min = 25000;
                max = 50000;
              }
              if (key == "pressure_voltage") {
                min = 40;
                max = 60;
              }
              //water distribution
              if (key == "tds_voltage") {
                min = 4;
                max = 6;
              }
              if (key == "uncompensated_tds_value") {
                min = 100;
                max = 250;
              }
              if (key == "compensated_tds_value") {
                min = 300;
                max = 500;
              }
              if (key == "water_level") {
                min = 40;
                max = 60;
              }
              if (key == "ph") {
                min = 40;
                max = 60;
              }
              if (key == "turbidity") {
                min = 40;
                max = 60;
              }
              //solar energy
              if (key == "eac_today") {
                min = 170;
                max = 200;
              }
              if (key == "eac_total") {
                min = 200000;
                max = 600000;
              }
              if (key == "active_power") {
                min = 20000;
                max = 25000;
              }
              if (key == "voltage_rs") {
                min = 300;
                max = 350;
              }
              if (key == "voltage_st") {
                min = 300;
                max = 350;
              }
              if (key == "voltage_tr") {
                min = 300;
                max = 350;
              }
              if (key == "frequency") {
                min = 200;
                max = 300;
              }
              if (key == "power_factor") {
                min = 2;
                max = 5;
              }
              if (key == "voltage1") {
                min = 100;
                max = 200;
              }
              if (key == "current1") {
                min = 40;
                max = 60;
              }
              if (key == "power1") {
                min = 8000;
                max = 10000;
              }
              if (key == "voltage2") {
                min = 100;
                max = 200;
              }
              if (key == "current2") {
                min = 40;
                max = 60;
              }
              if (key == "power2") {
                min = 8000;
                max = 10000;
              }
              if (key == "voltage3") {
                min = 340;
                max = 360;
              }
              if (key == "current3") {
                min = 40;
                max = 60;
              }
              if (key == "power3") {
                min = 8000;
                max = 10000;
              }
              if (key == "pv1_voltage") {
                min = 300;
                max = 350;
              }
              if (key == "pv1_current") {
                min = 40;
                max = 60;
              }
              if (key == "pv1_power") {
                min = 8000;
                max = 10000;
              }
              if (key == "pv2_voltage") {
                min = 340;
                max = 360;
              }
              if (key == "pv2_current") {
                min = 40;
                max = 60;
              }
              if (key == "pv2_power") {
                min = 8000;
                max = 10000;
              }
              if (key == "pv3_voltage") {
                min = 340;
                max = 360;
              }
              if (key == "pv3_current") {
                min = 40;
                max = 60;
              }
              if (key == "pv3_power") {
                min = 8000;
                max = 10000;
              }
              if (key == "pv4_voltage") {
                min = 340;
                max = 360;
              }
              if (key == "pv4_current") {
                min = 40;
                max = 60;
              }
              if (key == "pv4_power") {
                min = 8000;
                max = 10000;
              }
              if (key == "pv5_voltage") {
                min = 340;
                max = 360;
              }
              if (key == "pv5_current") {
                min = 40;
                max = 60;
              }
              if (key == "pv5_power") {
                min = 8000;
                max = 10000;
              }
              if (key == "pv6_voltage") {
                min = 340;
                max = 360;
              }
              if (key == "pv6_current") {
                min = 50;
                max = 60;
              }
              if (key == "pv6_power") {
                min = 8000;
                max = 10000;
              }
              //energy monitoring
              if (key == "r_current") {
                min = 1000000;
                max = 1000005;
              }
              if (key == "y_current") {
                min = 1000000;
                max = 1000005;
              }
              if (key == "b_current") {
                min = 1000000;
                max = 1000005;
              }
              if (key == "r_voltage") {
                min = 340;
                max = 360;
              }
              if (key == "y_voltage") {
                min = 340;
                max = 360;
              }
              if (key == "b_voltage") {
                min = 340;
                max = 360;
              }
              if (key == "power_factor") {
                min = 2;
                max = 6;
              }
              if (key == "apparent_power") {
                min = 700000;
                max = 1000005;
              }
              if (key == "real_power") {
                min = 300000;
                max = 500005;
              }
              if (key == "energy_consumption") {
                min = 5000000;
                max = 7000000;
              }
              if (key == "reactive_energy_lead") {
                min = 6000000;
                max = 7000000;
              }
              if (key == "reactive_energy_lag") {
                min = 6000000;
                max = 7000005;
              }
              if (key == "total_energy_consumption") {
                min = 5000000;
                max = 7000000;
              }
              //sm-aq
              if (key == "co2") {
                min = 700;
                max = 1000;
              }
              //sm-em
              if (key == "energy") {
                min = 400000000;
                max = 500000000;
              }
              if (key == "power") {
                min = 2000;
                max = 3000;
              }
              if (key == "current") {
                min = 250;
                max = 300;
              }
              //smart room - air conditioning
              if (key == "room_temp") {
                min = 25;
                max = 30;
              }
              if (key == "temp_adjust") {
                min = 20;
                max = 25;
              }
              if (key == "start_stop_status") {
                min = 40;
                max = 60;
              }
              if (key == "alarm") {
                min = 40;
                max = 60;
              }
              if (key == "malfunction_code") {
                min = 40;
                max = 60;
              }
              if (key == "air_con_mode_status") {
                min = 40;
                max = 60;
              }
              if (key == "air_flow_rate_status") {
                min = 40;
                max = 60;
              }
              if (key == "filter_sign") {
                min = 40;
                max = 60;
              }
              if (key == "gas_total_power") {
                min = 40;
                max = 60;
              }
              if (key == "elec_total_power") {
                min = 40;
                max = 60;
              }
              if (key == "air_direction_status") {
                min = 40;
                max = 60;
              }
              if (key == "forced_thermo_off_status") {
                min = 40;
                max = 60;
              }
              if (key == "energy_efficiency_status") {
                min = 40;
                max = 60;
              }
              if (key == "compressor_status") {
                min = 40;
                max = 60;
              }
              if (key == "indoor_fan_status") {
                min = 40;
                max = 60;
              }
              if (key == "heater_status") {
                min = 40;
                max = 60;
              }
              //smart room - occupancy
              if (key == "occupancy1") {
                min = 40;
                max = 60;
              }
              if (key == "occupancy2") {
                min = 40;
                max = 60;
              }
              if (key == "occupancy3") {
                min = 40;
                max = 60;
              }
              if (key == "occupancy4") {
                min = 40;
                max = 60;
              }
              //crowd monitoring
              if (key == "current_people_count") {
                min = 40;
                max = 60;
              }
              if (key == "no_of_safe_distance_violations") {
                min = 40;
                max = 60;
              }
              if (key == "no_of_mask_violations") {
                min = 40;
                max = 60;
              }
              if (key == "timestamp_start") {
                min = 40;
                max = 60;
              }
              if (key == "timestamp_end") {
                min = 40;
                max = 60;
              }
              changeVerticalColor(key, min, max);

              // if (key == "solar_radiation") {
              //   setState(() {
              //     if (int.parse((readings["solar_radiation"].split(" "))[0]) >
              //         0) {
              //       cardColor = Colors.yellow;
              //     }
              //   });
              // }
              // if (key == "relative_humidity") {
              //   setState(() {
              //     if (int.parse(readings["relative_humidity"].split(" ")[0]) >
              //         30) {
              //       cardColor = Colors.lightBlueAccent;
              //       // cardGradient =
              //       //     LinearGradient(colors: [Colors.lightBlueAccent]);
              //     }
              //   });

              // print(int.parse(
              //     readings["relative_humidity"].split(" ")[0]));
              //}
              // if (key == "pm25") {

              //   setState(() {
              //     if (int.parse(readings["pm25"].split(" ")[0]) > 10) {
              //       cardColor = Colors.lightBlueAccent;
              //     }
              //   });
              // }
            },

            child: Padding(
                padding: EdgeInsets.all(8.0),
                //padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),

                // child: Container(
                //     decoration: BoxDecoration(
                //       border: touched
                //           ? (Border.all(
                //               width: 2,
                //             ))
                //           : null,
                //     ),
                // child: AnimatedContainer(
                //     height: 60.0,
                //     duration: Duration(milliseconds: 200),
                //     decoration: BoxDecoration(
                //         color: touchedReading ==
                //                 readings.keys.toList().indexOf(key)
                //             ? Colors.yellow[300]
                //             : null,
                //         borderRadius: BorderRadius.vertical(
                //             top: Radius.circular(700), bottom: Radius.zero),
                //         boxShadow: [
                //           BoxShadow(
                //             color: touchedReading ==
                //                     readings.keys.toList().indexOf(key)
                //                 ? Colors.yellow.withOpacity(0.8)
                //                 : Colors.transparent,
                //             blurRadius: 12.0,
                //             spreadRadius: 5.0,
                //             //offset: Offset(1, 20),
                //           )
                //         ]),
                //     padding: EdgeInsets.symmetric(vertical: 10.0),
                child: column
                //)
                //),
                ),
          ));
        }
      });
    }
    return _isLoading
        ? Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                //gradient: cardGradient,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Center(child: CircularProgressIndicator()),
            ))
        : GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(VerticalDetailScreen.routeName,
                  arguments: [vertical.title, readings['name']]);
              // Navigator.of(context).pushNamed(
              //   ModalRoute.of(context).settings.name ==
              //           NodeManagementPage.routeName
              //       ? AdminVerticalDetailScreen.routeName
              //       : VerticalDetailScreen.routeName,
              //   arguments: [vertical.title, readings['name']],
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  //gradient: cardGradient,
                  gradient: cardColor == null ? cardGradient : null,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, bottom: 8, top: 16),
                            child: _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Text(
                                    readings['name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: Colors.black),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 3),
                                    child: _isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        //no of nodes
                                        : Text(
                                            //n.toString(),
                                            //vertical.nodeCount.toString(),
                                            //vertical.vertices.length.toString(),
                                            // (vertical.title == 'wn')
                                            //     ? '60'
                                            //     : (vertical.title == 'aq')
                                            //         ? '10'
                                            //         : (vertical.title == 'em')
                                            //             ? '50'
                                            //             : (vertical.title ==
                                            //                     'sr_ac')
                                            //                 ? '91'
                                            //                 : (vertical.title ==
                                            //                         'sr_oc')
                                            //                     ? '6'
                                            //                     : (vertical.title ==
                                            //                             'cm')
                                            //                         ? '6'
                                            //                         : vertical
                                            //                             .vertices
                                            //                             .length
                                            //                             .toString(),
                                            (vertical.vertices
                                                    .where((vertex) =>
                                                        !vertex.excluded)
                                                    .length)
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 32,
                                              color: Colors.lightBlue[600],
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 8),
                                    child: Text(
                                      'nodes',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: Colors.lightBlue[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                      width: getProportionateScreenHeight(100),
                                      height: getProportionateScreenHeight(100),
                                      margin: EdgeInsets.only(
                                        right: getProportionateScreenHeight(40),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/dashboard_icon/" +
                                                    vertical.title +
                                                    ".png"),
                                            fit: BoxFit.cover),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       color: Colors.white
                                        //           .withOpacity(0.2),
                                        //       //offset: Offset(1.1, 1.1),
                                        //       blurRadius: 10.0,
                                        //       spreadRadius: 12.0)]
                                      ),
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: r,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
