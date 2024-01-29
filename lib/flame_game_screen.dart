import 'package:advanced_graphview/node_module.dart';
import 'package:advanced_graphview/world_map.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/services.dart';

import 'advanced_graphview.dart';

class Ember<T extends FlameGame> extends PositionComponent
    with HasGameReference<T> {
  Ember({super.position, Vector2? size, super.priority, super.key})
      : super(
          size: size ?? Vector2.all(50),
          anchor: Anchor.center,
        );

  @mat.mustCallSuper
  @override
  Future<void> onLoad() async {}
}

class FollowComponentExample extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasGameRef {
  FollowComponentExample({
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
  late MovableEmber player;
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
    world.add(player = MovableEmber());

    //world.add(CirclingEnemy(player: ember));

    // world.add(SimpleBullet(player: ember));
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

class MovableEmber extends Ember<FollowComponentExample>
    with CollisionCallbacks, KeyboardHandler {
  static const double speed = 300;
  static final TextPaint textRenderer = TextPaint(
    style: const mat.TextStyle(color: mat.Colors.white70, fontSize: 12),
  );

  final Vector2 velocity = Vector2.zero();
  late final TextComponent positionText;
  late final Vector2 textPosition;
  late final maxPosition = Vector2.all(WorldMap.size + 25);
  late final minPosition = Vector2.zero() + Vector2.all(25);
  // late BallBorder ballBorder;
  int consumed = 0;
  MovableEmber() : super(priority: 2);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    positionText = TextComponent(
      textRenderer: textRenderer,
      position: (size / 2)..y = size.y / 2 + 30,
      anchor: Anchor.center,
    );
    //add(positionText);
    position = Vector2(WorldMap.size / 2, WorldMap.size / 2);
    add(
      CircleHitbox()
        ..paint = hitboxPaint
        ..renderShape = true,
    );
  }

  final mat.Paint hitboxPaint = BasicPalette.transparent.paint()
    ..style = mat.PaintingStyle.stroke;
  final mat.Paint dotPaint = BasicPalette.red.paint()
    ..style = mat.PaintingStyle.stroke;

  @override
  void update(double dt) {
    super.update(dt);
    final deltaPosition = velocity * (speed * dt);
    position.add(deltaPosition);
    position.clamp(minPosition, maxPosition);
    size = Vector2(50, 50);
    positionText.text = '(${x.toInt()}, ${y.toInt()})';
    position = (game.advancedGraphviewController?.scrollX != null &&
            game.advancedGraphviewController?.scrollY != null)
        ? Vector2(game.advancedGraphviewController!.scrollX!,
            game.advancedGraphviewController!.scrollY!)
        : position;
    // print(game.camera.);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;

    final bool handled;
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      velocity.x = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      velocity.x = isKeyDown ? 1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      velocity.y = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      velocity.y = isKeyDown ? 1 : 0;
      handled = true;
    } else {
      handled = false;
    }

    if (handled) {
      //angle = -velocity.angleToSigned(Vector2(1, 0));
      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }
}
