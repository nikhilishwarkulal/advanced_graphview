import 'dart:ui';

import 'package:flame/flame.dart';

/// this stores the transparent image
late Image transparentImage;

/// loads the transparent image
Future<void> loadImage() async {
  /// The base 64 string here is 1x1 pixel transparent image
  transparentImage = await Flame.images.fromBase64('key',
      "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=");
}
