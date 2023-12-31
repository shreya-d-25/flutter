import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/verticals.dart';
import '../widgets/main_drawer.dart';
import '../widgets/verticals_grid.dart';

class VerticalsOverviewScreen extends StatefulWidget {
  static const routeName = "/verticals";
  @override
  _VerticalsOverviewScreenState createState() =>
      _VerticalsOverviewScreenState();
}

class _VerticalsOverviewScreenState extends State<VerticalsOverviewScreen> {
  var _isInit = true;
  var _isloading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Verticals>(context).fetchAndSetVerticals().then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
            // appBar: AppBar(
            //   title: Text("Verticals"),
            // ),
            // drawer: MyDrawer(),
            body: Center(
                child: Image.asset("assets/icon/smartCity_livingLab.png")),
            // body: _isloading ? Center(child: CircularProgressIndicator()) : VerticalsGrid(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black), //added this
              title: Text("Verticals", style: TextStyle(color: Colors.black)),
            ),
            drawer: MyDrawer(),
            body: Center(
              child: VerticalsGrid(),
              // body: _isloading ? Center(child: CircularProgressIndicator()) : VerticalsGrid(),
            ));
  }
}
