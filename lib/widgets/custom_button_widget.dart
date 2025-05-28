import 'package:flutter/material.dart';
import 'package:studyplanner/constants/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTapFunction;
  const CustomButtonWidget({
    super.key,
    required this.buttonText,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(primaryColor)),
      onPressed: onTapFunction,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
