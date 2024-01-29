// late Image rectangleBgImage;
// late Image enemy1;
// late Image simpleBullet;
// late Image solidBullet;
// late Image money;
// late Image simpleBulletExplotion;
import 'dart:ui';

import 'package:flame/flame.dart';

late Image grenade;
// late Image grenadeExplosion;

Future<void> loadImage() async {
  // grenade = await Flame.images
  //     .load('packages/advanced_graphview/assets/images/animations/grenade.png');

  grenade = await Flame.images.load('animations/grenade.png');
}
