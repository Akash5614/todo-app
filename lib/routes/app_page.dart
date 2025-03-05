import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/routes/app_route.dart';
import 'package:todo_app/views/screens/getx_todo_screen.dart';
import 'package:todo_app/views/screens/home_screen.dart';
import 'package:todo_app/views/screens/insta_screen.dart';
import 'package:todo_app/views/screens/todo_screen.dart';

class AppPage {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    AppRoutes.home: (context) => HomeScreen(),
    AppRoutes.todo: (context) => TodoScreen(),
    AppRoutes.insta : (context) => InstaPage(),
    AppRoutes.getxTodo : (context) => GetxTodoPage(),
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
        body: Center(
          child: Text('No Matching Route ${routename}')
        ),
      )
    );
  }
}
