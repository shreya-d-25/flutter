import 'dart:developer';
import 'dart:ui';
//import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/vertical.dart';
import 'package:scrc/screens/vertical_detail_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  int min;
  int max;
  int touchedReading;

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
  void changeVerticalColor(String key, int a, int b) {
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
              if (key == "temperature") {
                min = 25;
                max = 30;
              }
              if (key == "solar_radiation") {
                min = 2;
                max = 4;
              }
              if (key == "relative_humidity") {
                min = 20;
                max = 40;
              }
              if (key == "pm25") {
                min = 15;
                max = 25;
              }
              if (key == "pm10") {
                min = 15;
                max = 25;
              }
              if (key == "rssi") {
                min = 15;
                max = 25;
              }
              if (key == "latency") {
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
                                        : Text(
                                            vertical.vertices.length.toString(),
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
