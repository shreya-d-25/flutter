// import 'package:flutter/material.dart';
// import 'package:scrc/widgets/main_drawer.dart';
// import 'package:scrc/screens/node_management.dart';
// import 'package:scrc/screens/admin_console.dart';
// import 'package:provider/provider.dart';
// import 'package:scrc/providers/auth_provider.dart';

// class AdminLoginPage extends StatefulWidget {
//   static const routeName = "/adminLogin";

//   @override
//   State<AdminLoginPage> createState() => _AdminLoginPageState();
// }

// class _AdminLoginPageState extends State<AdminLoginPage> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   // bool isLoggedIn = false;

//   @override
//   Widget build(BuildContext context) {
//     // return isLoggedIn ? AdminConsole(logoutCallback: logout) : buildLoginForm();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Login'),
//       ),
//       drawer: MyDrawer(),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Image.asset('assets/background/login.png'),
//             TextFormField(
//               controller: usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             TextFormField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             ElevatedButton(
//               child: Text('Login'),
//               onPressed: () {
//                 // Validate admin credentials here
//                 if (usernameController.text == 'admin' &&
//                     passwordController.text == 'admin') {
//                   // setState(() {
//                   //   isLoggedIn = true;
//                   // });
//                   authProvider.login();
//                   authProvider.setRole('admin');
//                   Navigator.pushReplacementNamed(
//                       context, AdminConsole.routeName);
//                   // isLoggedIn
//                   //     ? AdminConsole.routeName
//                   //     : AdminLoginPage.routeName;
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//   // void logout() {
//   //   setState(() {
//   //     isLoggedIn = false;
//   //   });
//   // }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:scrc/widgets/main_drawer.dart';
// // import 'node_management.dart';
// // import 'admin_console.dart';

// // // class AdminLoginPage extends StatelessWidget {
// // //   static const routeName = "/adminlogin";
// // //   final TextEditingController usernameController = TextEditingController();
// // //   final TextEditingController passwordController = TextEditingController();

// // class AdminLoginPage extends StatefulWidget {
// //   static const routeName = "/adminLogin";
// //   static bool adminLoggedIn = false;

// //   @override
// //   State<AdminLoginPage> createState() => _AdminLoginPageState();
// // }

// // class _AdminLoginPageState extends State<AdminLoginPage> {
// //   final TextEditingController usernameController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Admin Login'),
// //       ),
// //       drawer: MyDrawer(),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Image.asset('assets/background/login.png'),
// //             TextFormField(
// //               controller: usernameController,
// //               decoration: InputDecoration(labelText: 'Username'),
// //             ),
// //             SizedBox(
// //               height: 15,
// //             ),
// //             TextFormField(
// //               controller: passwordController,
// //               obscureText: true,
// //               decoration: InputDecoration(labelText: 'Password'),
// //             ),
// //             ElevatedButton(
// //               child: Text('Login'),
// //               onPressed: () {
// //                 // Validate admin credentials here
// //                 if (usernameController.text == 'admin' &&
// //                     passwordController.text == 'admin') {
// //                   Navigator.pushReplacementNamed(
// //                       context, AdminConsole.routeName);
// //                   // Navigator.push(
// //                   //   context,
// //                   //   MaterialPageRoute(builder: (context) => AdminConsole()),
// //                   // );
// //                   // AdminLoginPage.adminLoggedIn = true;
// //                 }
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
