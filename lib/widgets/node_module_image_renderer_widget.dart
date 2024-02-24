import 'dart:ui' as ui;

import 'package:advanced_graphview/graph_node.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../graph_data_structure.dart';

/// [NodeModuleImageRenderer] will render the widget in the cell (tree leaf)
class NodeModuleImageRenderer extends StatefulWidget {
  /// [child] is the child to be rendered in the tree lead
  final Widget child;

  /// [nodeSize] size of the widget
  final Vector2 nodeSize;

  /// [graphNode] graphnode will point to the tree
  final GraphNode graphNode;

  /// [graphDataStructure] instance is need to calculate the graphs
  final GraphDataStructure graphDataStructure;

  /// [pixelRatio] defines resolution of the widget
  final double pixelRatio;
  const NodeModuleImageRenderer({
    super.key,
    required this.child,
    required this.nodeSize,
    required this.graphDataStructure,
    required this.graphNode,
    required this.pixelRatio,
  });

  @override
  State<NodeModuleImageRenderer> createState() =>
      _NodeModuleImageRendererState();
}

class _NodeModuleImageRendererState extends State<NodeModuleImageRenderer> {
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(
        const Duration(seconds: 1),
        () => _capturePng(),
      );
    });
  }

  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: widget.pixelRatio);
    widget.graphDataStructure.nodeImages[widget.graphNode.id] = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.nodeSize.x,
        height: widget.nodeSize.y,
        child: RepaintBoundary(
          key: globalKey,
          child: Align(
            child: SizedBox(
              width: widget.nodeSize.x,
              height: widget.nodeSize.y,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
