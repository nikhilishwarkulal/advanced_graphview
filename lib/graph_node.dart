import 'dart:ui' as ui;

import 'package:advanced_graphview/node_module.dart';

abstract class GraphNode {
  /// id represents the uniqueness of the node.
  /// id is used to link nodes.
  /// children id must not be same as parent to avoid self looping.
  String get id;

  List<GraphNode> get graphNodes;

  NodeModuleItem? item;

  ui.Offset? cachedPosition;
}
