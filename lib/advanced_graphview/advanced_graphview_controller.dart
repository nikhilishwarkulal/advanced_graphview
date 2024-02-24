import 'package:advanced_graphview/graph_node.dart';
import 'package:flutter/material.dart';

/// [AdvancedGraphviewController] will control the state of the widget
class AdvancedGraphviewController extends ValueNotifier {
  /// [cachedGraphNode] stores the cache
  GraphNode? cachedGraphNode;

  /// [AdvancedGraphviewController] will control the state of the widget
  AdvancedGraphviewController() : super(null);

  /// [scrollX] give it to control the scroll in canvas
  double? scrollX;

  /// [scrollY] give it to control the scroll in canvas
  double? scrollY;

  /// [maxScrollExtent] max scroll extent in canvas
  double? maxScrollExtent;

  /// [zoom] zoom level in canvas
  double? zoom;

  /// [setScroll] will scroll the in canvas
  void setScroll({double? scrollX, double? scrollY}) {
    this.scrollX = scrollX;
    this.scrollY = scrollY;
  }

  /// [setZoomValue]  zoom level in canvas
  void setZoomValue({double? zoom}) {
    this.zoom = zoom;
  }

  /// [clearCache] clear the cache
  void clearCache() {
    cachedGraphNode = null;
  }
}
