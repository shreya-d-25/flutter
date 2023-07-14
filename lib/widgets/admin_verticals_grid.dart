// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // import 'vertical_item.dart';
// import 'admin_vertical_Item.dart';

// import '../providers/verticals.dart';

// class AdminVerticalsGrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final verticalsData = Provider.of<Verticals>(context);
//     final verticals = verticalsData.items;
//     return Container(
//       child: ListView.builder(
//           itemCount: verticals.length,
//           itemBuilder: (ctx, i) {
//             return ChangeNotifierProvider.value(
//               value: verticals[i],
//               child: AdminVerticalItem(),
//             );
//           }),
//     );
//   }
// }
