import 'dart:ui' as ui;

import 'package:advanced_graphview/node_module/node_module_item.dart';

abstract class GraphNode {
  /// id represents the uniqueness of the node.
  /// id is used to link nodes.
  /// children id must not be same as parent to avoid self looping.
  String get id;

  /// [graphNodes] takes the list of children that
  /// will be used to traverse further
  List<GraphNode> get graphNodes;

  /// [item] is the configuration of the node UI if we pass this then based
  /// on the configuration the node will be rendered this is optional
  NodeModuleItem? item;

  /// this is the cached position if this position is passed then it will get
  /// cached and then position can be reused instead of regenerating the whole
  /// node position randomly
  ui.Offset? cachedPosition;
}
