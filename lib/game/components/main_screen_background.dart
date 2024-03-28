import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:parallel_farm/game/screens/main_screen.dart';

class Background extends SpriteComponent with HasGameRef<ParrallelFarm> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load('mainBg.jpg');
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
