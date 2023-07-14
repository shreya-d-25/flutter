import './vertex.dart';

import 'package:flutter/material.dart';

class Vertical with ChangeNotifier {
  final String title;
  final List<Vertex> vertices;
  int nodeCount;
  //

  Vertical({
    @required this.title,
    @required this.vertices,
  }) : nodeCount = vertices.length;
}

