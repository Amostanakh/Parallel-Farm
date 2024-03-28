import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/utils/utils.dart';

import '../../models/animal_model.dart';
import '../components/main_screen_background.dart';
import '../components/main_screen_button.dart';

class ParrallelFarm extends FlameGame {
  SpriteAnimationComponent chickensAnimationblink = SpriteAnimationComponent();
  SpriteAnimationComponent thirdChickensAnimationblink =
      SpriteAnimationComponent();
  SpriteAnimationComponent secChickensAnimationblink =
      SpriteAnimationComponent();
  SpriteAnimationComponent blankChickensAnimationblink =
      SpriteAnimationComponent();

  List<SpriteAnimationComponent> chickenAnimations = [];
  String direction = 'down';
  double speed = 0.10;
  static final Paint red = BasicPalette.red.paint();

  final BuildContext context;
  final List<Animal> animalsOwnedByUser;

  ParrallelFarm(this.context, this.animalsOwnedByUser)
      : super(
          camera: CameraComponent.withFixedResolution(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        );

  Canvas get canvas {
    // TODO: implement canvas
    throw UnimplementedError();
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    //make shared prefference for current page zero
    saveInt(currentPageInt, 1);

    camera.viewfinder.anchor = Anchor.topLeft;

    addAll([
      Background(),
    ]);

    //Check if user has any animals

    // How it works
    var positionMenuButton = Vector2(size.x * 0.05, size.y * 0.07);
    var sizeMenuButton = Vector2(70, 70);

    final menuButtonSprite = await Flame.images.load('how_to_play.png');
    var menuButton = MainScreenButton(positionMenuButton, sizeMenuButton, 1,
        Sprite(menuButtonSprite), context, '', animalsOwnedByUser);

    /*
    *   Top Buttons
    */

    double commonXCoordinate = size.x / 2;
    // How it works
    var positionHowButton = Vector2((size.x / 2) - 170, size.y * 0.15);
    var sizeHowButton = Vector2(70, 70);

    final howButtonSprite = await Flame.images.load('how_to_play.png');
    var howButton = MainScreenButton(positionHowButton, sizeHowButton, 1,
        Sprite(howButtonSprite), context, '', animalsOwnedByUser);

    // Barn
    // var positionBarnButton = Vector2(size.x * 0.05, size.y * 0.25);
    var positionBarnButton = Vector2((size.x / 2) - 170, size.y * 0.25);
    var sizeBarnButton = Vector2(70, 70);
    final barnButtonSprite = await Flame.images.load('barn.png');
    var barnButton = MainScreenButton(positionBarnButton, sizeBarnButton, 2,
        Sprite(barnButtonSprite), context, barnPage, animalsOwnedByUser);
    // The line above is where we skip the animal screen page and go straight to the chickens barn page -barnPage

    // Animal Market

    var positionAnimalMarketButton = Vector2(size.x * 0.77, size.y * 0.15);
    var sizeAnimalMarketButton = Vector2(70, 70);

    final animalMarketButtonSprite =
        await Flame.images.load('animal_adoption.png');
    var aimalMarketButton = MainScreenButton(
        positionAnimalMarketButton,
        sizeAnimalMarketButton,
        3,
        Sprite(animalMarketButtonSprite),
        context,
        animalMarket,
        animalsOwnedByUser);

    // PWs

    var positionPWButton = Vector2(size.x * 0.77, size.y * 0.25);
    var sizePWButton = Vector2(70, 70);

    final pwButtonSprite = await Flame.images.load('wallet_new.png');
    var pwButton = MainScreenButton(positionPWButton, sizePWButton, 4,
        Sprite(pwButtonSprite), context, pwScreen, animalsOwnedByUser);

    // Parrallel World Logo

    // var logoPositionButton = Vector2(size.x * 0.25, size.y * 0.10);
    // var sizeLogoButton = Vector2(200, 85);

    // final logoButtonSprite = await Flame.images.load('logo.png');
    // var logoButton = MainScreenButton(logoPositionButton, sizeLogoButton, 5,
    //     Sprite(logoButtonSprite), context, '', animalsOwnedByUser);

    /*
    *   Bottom Buttons
    */

    if (animalsOwnedByUser.isEmpty) {
      //Left Button
      var positionblankchickButton = Vector2(size.x * 0.33, size.y * 0.50);
      var sizeBlankButton = Vector2(125, 135);
      final blankChickButtonImage = await Flame.images.load('blankchick.png');
      var blankButton = MainScreenButton(
          positionblankchickButton,
          sizeBlankButton,
          7,
          Sprite(blankChickButtonImage),
          context,
          animalMarket,
          animalsOwnedByUser);

      add(blankButton);
    } else {
      if (animalsOwnedByUser.length > 6) {
        var positionLeftArrowButton = Vector2(size.x * 0.0, size.y * 0.50);
        var sizeLeftArrowButton = Vector2(40, 40);

        final leftButtonSprite = await Flame.images.load('leftArrow.png');
        var leftButton = MainScreenButton(
            positionLeftArrowButton,
            sizeLeftArrowButton,
            8,
            Sprite(leftButtonSprite),
            context,
            '',
            animalsOwnedByUser);

        add(leftButton);

        //Right Arrow button
        var positionRightArrowButton = Vector2(size.x * 0.90, size.y * 0.50);
        var sizeArrowButton = Vector2(40, 40);

        final rightButtonSprite = await Flame.images.load('rightArrow.png');
        var rightButton = MainScreenButton(
            positionRightArrowButton,
            sizeArrowButton,
            9,
            Sprite(rightButtonSprite),
            context,
            '',
            animalsOwnedByUser);
        add(rightButton);

        for (var i = 0; i < 6; i++) {
          var spriteSheet = await Flame.images.load('chickens.png');
          final spriteSize = Vector2(120, 120);
          SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
              amount: 1, stepTime: 1.50, textureSize: Vector2(152.0, 142.0));

          // Create both top and bottom animations within the same loop

          var animation = SpriteAnimationComponent.fromFrameData(
            spriteSheet,
            spriteData,
          )..size = spriteSize;

          // Position based on row (top or bottom)
          if (i < 3) {
            // Top row
            animation
              ..x = 25.0 +
                  (i * spriteSize.x) // Offset horizontally for each animation
              ..y = size.y * 0.4;
          } else {
            // Bottom row
            animation
              ..x = 25.0 + ((i % 3) * spriteSize.x)
              ..y = size.y * 0.5; // Adjust bottom row position as needed
          }

          add(animation);
        }
      } else {
        for (var i = 0; i < animalsOwnedByUser.length; i++) {
          var spriteSheet = await Flame.images.load('chickens.png');
          final spriteSize = Vector2(120, 120);
          SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
              amount: 1, stepTime: 1.50, textureSize: Vector2(152.0, 142.0));

          // Create both top and bottom animations within the same loop

          var animation = SpriteAnimationComponent.fromFrameData(
            spriteSheet,
            spriteData,
          )..size = spriteSize;

          // Position based on row (top or bottom)
          if (i < 3) {
            // Top row
            animation
              ..x = 25.0 +
                  (i * spriteSize.x) // Offset horizontally for each animation
              ..y = size.y * 0.4;
          } else {
            // Bottom row
            animation
              ..x = 25.0 + ((i % 3) * spriteSize.x)
              ..y = size.y * 0.5; // Adjust bottom row position as needed
          }

          add(animation);
        }
      }
    }

