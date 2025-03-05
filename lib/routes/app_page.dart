import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/routes/app_route.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/insta_screen.dart';
import 'package:todo_app/screens/todo_screen.dart';

class AppPage {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    AppRoutes.home: (context) => HomeScreen(),
    AppRoutes.todo: (context) => TodoScreen(),
    AppRoutes.insta : (context) => InstaPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final builder = _routes[settings.name];
    if(builder != null) {
      return MaterialPageRoute(builder: builder);
    }
    return _errorRoute(settings.name);
  }

  static Route<dynamic> _errorRoute(routename) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Text('No Matching Route ${routename}'),
      )
    );
  }
}
