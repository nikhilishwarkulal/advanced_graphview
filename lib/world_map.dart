import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// [CanvasMap] will be the are where the entire
/// Nodes are presented this is the free open canvas settings
class CanvasMap extends Component {
  /// default size of canvas is 1500 but this can go higher
  /// based on the number of element available
  static double size = 1500;

  /// [CanvasMap] will be the are where the entire
  /// Nodes are presented this is the free open canvas settings
  CanvasMap() : super(priority: 0);

  @override
  Future<void> onLoad() async {}

  @override
  void render(Canvas canvas) {
    /// If you want to add any background then it can be added here.
  }
}
