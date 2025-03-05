import 'package:flutter/material.dart';
import 'package:todo_app/routes/app_route.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  static void _handleNavigate(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.todo);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(name: 'Go To Todo', method: () =>  _handleNavigate(context)),
          const SizedBox(height: 16),
          CustomButton(name: 'Instagram', method: () =>  Navigator.pushNamed(context, AppRoutes.insta)),
        ],
      ))
    );
  }
}