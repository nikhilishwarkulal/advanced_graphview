import 'package:advanced_graphview/advanced_graphview/advanced_graphview_flame.dart';
import 'package:advanced_graphview/graph_node.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

/// [LineDrawer] draws a line between 2 nodes
/// parent to child
class LineDrawer extends PositionComponent
    with HasGameRef<AdvancedGraphviewFlame> {
  /// [LineDrawer] draws a line between 2 nodes
  /// parent to child
  LineDrawer({required this.graphNode}) : super();

  /// [graphNode] draws line to its children
  final GraphNode graphNode;

  @override
  Future<void> onLoad() async {}

  @override
  void render(Canvas canvas) {
    /// loop all children from graph node
    for (var items in graphNode.graphNodes) {
      /// if graphNode items is null breaks
      if (graphNode.item == null) break;

      /// if child item is  null then continue the loop
      if (items.item == null) continue;
      Paint paint = BasicPalette.red.paint();
      if (game.onDrawLine != null) {
        // get the pain from user implementation
        paint = game.onDrawLine!(items, graphNode) ?? BasicPalette.red.paint();
      }

      /// draw a line from parent to children
      canvas.drawLine(items.item!.center.toOffset(),
          graphNode.item!.center.toOffset(), paint);
    }
  }
}
