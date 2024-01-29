library advanced_graphview;

import 'dart:ui' as ui;

import 'package:advanced_graphview/node_module.dart';
import 'package:flutter/cupertino.dart';

class GraphDataStructure {
  Map<String, ui.Image> nodeImages = {};
  GraphNode graphNode;
  GraphDataStructure({required this.graphNode});
  Set<String> getListOfItems() {
    Set<String> test = {};

    void recursion(GraphNode node) {
      bool cond = test.add(node.id);
      if (cond) {
        for (GraphNode child in node.graphNodes) {
          recursion(child);
        }
      }
    }

    recursion(graphNode);
    return test;
  }

  Map<String, GraphNode> getAllItems() {
    Map<String, GraphNode> test = {};

    void recursion(GraphNode node) {
      if (test.containsKey(node.id)) {
        return;
      }
      test[node.id] = node;

      for (GraphNode child in node.graphNodes) {
        recursion(child);
      }
    }

    recursion(graphNode);
    return test;
  }

  List<GraphNode> getList() {
    Map<String, GraphNode> temp = getAllItems();
    List<GraphNode> result = [];
    temp.forEach((key, value) {
      result.add(value);
    });
    return result;
  }

  void generateItem(Function(GraphNode) onLoad) {
    Set<String> test = {};

    void recursion(GraphNode node, void Function(GraphNode) onLoad) {
      bool cond = test.add(node.id);
      if (cond) {
        onLoad(node);
        for (GraphNode child in node.graphNodes) {
          recursion(child, onLoad);
        }
      }
    }

    recursion(graphNode, onLoad);
  }
}

abstract class GraphNode {
  /// id represents the uniqueness of the node.
  /// id is used to link nodes.
  /// children id must not be same as parent. to avoid self loop
  String get id;

  List<GraphNode> get graphNodes;

  NodeModuleItem? item;

  ui.Offset? cachedPosition;
}

class AdvancedGraphviewController extends ValueNotifier {
  GraphNode? chachedGraphNode;
  AdvancedGraphviewController() : super(null);
  double? scrollX;
  double? scrollY;
  double? maxScrollExtent;
  double? zoom;
  void setScroll({double? scrollX, double? scrollY}) {
    this.scrollX = scrollX;
    this.scrollY = scrollY;
  }

  void setZoomValue({double? zoom}) {
    this.zoom = zoom;
  }

  void clearCache() {
    chachedGraphNode = null;
  }
}
