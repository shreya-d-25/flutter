import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:scrc/widgets/main_drawer.dart';
//import 'package:flutter_kiosk_mode/flutter_kiosk_mode.dart';

class Analytics extends StatelessWidget {
  static const routeName = "/analytics";
  final List<String> iframeUrls = [
    'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=38&kiosk',
    'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=56&kiosk',
    'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=40&kiosk',
    'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=42&kiosk',
    'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=31&kiosk',
    //'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=49&kiosk',
    'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=30&kiosk',
    'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=53&kiosk',
    // 'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=47&kiosk',
    //'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=46&kiosk',
    'https://smartcitylivinglab.iiit.ac.in/grafana/d/kyLuJXQ7z/summary_view?orgId=1&from=now-3w&to=now&viewPanel=55&kiosk',
  ];
  final double webViewHeight = 275;

  //final double webViewWidth = 400;
  // String iframeUrl;

  // double webViewHeight;
  // double webViewWidth;

  // const Analytics({
  //   @required this.iframeUrl,
  //   @required this.webViewHeight,
  //   @required this.webViewWidth,
  // });

  @override
  Widget build(BuildContext context) {
    double webViewWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
      ),
      drawer: MyDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: iframeUrls.map((url) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: webViewHeight,
                  width: webViewWidth,
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(url),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      // body: ListView.builder(//kiosk
      //   itemCount: iframeUrls.length,
      //   itemBuilder: (ctx, index) {
      //     return MyWebView(
      //       iframeUrl: iframeUrls[index],
      //       webViewHeight: 300,
      //       webViewWidth: 300,
      //     );
      //   },
      // ),
      //  SingleChildScrollView(
      //   child: Container(
      //     height: webViewHeight,
      //     width: webViewWidth,
      //     child: InAppWebView(

      //       initialUrlRequest: URLRequest(
      //         url: Uri.parse(iframeUrl),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}


// // // import 'package:flutter/material.dart';
// // // import 'package:webview_flutter/webview_flutter.dart';
// // // import 'package:scrc/widgets/main_drawer.dart';

// // // class Analytics extends StatelessWidget {
// // //   String iframeUrl;
// // //   static const routeName = "/analytics";
// // //   double webViewHeight;
// // //   double webViewWidth;

// // //   Analytics({
// // //     @required this.iframeUrl,
// // //     @required this.webViewHeight,
// // //     @required this.webViewWidth,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("Analytics"),
// // //       ),
// // //       drawer: MyDrawer(),
// // //       body: Column(
// // //         children: [
// // //           Analytics(
// // //             iframeUrl: 'https://www.bing.com/',
// // //             webViewHeight: 300.0,
// // //             webViewWidth: 300.0,
// // //           ),
// // //           // SizedBox(height: 20),
// // //           // Analytics(
// // //           //   iframeUrl: 'https://www.bing.com/',
// // //           //   webViewHeight: 200,
// // //           //   webViewWidth: 200,
// // //           // ),
// // //           // SizedBox(height: 20),
// // //           // Analytics(
// // //           //   iframeUrl: 'https://www.bing.com/',
// // //           //   webViewHeight: 400,
// // //           //   webViewWidth: 400,
// // //           // ),
// // //           // Add more instances of Analytics as needed
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }


// // // class Analytics extends StatefulWidget {

// // //   static const routeName = "/analytics";

// // //   @override
// // //   State<Analytics> createState() => _AnalyticsState();
// // // }

// // // class _AnalyticsState extends State<Analytics> {
// // //   final IFrameElement _iFrameElement = IFrameElement();

// // //   @override
// // //   void initState() {
// // //     _iFrameElement.style.height = '50%';
// // //     _iFrameElement.style.width = '50%';
// // //     _iFrameElement.src = 'https://www.bing.com/';
// // //     _iFrameElement.style.border = 'none';

// // //     //ignore: undefined_prefixed_name
// // //     ui.platformViewRegistry
// // //         .registerViewFactory('iframeElement', (int ViewId) => _iFrameElement);

// // //     super.initState();
// // //   }

// // //   Widget _iframeWidget = HtmlElementView(
// // //     viewType: 'iframeElement',
// // //     key: UniqueKey(),
// // //   );

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //           //systemOverlayStyle: SystemUiOverlayStyle(),
// // //           title: Text(
// // //         "Analytics",
// // //       )),
// // //       drawer: MyDrawer(),
// // //       body: Column(children: [
// // //         SizedBox(
// // //           height: 500,
// // //           width: 500,
// // //           child: _iframeWidget,
// // //         )
// // //       ]),
// // //     );
// // //   }
// // // }
