import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final icon;
  final VoidCallback method;
  const CustomIconButton({ required this.icon, required this.method });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: method, 
      icon: icon,
    );
  }
}