import 'dart:ui';

import 'package:flame/flame.dart';

late Image grenade;

Future<void> loadImage() async {
  grenade = await Flame.images.load('animations/grenade.png');
}