    // Feed Button
    var positionFeedButton = Vector2(size.x * 0.73, size.y * 0.75);
    var sizeFeedButton = Vector2(80, 80);
    final feedButtonSprite = await Flame.images.load('feedButton.png');
    var feedButton = MainScreenButton(positionFeedButton, sizeFeedButton, 6,
        Sprite(feedButtonSprite), context, '', animalsOwnedByUser)
      ..add;

    // Other buttons
    //Size
    var sizeOtherMainButtons = Vector2(65, 65);
    // Settings
    var positionSettingButton = Vector2((size.x / 2) - 90, size.y * 0.85);
    final settingbuttonSprite = await Flame.images.load('settings.png');
    var settingButton = MainScreenButton(
        positionSettingButton,
        sizeOtherMainButtons,
        7,
        Sprite(settingbuttonSprite),
        context,
        userNavigationScreen,
        animalsOwnedByUser);
    // The line above is where we skip the animal screen page and go straight to the chickens barn page -barnPage

    // Invite
    var positionInviteButton = Vector2((size.x / 2) - 170, size.y * 0.85);
    final inviteButtonSprite = await Flame.images.load('inviteIcon.png');
    var inviteButton = MainScreenButton(
        positionInviteButton,
        sizeOtherMainButtons,
        8,
        Sprite(inviteButtonSprite),
        context,
        inviteScreen,
        animalsOwnedByUser);

    final regular = TextPaint(
      style: TextStyle(
        fontSize: 10.0,
        color: BasicPalette.white.color,
      ),
    );

    final textComponent = TextComponent(
      text: "INVITE",
      textRenderer: regular,
      position: Vector2((size.x / 2) - 152, size.y * 0.95),
    );

    final settingsText = TextComponent(
      text: "SETTINGS",
      textRenderer: regular,
      position: Vector2((size.x / 2) - 80, size.y * 0.95),
    );

    addAll([
      feedButton,
      barnButton,
      settingButton,
      inviteButton,
      textComponent,
      settingsText,
      howButton,
      aimalMarketButton,
      pwButton,
      // logoButton
    ]);
  }

  @override
  update(double dt) {
    super.update(dt);
//from the variable direction above
    switch (direction) {
      //At init it goes dowwn with the speed defined above
      case 'down':
        chickensAnimationblink.y += speed;
        break;

      //if the it reaches down it supposed to go up again with the speed above
      case 'up':
        chickensAnimationblink.y -= speed;
        break;
      case 'stop':
        chickensAnimationblink.y = 0.0;
    }

// y coodinate were the chicken must stop if going down
    if (chickensAnimationblink.y > 300) {
      direction = 'up';
    }

    // y coodinate were the chicken must stop if going up
    if (chickensAnimationblink.y < 301) {
      direction = 'down';
    }

    switch (direction) {
      case 'down':
        secChickensAnimationblink.y += speed;
        break;
      case 'up':
        secChickensAnimationblink.y -= speed;
        break;
      case 'stop':
        chickensAnimationblink.y = 0.0;
    }

    if (secChickensAnimationblink.y > 300) {
      direction = 'up';
    }
    if (secChickensAnimationblink.y < 303) {
      direction = 'down';
    }

    switch (direction) {
      case 'down':
        thirdChickensAnimationblink.y += speed;
        break;
      case 'up':
        thirdChickensAnimationblink.y -= speed;
        break;
      case 'stop':
        chickensAnimationblink.y = 0.0;
    }

    if (thirdChickensAnimationblink.y > 300) {
      direction = 'up';
    }
    if (thirdChickensAnimationblink.y < 303) {
      direction = 'down';
    }
  }
}
