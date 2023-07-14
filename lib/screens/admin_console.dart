// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:scrc/widgets/main_drawer.dart';
// import 'admin_login.dart';
// import 'node_management.dart';
// import 'package:scrc/providers/auth_provider.dart';

// class AdminConsole extends StatelessWidget {
//   static const routeName = "/adminLogin/adminConsole";

//   // final VoidCallback logoutCallback;

//   // AdminConsole({@required this.logoutCallback});

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Admin Console',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         //iconTheme: IconThemeData(color: Colors.black),
//       ),
//       drawer: MyDrawer(),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           Card(
//               child: InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NodeManagementPage()),
//               );
//             },
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 "Node Management",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.blue[700],
//                 ),
//               ),
//             ),
//           )),
//           //SizedBox(height: 550),
//           // ElevatedButton(
//           //   child: Text('Logout'),
//           //   onPressed: logoutCallback,
//           // ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           authProvider.logout();
//           Navigator.pushReplacementNamed(context, AdminLoginPage.routeName);
//         },
//         child: Icon(Icons.logout),
//       ),
//     );
//   }
// }
