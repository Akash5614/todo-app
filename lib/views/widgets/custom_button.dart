import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback method;
  const CustomButton({ required this.name, required this.method });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: method, 
      child: Text(name)
    );
  }
}