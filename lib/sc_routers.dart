import 'package:flutter/material.dart';

enum SCRoutersDirection { rightToLeft, bottomToTop, material }

class SCRouters {
  final Map<String, WidgetBuilder>? routes;

  SCRouters({this.routes});

  static Future push(BuildContext context, Widget widget,
      {String? routeName,
      SCRoutersDirection direction = SCRoutersDirection.material}) async {
    switch (direction) {
      case SCRoutersDirection.rightToLeft:
        return Navigator.push(
          context,
          RightToLeftRouter(child: widget, routeName: routeName),
        );
      case SCRoutersDirection.bottomToTop:
        return Navigator.push(
          context,
          BottomToTopRouter(child: widget, routeName: routeName),
        );
      default:
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => widget,
            settings: RouteSettings(name: routeName),
          ),
        );
    }
  }

  static Future pop(BuildContext context) async {
    return Navigator.of(context).maybePop();
  }

  static Future popUtil(BuildContext context, String routeName) async {
    return Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  static Future pushReplace(BuildContext context, String routeName) async {
    return Navigator.of(context).pushReplacementNamed(routeName);
  }
}

class RightToLeftRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int duration;
  final Curve curve;
  final String? routeName;

  RightToLeftRouter({
    required this.child,
    this.duration = 500,
    this.curve = Curves.fastOutSlowIn,
    this.routeName,
  }) : super(
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder: (ctx, a1, a2) {
            return child;
          },
          settings: RouteSettings(name: routeName),
          transitionsBuilder: (ctx, a1, a2, Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(
                CurvedAnimation(parent: a1, curve: curve),
              ),
              child: child,
            );
          },
        );
}

class BottomToTopRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int duration;
  final Curve curve;
  final String? routeName;

  BottomToTopRouter({
    required this.child,
    this.duration = 500,
    this.curve = Curves.fastOutSlowIn,
    this.routeName,
  }) : super(
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder: (ctx, a1, a2) {
            return child;
          },
          settings: RouteSettings(name: routeName),
          transitionsBuilder: (ctx, a1, a2, Widget child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              ).animate(
                CurvedAnimation(parent: a1, curve: curve),
              ),
              child: child,
            );
          },
        );
}
