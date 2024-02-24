library advanced_graphview;

import 'dart:ui' as ui;

import 'package:advanced_graphview/graph_node.dart';

/// [GraphDataStructure] this handles the graph data structure
class GraphDataStructure {
  Map<String, ui.Image> nodeImages = {};
  GraphNode graphNode;

  /// [GraphDataStructure] this handles the graph data structure
  /// like traversing and searching, ui generation while traversing.
  GraphDataStructure({required this.graphNode});

  /// [getListOfItems] will give you the list of items as Id in the tree
  Set<String> getListOfItems() {
    Set<String> test = {};

    /// recursive way of getting all ID [DFD approach]
    void recursion(GraphNode node) {
      bool cond = test.add(node.id);
      if (cond) {
        for (GraphNode child in node.graphNodes) {
          recursion(child);
        }
      }
    }

    /// call [recursion] [DFD approach]
    recursion(graphNode);
    return test;
  }

  /// [getAllItems] will give you all the items in the tree
  /// with map format where map key is ID and value is [GraphNode]
  Map<String, GraphNode> getAllItems() {
    Map<String, GraphNode> test = {};

    /// recursive way of getting all ID [DFD approach]
    void recursion(GraphNode node) {
      if (test.containsKey(node.id)) {
        return;
      }
      test[node.id] = node;

      for (GraphNode child in node.graphNodes) {
        recursion(child);
      }
    }

    /// call [recursion] [DFD approach]
    recursion(graphNode);
    return test;
  }

  /// [getList] will give you all the items in the tree
  /// with list format
  List<GraphNode> getList() {
    Map<String, GraphNode> temp = getAllItems();
    List<GraphNode> result = [];
    temp.forEach((key, value) {
      result.add(value);
    });
    return result;
  }

  /// [generateItem] is generators so while traversing in a tree
  /// [onload] will be called on each traversion of node.
  /// this function so we can get widget from user while traversing so on
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
