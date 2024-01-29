import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class WorldMap extends Component {
  static double size = 1500;

  WorldMap() : super(priority: 0);

  @override
  Future<void> onLoad() async {}

  @override
  void render(Canvas canvas) {
    // canvas.drawRect(_bounds, _paintBg);
    // canvas.drawRect(_bounds, _paintBorder);
    for (double i = 0; i < size; i = i + 50) {
      for (double j = 0; j < size; j = j + 50) {
        // canvas.drawRect(_rectPool[i], _paintBorder);
        //canvas.drawImage(rectangleBgImage, Offset(i, j), _paintBorder);
      }
    }
  }
}
