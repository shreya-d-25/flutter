// import 'package:flutter/material.dart';
// import 'package:scrc/providers/node_state_provider.dart';
// import 'package:scrc/providers/vertex.dart';
// import 'package:scrc/screens/admin_login.dart';
// import 'package:scrc/screens/graph_screen.dart';
// import 'package:scrc/widgets/data_container.dart';
// import 'package:provider/provider.dart';
// import 'package:scrc/providers/verticals.dart';

// import '../providers/auth_provider.dart';
// import '../providers/node_state_provider.dart';
// import '../size_config.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AdminVertexItem extends StatefulWidget {
//   final int index;
//   final Vertex vertex;
//   AdminVertexItem({this.vertex, this.index});

//   @override
//   _AdminVertexItemState createState() => _AdminVertexItemState();
// }

// class _AdminVertexItemState extends State<AdminVertexItem> {
//   var _expanded = false;
//   //bool _excluded = false;
//   //
//   //bool _removed = false;

//   //
//   // void excludeNode(String nodeId) {
//   //   final verticalsProvider = Provider.of<Verticals>(context, listen: false);
//   //   verticalsProvider.excludeNode(nodeId);
//   //   // setState(() {
//   //   //   _removed = true;
//   //   // });
//   //   //_excluded = true;
//   // }

//   // void includeNode(String nodeId) {
//   //   final verticalsProvider = Provider.of<Verticals>(context, listen: false);
//   //   verticalsProvider.includeNode(nodeId);
//   //   // setState(() {
//   //   //   _removed = true;
//   //   // });
//   //   //_excluded = true;
//   // }
//   void excludeNode(String nodeId) async {
//     final verticalsProvider = Provider.of<Verticals>(context, listen: false);
//     verticalsProvider.excludeNode(nodeId);
//     //..
//     final nodeStateProvider =
//         Provider.of<NodeStateProvider>(context, listen: false);
//     nodeStateProvider.setNodeState(nodeId, false);

//     final excludedNodeIds =
//         verticalsProvider.excludedNodes.map((vertex) => vertex.nodeId).toList();

//     //await storeExcludedNodes(excludedNodeIds);
//   }

//   void includeNode(String nodeId) async {
//     final verticalsProvider = Provider.of<Verticals>(context, listen: false);
//     verticalsProvider.includeNode(nodeId);
//     // final excludedNodeIds = verticalsProvider.getExcludedNodeIds();
//     //..
//     final nodeStateProvider =
//         Provider.of<NodeStateProvider>(context, listen: false);
//     nodeStateProvider.setNodeState(nodeId, true);
//     final excludedNodeIds =
//         verticalsProvider.excludedNodes.map((vertex) => vertex.nodeId).toList();

//     //await storeExcludedNodes(excludedNodeIds);
//   }

//   // Future<void> storeExcludedNodes(List<String> excludedNodeIds) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   await prefs.setStringList('excludedNodes', excludedNodeIds);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // final authProvider = Provider.of<AuthProvider>(context);
//     // final String userRole = authProvider.role;
//     return Card(
//         margin: EdgeInsets.all(10),
//         color: widget.vertex.excluded ? Colors.grey[400] : Colors.white,

//         //_excluded ? Colors.grey : Colors.white,
//         child: Column(
//           children: [
//             ListTile(
//               leading: CircleAvatar(
//                 child: Padding(
//                     padding: EdgeInsets.all(4),
//                     child: FittedBox(child: Text(widget.index.toString()))),
//               ),
//               title: Text(widget.vertex.nodeId),
//               subtitle: Text(widget.vertex.name),
//               trailing: Container(
//                 width: getProportionateScreenWidth(100),
//                 child: Row(
//                   children: [
//                     Flexible(
//                       child: IconButton(
//                           //
//                           icon: Icon(Icons.graphic_eq_outlined),
//                           onPressed: () {
//                             Navigator.of(context)
//                                 .pushNamed(GraphScreen.routeName, arguments: [
//                               widget.vertex.nodeId,
//                               widget.vertex.type
//                             ]);
//                           }),
//                     ),
//                     Flexible(
//                       child: IconButton(
//                           icon: Icon(_expanded
//                               ? Icons.expand_less
//                               : Icons.expand_more),
//                           onPressed: () {
//                             setState(() {
//                               _expanded = !_expanded;
//                             });
//                           }),
//                     ),
//                     Flexible(
//                       child: IconButton(
//                         icon: !widget.vertex.excluded
//                             ? Icon(
//                                 Icons.check_circle_rounded,
//                                 color: Colors.green,
//                               )
//                             : Icon(Icons.close),
//                         onPressed: () {
//                           final vertexId = widget.vertex.nodeId;
//                           if (widget.vertex.excluded == false) {
//                             excludeNode(vertexId);
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 Future.delayed(Duration(seconds: 1), () {
//                                   Navigator.of(context).pop();
//                                 });
//                                 return AlertDialog(
//                                   title: Text('Disabled'),
//                                   content: Text('This node is disabled.'),
//                                   actions: [
//                                     // TextButton(
//                                     //   child: Text('OK'),
//                                     //   onPressed: () {
//                                     //     Navigator.of(context).pop();
//                                     //   },
//                                     // ),
//                                   ],
//                                 );
//                               },
//                             );
//                           } else if (widget.vertex.excluded == true) {
//                             includeNode(vertexId);
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 Future.delayed(Duration(seconds: 1), () {
//                                   Navigator.of(context).pop();
//                                 });
//                                 return AlertDialog(
//                                     title: Text('Enabled'),
//                                     content: Text('This node is enabled.'));
//                               },
//                             );
//                           }

//                           //       //_excludeNode(vertexId);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (!widget.vertex.excluded && _expanded)
//               DataContainer(vertex: widget.vertex)
//           ],
//         ));
//   }
// }
