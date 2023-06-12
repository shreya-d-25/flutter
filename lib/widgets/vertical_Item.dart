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

  // int solarRadiation;
  // int relHumidity;
  final gradientColors = [
    Colors.green[400],
    Colors.yellow[400],
    Colors.red[400]
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

            // try {
            //   if (readings["solar_radiaton"] != null) {
            //     solarRadiation =
            //         int.parse((readings["solar_radiation"].split(" "))[0]);
            //   }
            // } catch (e) {
            //   solarRadiation = 0;
            // }

            // solarRadiation =
            //     int.parse((readings["solar_radiation"].split(" "))[0]);
            // relHumidity = (readings["relative_humidity"].split(" "))[0];

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

            // print((readings["temperature"]).replaceAll(' ', ''));
            // List<String> txt = (readings["temperature"]).split(",");
            // print(txt[0]);

            //print(txt[0]);
            //print((readings["relative_humidity"]).split(" "));

            // print(substrings[0]);
            // print(val);
            // if (val > 20) {
            //   cardColor = Colors.red;
            // }
            // final temperatureValue =
            //     int.tryParse(readings["temperature"].split(" ")[0]) ?? 0;

            // cardColor = temperatureValue > 20 ? Colors.red : Colors.green;
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

  void changeVerticalColor(String key, int min, int max) {}

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
              // if (temperatureValue <= 20 && temperatureValue > 0) {
              //   cardColor = Colors.green;
              // } else if (40 > temperatureValue && temperatureValue > 20) {
              //   cardColor = Colors.orange;
              // } else if (temperatureValue >= 40) {
              //   cardColor = Colors.red;
              // }
              // when click on solar radiation
              FittedBox(
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.2,
                    color: Colors.black,
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
                //     if (key == "solar_radiation") {
                //       //print("hello");
                //       // print(int.parse(
                //       //     (readings["solar_radiation"].split(" "))[0]));
                //       setState(() {
                //         if (int.parse(
                //                 (readings["solar_radiation"].split(" "))[0]) >
                //             0) {
                //           cardColor = Colors.yellow;
                //           final from = Colors.orange[400];
                //           final to = Colors.orange[200];
                //           final gradientColors = [from, to];

                //           //   cardColor = LinearGradient(
                //           //     begin: Alignment.topLeft,
                //           //     end: Alignment.bottomRight,
                //           //     colors: gradientColors,
                //           //   ).createShader(Rect.fromLTWH(0, 0, 1, 1));

                //         }
                //       });
                //     }
                //     if (key == "relative_humidity") {
                //       //print("hola");
                //       setState(() {
                //         if (int.parse(
                //                 readings["relative_humidity"].split(" ")[0]) >
                //             30) {
                //           cardColor = Colors.lightBlueAccent;
                //         }
                //       });

                //       // print(int.parse(
                //       //     readings["relative_humidity"].split(" ")[0]));
                //     }
                //     if (key == "pm25") {
                //       setState(() {
                //         if (int.parse(readings["pm25"].split(" ")[0]) > 10) {
                //           cardColor = Colors.lightBlueAccent;
                //         }
                //       });
                //     }
                //   },
                child: FittedBox(
                  ///solar radiation
                  child: Text(
                    key.toString().toUpperCase().replaceAll("_", " "),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.black45.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          );
          var column2 = column3;
          var column = column2;
          ///////the whole box including text and reading

          r.add(GestureDetector(
            //onTap: () => print("hi"),
            onTap: () {
              print("HI");
              if (key == "temperature") {
                setState(() {
                  // cardColor =
                  //     temperatureValue < 20 ? Colors.green : Colors.red;

                  // if (temperatureValue <= 20 && temperatureValue > 0) {
                  //   cardColor = Colors.green;
                  //cardGradient = LinearGradient(colors: [gradientColors[0]]);
                  // } else if (40 > temperatureValue && temperatureValue > 20) {
                  //cardColor = null;
                  final t = (temperatureValue - 20) / 20;
                  if (t < 0.25) {
                    //temp <25
                    cardColor = Colors.green;
                  } else if (t < 0.5) {
                    //25<temp<30
                    cardColor = null;
                    cardGradient = LinearGradient(colors: gradientColors
                        //  [
                        //   gradientColors[0].withOpacity(t),
                        //   gradientColors[1].withOpacity(t),
                        //   gradientColors[2].withOpacity(t),]
                        );
                  } //temp>30
                  else {
                    cardColor = Colors.red;
                  }
                  // cardColor = null;

                  // cardGradient = LinearGradient(colors: [
                  //   gradientColors[1].withOpacity(1 - t),
                  //   gradientColors[2].withOpacity(t)
                  // ]);

                  //cardColor = Color.lerp(Colors.green, Colors.red, t);
                  // cardColor = LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   colors: gradientColors,
                  // );
                  //#Color Tween

                  // print(t);
                  // final colorTween = new ColorTween(
                  //   begin: gradientColors[0],
                  //   end: gradientColors[2],
                  // );
                  // cardColor = colorTween.transform(t);
                  // } else if (temperatureValue >= 40) {
                  //   cardColor = Colors.red;
                  // }
                });
              }

              if (key == "solar_radiation") {
                //print("hello");
                // print(int.parse(
                //     (readings["solar_radiation"].split(" "))[0]));
                setState(() {
                  if (int.parse((readings["solar_radiation"].split(" "))[0]) >
                      0) {
                    cardColor = Colors.yellow;
                    //cardGradient = LinearGradient(colors: [Colors.yellow]);

                    //   cardColor = LinearGradient(
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //     colors: gradientColors,
                    //   ).createShader(Rect.fromLTWH(0, 0, 1, 1));

                  }
                });
              }
              if (key == "relative_humidity") {
                //print("hola");
                setState(() {
                  if (int.parse(readings["relative_humidity"].split(" ")[0]) >
                      30) {
                    cardColor = Colors.lightBlueAccent;
                    // cardGradient =
                    //     LinearGradient(colors: [Colors.lightBlueAccent]);
                  }
                });

                // print(int.parse(
                //     readings["relative_humidity"].split(" ")[0]));
              }
              if (key == "pm25") {
                setState(() {
                  if (int.parse(readings["pm25"].split(" ")[0]) > 10) {
                    cardColor = Colors.lightBlueAccent;
                    // cardGradient =
                    //     LinearGradient(colors: [Colors.lightBlueAccent]);
                  }
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: column,
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
                                              fontWeight: FontWeight.w600,
                                              fontSize: 32,
                                              color: Colors.blue,
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
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: Colors.blue,
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/dashboard_icon/" +
                                                      vertical.title +
                                                      ".png"),
                                              fit: BoxFit.cover)),
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
