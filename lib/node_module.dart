import 'dart:math';
import 'dart:ui';

import 'package:advanced_graphview/graph_node.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';

import 'advanced_graphview_flame.dart';
import 'graph_data_structure.dart';
import 'image_loader.dart';

class NodeModule extends PositionComponent
    with HasGameRef<AdvancedGraphviewFlame> {
  final Vector2 nodeSize;
  final Vector2 nodePosition;
  final double nodePadding;
  final double nodeImageSize;
  final GraphDataStructure graphDataStructure;
  final GraphNode graphNode;
  NodeModule({
    required this.nodeSize,
    required this.nodePosition,
    required this.nodePadding,
    required this.graphDataStructure,
    required this.graphNode,
    required this.nodeImageSize,
  });
  bool isUpdated = false;
  @override
  Future<void> onLoad() async {
    size = nodeSize;
    position = nodePosition;

    game.world.add(NodeModuleItem(
        nodeSize: nodeSize,
        nodePosition: nodePosition,
        nodePadding: nodePadding,
        graphDataStructure: graphDataStructure,
        graphNode: graphNode,
        nodeImageSize: nodeImageSize));
    return super.onLoad();
  }
}

class NodeModuleItem extends SpriteComponent
    with HasGameRef<AdvancedGraphviewFlame>, DragCallbacks, TapCallbacks {
  final Vector2 nodeSize;
  final Vector2 nodePosition;
  final double nodePadding;
  final double nodeImageSize;
  final GraphDataStructure graphDataStructure;
  final GraphNode graphNode;
  NodeModuleItem({
    required this.nodeSize,
    required this.nodePosition,
    required this.nodePadding,
    required this.graphDataStructure,
    required this.graphNode,
    required this.nodeImageSize,
  });
  bool isUpdated = false;
  @override
  Future<void> onLoad() async {
    priority = 2;
    size = Vector2.all(nodeImageSize);
    var rng = Random();
    if (graphNode.cachedPosition == null ||
        game.advancedGraphviewController == null) {
      position = nodePosition +
          Vector2(rng.nextInt((nodePadding * 2).toInt()).toDouble(),
              rng.nextInt((nodePadding * 2).toInt()).toDouble());
    } else {
      position = graphNode.cachedPosition!.toVector2();
    }

    graphNode.cachedPosition = position.toOffset();
    sprite = Sprite(
      grenade,
    );

    return super.onLoad();
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    if (game.onNodeTap != null) {
      game.onNodeTap!(graphNode);
    }
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (!isUpdated && graphDataStructure.nodeImages.containsKey(graphNode.id)) {
      isUpdated = true;
      sprite = Sprite(graphDataStructure.nodeImages[graphNode.id]!);
      graphNode.item = this;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
    graphNode.cachedPosition = position.toOffset();
  }
}

class LineDrawer extends PositionComponent
    with HasGameRef<AdvancedGraphviewFlame> {
  LineDrawer({required this.graphNode}) : super();
  final GraphNode graphNode;

  @override
  Future<void> onLoad() async {}

  @override
  void render(Canvas canvas) {
    for (var items in graphNode.graphNodes) {
      if (graphNode.item == null) break;
      if (items.item == null) continue;
      Paint paint = BasicPalette.red.paint();
      if (game.onDrawLine != null) {
        paint = game.onDrawLine!(items, graphNode) ?? BasicPalette.red.paint();
      }
      canvas.drawLine(items.item!.center.toOffset(),
          graphNode.item!.center.toOffset(), paint);
    }
  }
}
