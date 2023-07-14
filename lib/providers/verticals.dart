import 'package:provider/provider.dart';
import 'package:scrc/providers/vertex.dart';
import 'node_state_provider.dart';
import 'vertical.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Verticals with ChangeNotifier {
  List<Vertical> _items = [];
  Map<String, dynamic> graph;
  //
  List<Vertex> _excludedNodes = [];

  List<Vertical> get items {
    //return [..._items];
    // Exclude excluded nodes from the count
    final List<Vertical> filteredItems = _items
        .map((vertical) => Vertical(
            title: vertical.title,
            vertices:
                vertical.vertices.where((vertex) => !vertex.excluded).toList()))
        .toList();

    return filteredItems;
  }

  List<Vertex> get excludedNodes {
    return [..._excludedNodes];
  }

  Vertical findByTitle(String title) {
    return [..._items].firstWhere((element) => element.title == title);
  }

  //
  void excludeNode(String nodeId) {
    final excludedNode = _items
        .expand((vertical) => vertical.vertices)
        .firstWhere((vertex) => vertex.nodeId == nodeId, orElse: () => null);
    if (excludedNode != null) {
      excludedNode.excluded = true;
      _excludedNodes.add(excludedNode);
      // _storeExcludedNodes();

      // Update the count of nodes
      // _items.forEach((vertical) {
      //   vertical.nodeCount =
      //       vertical.vertices.where((vertex) => !vertex.excluded).length;
      //   print((vertical.nodeCount).runtimeType);
      // });

      notifyListeners();
    }

    // _items.forEach((vertical) {
    //   // vertical.vertices.forEach((vertex) {
    //   //   if (vertex.nodeId == nodeId) {

    //   //   }
    //   // });
    //   vertical.vertices.removeWhere((vertex) => vertex.nodeId == nodeId);
    //   // vertical.vertices.removeWhere((vertex) {
    //   //   if (vertex.nodeId == nodeId) {
    //   //     vertex.excluded = true;
    //   //     return true;
    //   //   }
    //   //   return false;
    //   // });
    // });
    // notifyListeners();
  }

  void includeNode(String nodeId) {
    final includedNode = _excludedNodes
        .firstWhere((vertex) => vertex.nodeId == nodeId, orElse: () => null);
    if (includedNode != null) {
      includedNode.excluded = false;
      _excludedNodes.remove(includedNode);
      //_storeExcludedNodes();

      notifyListeners();
    }
  }

  //...
  Future<void> _loadExcludedNodes() async {
    final prefs = await SharedPreferences.getInstance();
    final excludedNodeIds = prefs.getStringList('excludedNodes') ?? [];
    _excludedNodes = _items
        .expand((vertical) => vertical.vertices)
        .where((vertex) => excludedNodeIds.contains(vertex.nodeId))
        .toList();
  }

  // Future<void> _storeExcludedNodes() async {
  //   final excludedNodeIds =
  //       _excludedNodes.map((vertex) => vertex.nodeId).toList();
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList('excludedNodes', excludedNodeIds);
  // }

  //...
  Future<void> fetchAndSetVerticals(BuildContext context) async {
    var url = Uri.parse(
        "https://smartcitylivinglab.iiit.ac.in/verticals/all/latest/#");
    try {
      //..
      await _loadExcludedNodes();
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Vertical> loadedVerticals = [];
      if (extractedData != null) {
        extractedData.forEach((prodName, prodData) {
          final filteredProdData = (prodData as List<dynamic>).where((e) {
            final nodeId = e['node_id'];
            return !nodeId.startsWith("WN-LP");
          }).toList();
          final vertices = filteredProdData.map((e) {
            final vertex = Vertex(
              name: e['name'],
              nodeId: e['node_id'],
              type: prodName,
              latitude: e['latitude'],
              longitude: e['longitude'],
              data: e as Map<String, dynamic>,
            );
            // Check if the vertex is disabled and set its state accordingly
            // final nodeStateProvider =
            //     Provider.of<NodeStateProvider>(context, listen: false);
            // final isEnabled = nodeStateProvider.getNodeState(vertex.nodeId);
            // vertex.excluded = !isEnabled;

            return vertex;
          }).toList();

          loadedVerticals.add(Vertical(
            title: prodName,
            vertices: vertices,
          ));
        });
      }
      _items = loadedVerticals.toList();
      _excludedNodes = _items
          .expand((vertical) => vertical.vertices)
          .where((vertex) => vertex.excluded)
          .toList();

      // Set the initial state of nodes in NodeStateProvider
      // final nodeStateProvider =
      //     Provider.of<NodeStateProvider>(context, listen: false);
      // for (var vertex in _items.expand((vertical) => vertical.vertices)) {
      //   nodeStateProvider.setNodeState(vertex.nodeId, !vertex.excluded);
      // }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  // if (prodName == "wn") {
  //   // Exclude specific nodes from "wn"
  //   //final excludedNodes = ["WN-LP01-03", "WN-LP03-02"];

  //   final filteredProdData = (prodData as List<dynamic>).where((e) {
  //     //return !excludedNodes.contains(e['node_id']);
  //     final nodeId = e['node_id'];
  //     return !nodeId.startsWith("WN-LP");
  //   }).toList();

  //   loadedVerticals.add(Vertical(
  //       title: prodName,
  //       vertices: filteredProdData
  //           .map((e) => Vertex(
  //               name: e['name'],
  //               nodeId: e['node_id'],
  //               type: prodName,
  //               latitude: e['latitude'],
  //               longitude: e['longitude'],
  //               data: e as Map<String, dynamic>))
  //           .toList()));
  // } else {
  //   loadedVerticals.add(Vertical(
  //       title: prodName,
  //       vertices: (prodData as List<dynamic>)
  //           .map((e) => Vertex(
  //               name: e['name'],
  //               nodeId: e['node_id'],
  //               type: prodName,
  //               latitude: e['latitude'],
  //               longitude: e['longitude'],
  //               data: e as Map<String, dynamic>))
  //           .toList()));
  // }

  //       });
  //     }
  //     _items = loadedVerticals.toList();
  //     //
  //     _excludedNodes = _items
  //         .expand((vertical) => vertical.vertices)
  //         .where((vertex) => vertex.excluded)
  //         .toList();

  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<void> getGraphReadings(String type, String nodeId) async {
    final start =
        DateTime.now().subtract(Duration(days: 3, hours: 3)).toIso8601String();
    final end = DateTime.now().subtract(Duration(days: 3)).toIso8601String();
    String url = "https://smartcitylivinglab.iiit.ac.in/graph/?start=";
    url += start;
    url += "&end=";
    url += end;
    url += "&type=";
    url += type.toUpperCase().replaceAll("_", "-");
    url += "&nodes=";
    url += nodeId;
    var uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      graph = extractedData;
      print(graph.toString());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
