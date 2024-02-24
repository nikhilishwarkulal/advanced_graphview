import 'dart:math';

import 'package:advanced_graphview/graph_node.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';

import '../advanced_graphview/advanced_graphview_flame.dart';
import '../graph_data_structure.dart';
import '../image_loader.dart';

/// [NodeModuleItem] will render the child item
/// in the canvas
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
      transparentImage,
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
