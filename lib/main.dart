import 'package:flutter/material.dart';
import 'package:todo_app/api/interceptor.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/routes/app_route.dart';

void main() {
  dioInterceptor();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppPage.generateRoute,
    );
  }
}
