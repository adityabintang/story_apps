import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:storys_apps/data/model/list_story.dart';
import 'package:storys_apps/data/preference.dart';
import 'package:storys_apps/pages/auth/login_screen.dart';
import 'package:storys_apps/pages/home/add_story_page.dart';
import 'package:storys_apps/pages/home/details_stories.dart';
import 'package:storys_apps/pages/home/list_story_page.dart';
import 'package:storys_apps/pages/home/map_page.dart';
import 'package:storys_apps/splash.dart';
import 'package:storys_apps/utils/constant.dart';

import '../pages/auth/register_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await getStorageBoolean(loginData);
    notifyListeners();
  }

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool addAction = false;
  bool addLocation = false;
  ListStory? storiesId;
  double? latitude;
  double? longitude;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        addLocation = false;
        addAction = false;
        isRegister = false;
        storiesId = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }

  List<Page> get _splashStack => [
        const MaterialPage(
          key: ValueKey("SplashScreen"),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterScreen(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("ListStoryPage"),
          child: ListStoryPage(
            onTapped: (ListStory idStories) {
              storiesId = idStories;
              if (storiesId != null) {
                debugPrint('id detail ${storiesId?.id}');
              }
              notifyListeners();
            },
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
            onPressed: () {
              addAction = true;
              notifyListeners();
            },
          ),
        ),
        if (storiesId != null)
          MaterialPage(
            key: ValueKey(storiesId?.id),
            child: DetailStories(
              idStories: storiesId,
            ),
          ),
        if (addAction == true)
          MaterialPage(
            key: const ValueKey('AddStoryPage'),
            child: AddStoryPage(
              latitude: latitude ?? 0.0,
              longitude: longitude ?? 0.0,
              onAddAction: () {
                addAction = false;
                notifyListeners();
              },
              onMap: () {
                addLocation = true;
                notifyListeners();
              },
            ),
          ),
        if (addLocation == true)
          MaterialPage(
            key: const ValueKey('AddLocationPage'),
            child: MapScreen(
              onBackAddStory: (LatLng latLang) {
                addLocation = false;
                latitude = latLang.latitude;
                longitude = latLang.longitude;
                notifyListeners();
              },
            ),
          )
      ];
}
