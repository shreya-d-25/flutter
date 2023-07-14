import 'package:flutter/material.dart';

class NodeStateProvider with ChangeNotifier {
  Map<String, bool> _nodeStates = {};

  bool getNodeState(String nodeId) {
    return _nodeStates[nodeId] ?? false;
  }

  void setNodeState(String nodeId, bool enabled) {
    _nodeStates[nodeId] = enabled;
    notifyListeners();
  }
}
