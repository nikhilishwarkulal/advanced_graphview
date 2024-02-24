import 'package:advanced_graphview/advanced_graphview/advanced_graphview_controller.dart';
import 'package:advanced_graphview/focus_point.dart';
import 'package:advanced_graphview/graph_node.dart';
import 'package:advanced_graphview/node_module/line_drawer.dart';
import 'package:advanced_graphview/node_module/node_module.dart';
import 'package:advanced_graphview/world_map.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;

import '../graph_data_structure.dart';

/// [AdvancedGraphviewFlame] uses flame engine to render
/// the tree and its children
class AdvancedGraphviewFlame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasGameRef {
  /// [AdvancedGraphviewFlame] uses flame engine to render
  /// the tree and its children
  AdvancedGraphviewFlame({
    required this.nodePadding,
    required this.nodeSize,
    required this.graphDataStructure,
    required this.context,
    required this.isDebug,
    required this.onDrawLine,
    required this.advancedGraphviewController,
    required this.flameBackgroundColor,
    required this.pixelRatio,
    required this.onNodeTap,
  }) : super(
          camera: CameraComponent(),
        );

  /// [isDebug] default is false and debug mode will show wireframe on tree
  @override
  bool get debugMode => isDebug;

  /// [pixelRatio] gives the resolution to the widget after rendering
  final double? pixelRatio;

  /// [context]so widget can be rendered
  final BuildContext context;

  /// [focusPoint] will focus the center of canvas
  late FocusPointImpl focusPoint;

  /// [nodeSize] size of the tree node in canvas
  final double nodeSize;

  /// [nodePadding] padding of between 2 nodes
  final double nodePadding;

  /// [graphDataStructure] takes care of handling the tree, like traversing
  /// tree to list etc,
  final GraphDataStructure graphDataStructure;

  /// [isDebug] default is false and debug mode will show wireframe on tree
  final bool isDebug;

  /// draws a line between 2 nodes return paint so paint can be used to
  /// give color to the line, etc.
  final Paint? Function(GraphNode lineFrom, GraphNode lineTwo)? onDrawLine;

  /// [advancedGraphviewController] will manage the state of the graphview
  final AdvancedGraphviewController? advancedGraphviewController;

  /// [flameBackgroundColor] sets background color to the canvas
  final Color? flameBackgroundColor;

  /// [onNodeTap] when we tap a node in the tree this action will be
  /// triggered
  final Function(GraphNode)? onNodeTap;

  /// background color for canvas
  @override
  Color backgroundColor() {
    return flameBackgroundColor ?? mat.Colors.white;
  }

  @override
  Future<void> onLoad() async {
    /// first add the canvas map
    world.add(CanvasMap());

    /// add the focus point so cam will be pointing in the center
    world.add(focusPoint = FocusPointImpl());

    /// add bound to the Canvas so camera cannot move beyond the size
    camera.setBounds(Rectangle.fromPoints(
        Vector2(0, 0), Vector2(CanvasMap.size, CanvasMap.size)));

    ///  camera should fallow the focusPoint focus point moves
    ///  int canvas for scroll and for zoom
    camera.follow(
      focusPoint,
    );

    /// render the nodes in the screen
    void renderData() {
      double i = 0;
      double j = 0;

      /// render the nodes in the screen
      graphDataStructure.generateItem((node) {
        double nodei = i;
        double nodej = j;
        world.add(
          NodeModule(
              nodeSize: Vector2((nodeSize + (nodePadding * 2)),
                  (nodeSize + (nodePadding * 2))),
              nodePosition: Vector2(nodej, nodei),
              nodePadding: nodePadding,
              graphNode: node,
              nodeImageSize: nodeSize,
              graphDataStructure: graphDataStructure),
        );

        if (j < CanvasMap.size - (nodeSize + (nodePadding * 2))) {
          j = j + (nodeSize + (nodePadding * 2));
        } else {
          i = i + (nodeSize + (nodePadding * 2));
          j = 0;
        }
      });
    }

    /// once node is rendered then render the lines
    void addLines() {
      graphDataStructure.generateItem((node) {
        world.add(LineDrawer(graphNode: node));
      });
    }

    /// render the nodes in the screen
    renderData();

    /// once node is rendered then render the lines
    addLines();
  }

  static const speed = 2000.0;
  @override
  void update(double dt) {
    super.update(dt);

    /// update the zoom value based on the controllers input
    camera.viewfinder.zoom = advancedGraphviewController?.zoom ?? 1;
  }
}
