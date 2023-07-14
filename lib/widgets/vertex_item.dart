import 'package:flutter/material.dart';
import 'package:scrc/providers/node_state_provider.dart';
import 'package:scrc/providers/vertex.dart';
import 'package:scrc/screens/admin_login.dart';
import 'package:scrc/screens/graph_screen.dart';
import 'package:scrc/widgets/data_container.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/verticals.dart';
import 'package:scrc/screens/admin_login.dart';

import '../providers/auth_provider.dart';
import '../size_config.dart';

class VertexItem extends StatefulWidget {
  final int index;
  final Vertex vertex;
  //final String userRole;
  VertexItem({this.vertex, this.index});

  @override
  _VertexItemState createState() => _VertexItemState();
}

class _VertexItemState extends State<VertexItem> {
  var _expanded = false;

  //bool _excluded = false;
  //
  //bool _removed = false;

  //
  void excludeNode(String nodeId) {
    final verticalsProvider = Provider.of<Verticals>(context, listen: false);
    verticalsProvider.excludeNode(nodeId);
    // setState(() {
    //   _removed = true;
    // });
    //_excluded = true;
  }

  void includeNode(String nodeId) {
    final verticalsProvider = Provider.of<Verticals>(context, listen: false);
    verticalsProvider.includeNode(nodeId);
    // setState(() {
    //   _removed = true;
    // });
    //_excluded = true;
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    // final String userRole = authProvider.role;

    // final nodeStateProvider = Provider.of<NodeStateProvider>(context);
    // final bool isEnabled = nodeStateProvider.getNodeState(widget.vertex.nodeId);
    return Card(
        margin: EdgeInsets.all(10),
        color: widget.vertex.excluded ? Colors.grey[400] : Colors.white,
        // isEnabled ? Colors.grey[400] : Colors.white,

        //_excluded ? Colors.grey : Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Padding(
                    padding: EdgeInsets.all(4),
                    child: FittedBox(child: Text(widget.index.toString()))),
              ),
              title: Text(widget.vertex.nodeId),
              subtitle: Text(widget.vertex.name),
              trailing: Container(
                width: getProportionateScreenWidth(100),
                child: Row(
                  children: [
                    //Flexible(
                    //child:
                    Expanded(
                      child: IconButton(
                          //
                          icon: Icon(Icons.graphic_eq_outlined),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(GraphScreen.routeName, arguments: [
                              widget.vertex.nodeId,
                              widget.vertex.type
                            ]);
                          }),
                    ),
                    // ),
                    //Flexible(
                    //child:
                    Expanded(
                      child: IconButton(
                          icon: Icon(_expanded
                              ? Icons.expand_less
                              : Icons.expand_more),
                          onPressed: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                          }),
                    ),
                   

                    //),

                    //
                    // if (widget.userRole == 'admin')
                    //   Flexible(
                    //     child: IconButton(
                    //       icon: !widget.vertex.excluded
                    //           ? Icon(
                    //               Icons.check_circle_rounded,
                    //               color: Colors.green,
                    //             )
                    //           : Icon(Icons.close),
                    //       onPressed: () {
                    //         final vertexId = widget.vertex.nodeId;
                    //         if (widget.vertex.excluded == false) {
                    //           excludeNode(vertexId);
                    //           showDialog(
                    //             context: context,
                    //             builder: (BuildContext context) {
                    //               Future.delayed(Duration(seconds: 1), () {
                    //                 Navigator.of(context).pop();
                    //               });
                    //               return AlertDialog(
                    //                 title: Text('Disabled'),
                    //                 content: Text('This node is disabled.'),
                    //                 actions: [
                    //                   // TextButton(
                    //                   //   child: Text('OK'),
                    //                   //   onPressed: () {
                    //                   //     Navigator.of(context).pop();
                    //                   //   },
                    //                   // ),
                    //                 ],
                    //               );
                    //             },
                    //           );
                    //         } else if (widget.vertex.excluded == true) {
                    //           includeNode(vertexId);
                    //           showDialog(
                    //             context: context,
                    //             builder: (BuildContext context) {
                    //               Future.delayed(Duration(seconds: 1), () {
                    //                 Navigator.of(context).pop();
                    //               });
                    //               return AlertDialog(
                    //                   title: Text('Enabled'),
                    //                   content: Text('This node is enabled.'));
                    //             },
                    //           );
                    //         }

                    //         //       //_excludeNode(vertexId);
                    //       },
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
            if (!widget.vertex.excluded && _expanded)
              DataContainer(vertex: widget.vertex)
          ],
        ));
  }
}
