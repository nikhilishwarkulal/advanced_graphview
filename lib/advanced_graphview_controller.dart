import 'package:advanced_graphview/graph_node.dart';
import 'package:flutter/material.dart';

class AdvancedGraphviewController extends ValueNotifier {
  GraphNode? cachedGraphNode;
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
    cachedGraphNode = null;
  }
}
