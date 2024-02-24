import 'package:advanced_graphview/advanced_graphview_controller.dart';
import 'package:advanced_graphview/focus_point.dart';
import 'package:advanced_graphview/graph_node.dart';
import 'package:advanced_graphview/node_module.dart';
import 'package:advanced_graphview/world_map.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;

import 'graph_data_structure.dart';

class AdvancedGraphviewFlame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasGameRef {
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

  @override
  bool get debugMode => isDebug;
  final double? pixelRatio;
  final BuildContext context;
  late FocusPointImpl player;
  final double nodeSize;
  final double nodePadding;
  final GraphDataStructure graphDataStructure;
  final bool isDebug;
  final Paint? Function(GraphNode lineFrom, GraphNode lineTwo)? onDrawLine;
  final AdvancedGraphviewController? advancedGraphviewController;
  final Color? flameBackgroundColor;
  final Function(GraphNode)? onNodeTap;
  @override
  Color backgroundColor() {
    return flameBackgroundColor ?? mat.Colors.white;
  }

  @override
  Future<void> onLoad() async {
    world.add(WorldMap());
    world.add(player = FocusPointImpl());

    camera.setBounds(Rectangle.fromPoints(
        Vector2(0, 0), Vector2(WorldMap.size, WorldMap.size)));
    camera.follow(
      player,
    );
    void renderData() {
      double i = 0;
      double j = 0;
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

        if (j < WorldMap.size - (nodeSize + (nodePadding * 2))) {
          j = j + (nodeSize + (nodePadding * 2));
        } else {
          i = i + (nodeSize + (nodePadding * 2));
          j = 0;
        }
      });
    }

    void addLines() {
      graphDataStructure.generateItem((node) {
        world.add(LineDrawer(graphNode: node));
      });
    }

    renderData();
    addLines();
  }

  static const speed = 2000.0;
  @override
  void update(double dt) {
    super.update(dt);
    camera.viewfinder.zoom = advancedGraphviewController?.zoom ?? 1;
  }
}
