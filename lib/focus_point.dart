import 'package:advanced_graphview/advanced_graphview/advanced_graphview_flame.dart';
import 'package:advanced_graphview/world_map.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' as mat;

/// [FocusPoint] is just a pointer pointing center of the screen
/// since this is an game engine while scrolling focal point will
/// be move based on direction
class FocusPoint<T extends FlameGame> extends PositionComponent
    with HasGameReference<T> {
  FocusPoint({super.position, Vector2? size, super.priority, super.key})
      : super(
          size: size ?? Vector2.all(50),
          anchor: Anchor.center,
        );

  @mat.mustCallSuper
  @override
  Future<void> onLoad() async {}
}

/// [FocusPoint] is just a pointer pointing center of the screen
/// since this is an game engine while scrolling focal point will
/// be move based on direction
class FocusPointImpl extends FocusPoint<AdvancedGraphviewFlame>
    with CollisionCallbacks {
  /// speed of focal point movement
  /// is same as speed of scroll
  static const double speed = 300;

  /// this is to position the test in the center
  static final TextPaint textRenderer = TextPaint(
    style: const mat.TextStyle(color: mat.Colors.white70, fontSize: 12),
  );

  final Vector2 velocity = Vector2.zero();
  late final TextComponent positionText;
  late final Vector2 textPosition;
  late final maxPosition = Vector2.all(CanvasMap.size + 25);
  late final minPosition = Vector2.zero() + Vector2.all(25);
  int consumed = 0;
  FocusPointImpl() : super(priority: 2);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    positionText = TextComponent(
      textRenderer: textRenderer,
      position: (size / 2)..y = size.y / 2 + 30,
      anchor: Anchor.center,
    );
    //add(positionText);
    position = Vector2(CanvasMap.size / 2, CanvasMap.size / 2);
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
}
