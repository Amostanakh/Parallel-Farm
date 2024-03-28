import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/constants/gameConstants.dart';
import 'package:parallel_farm/game/screens/main_screen.dart';
import 'package:parallel_farm/services/barn_service.dart';
import 'package:parallel_farm/services/feed_service.dart';
import 'package:parallel_farm/utils/utils.dart';

import '../../models/animal_model.dart';

class MainScreenButton extends SpriteComponent
    with HasGameRef<ParrallelFarm>, TapCallbacks {
  final BuildContext context;
  final List<Animal> animalsOwnedByUser;
  FeedService feedAllMyAdoptedAnimals = FeedService();
  FeedService myfeedBalance = FeedService();
  BarnService getMyAnimals = BarnService();
  int numberOfPages = 0;
  int numberOfAnimalsOnFinalPage = 0;

  final String screen;
  MainScreenButton(Vector2 position, Vector2 size, int priority, Sprite sprite,
      this.context, this.screen, this.animalsOwnedByUser) {
    this.position = position;
    this.size = size;
    this.sprite = sprite;
    this.priority = priority;
  }

  Future<void> slideAndFadeOut(SpriteAnimationComponent component,
              int i, bool isRightArrow) async {
    int currentPage = await getSPInt(currentPageInt);
    if (isRightArrow) {
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = 0;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = 40;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = 60;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = 80;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = 100;
      });

      Future.delayed(const Duration(milliseconds: 600), () {
        if (i < 3) {
          // Top row
          component.x = 0 +
              (i * component.width); // Offset horizontally for each animation
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 5.0 + (i * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 10.0 + (i * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 15.0 + (i * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 20.0 + (i * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 25.0 + (i * component.width);
          });
        } else {
          component.x = 50 +
              (i * component.width); // Offset horizontally for each animation
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 45.0 + ((i % 3) * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 40.0 + ((i % 3) * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 35.0 + ((i % 3) * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 30.0 + ((i % 3) * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 25.0 + ((i % 3) * component.width);
          });
        }
      });
    } else if (currentPage > 0) {
      component.x = -0;
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = -20;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = -40;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = -60;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = -80;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        component.x = -100;
      });

      Future.delayed(const Duration(milliseconds: 600), () {
        if (i < 3) {
          // Top row
          component.x = 50 +
              (i * component.width); // Offset horizontally for each animation
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 45.0 + (i * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 40.0 + (i * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 35.0 + (i * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 30.0 + (i * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 25.0 + (i * component.width);
          });
        } else {
          component.x = 50 +
              (i * component.width); // Offset horizontally for each animation
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 45.0 + ((i % 3) * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 40.0 + ((i % 3) * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 35.0 + ((i % 3) * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 30.0 + ((i % 3) * component.width);
          });
          Future.delayed(const Duration(milliseconds: 400), () {
            component.x = 25.0 + ((i % 3) * component.width);
          });
        }
      });
    }
  }

  @override
  Future<void> onTapUp(TapUpEvent event) async {
    if (screen != '') {
      Navigator.of(context).pushNamed(
          screen);
    } else {
      if (priority == 1) {
        // For instructions
        game.overlays.add(GameConstants.how);
      } else if (priority == 2) {
        // For screen
        game.overlays.add(GameConstants.streak);
      } else if (priority == 6) {
        // For feed
        if (animalsOwnedByUser.isNotEmpty) {
          var feedResponse = await feedAllMyAdoptedAnimals.feedAllAnimals();
          if (feedResponse[0] == 201) {
            Fluttertoast.showToast(
              msg: "Feeding success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 7,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 15.0,
            );
          } else {
            Fluttertoast.showToast(
              msg: "Feeding failed!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 7,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 15.0,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: "No adopted animals found at the moment",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 15.0,
          );
        }
      } else if (priority == 8) {
        // Left arrow
        // Left Arrow
        int currentPage = await getSPInt(currentPageInt);

        if (currentPage > 1) {
          currentPage--;
          saveInt(currentPageInt, currentPage);
          int chickenComponentindex = 0;
          var list = game.children.toList();
          for (var element in list) {
            if (element is SpriteAnimationComponent) {
              slideAndFadeOut(element, chickenComponentindex, false);
              chickenComponentindex++;
            }
          }
        }
      } else if (priority == 9) {
        // Right arrow
        numberOfPages = animalsOwnedByUser.length ~/ 6;
        if (animalsOwnedByUser.length % 6 > 0) {
          numberOfPages++;
        }

        numberOfAnimalsOnFinalPage = animalsOwnedByUser.length % 6;
        int currentPage = await getSPInt(currentPageInt);

        currentPage++;
        saveInt(currentPageInt, currentPage);

        if (currentPage < numberOfPages) {
          // right arrow
          int chickenComponentindex = 0;
          var list = game.children.toList();
          for (var element in list) {
            if (element is SpriteAnimationComponent) {
              slideAndFadeOut(element, chickenComponentindex, true);
              chickenComponentindex++;
            }
          }
        } else if (currentPage == numberOfPages) {
          int chickenComponentindex = 0;
          int displayedChickensCounter = 0;
          var list = game.children.toList();
          for (var element in list) {
            if (element is SpriteAnimationComponent) {
              displayedChickensCounter++;
              if (displayedChickensCounter <= numberOfAnimalsOnFinalPage) {
                slideAndFadeOut(element, chickenComponentindex, true);
                chickenComponentindex++;
              } else {
                element.x = 1000;
              }
            }
          }
        }
      }
    }
  }
}
