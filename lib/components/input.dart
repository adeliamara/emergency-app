import 'package:flutter/material.dart';

// CustomTextField Class Definition
class Input extends StatelessWidget {
  final String hintText; // Placeholder text
  final Color fillColor; // Background color of the TextField
  final Color textColor; // Text color of the input text
  final double borderRadius; // Border radius for the TextField
  final Color borderColor; // Border color for the TextField
  final TextEditingController?
      controller; // Controller for managing the input text
  final TextInputType keyboardType; // Keyboard type for input
  final bool obscureText; // For password fields
  final int maxLines; // Number of lines for multi-line input
  final IconData? prefixIcon; // Optional prefix icon
  final String labelText;

  // Constructor to initialize the properties
  const Input({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.fillColor = const Color(0xffF9FBFF),
    this.textColor = const Color(0xffBABDC8),
    this.borderRadius = 25.0,
    this.borderColor = Colors.grey,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      // style: TextStyle(
      //   color: textColor, // Sets the input text color
      // ),
      decoration: InputDecoration(
          // labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: textColor, // Hint text color
          ),
          labelStyle: TextStyle(color: textColor),
          filled: true,
          fillColor: fillColor, // Background color of the TextField
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: textColor)
              : null, // Optional prefix icon
          border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(borderRadius), // Rounded corners
              borderSide: BorderSide.none)),
    );
  }
}
