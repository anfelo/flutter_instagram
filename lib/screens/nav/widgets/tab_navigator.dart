import 'package:flutter/material.dart';
import 'package:flutter_instagram/config/custom_router.dart';
import 'package:flutter_instagram/enums/enums.dart';
import 'package:flutter_instagram/screens/screens.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders[initialRoute](context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        return FeedScreen();
        break;
      case BottomNavItem.search:
        return SearchScreen();
        break;
      case BottomNavItem.create:
        return CreatePostScreen();
        break;
      case BottomNavItem.notifications:
        return NotificationsScreen();
        break;
      case BottomNavItem.profile:
        return ProfileScreen();
        break;
      default:
        return Scaffold();
    }
  }
}
