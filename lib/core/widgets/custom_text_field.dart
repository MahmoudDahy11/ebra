import 'package:ebra/core/constant/app_const.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    this.suffix,
    this.onSaved,
    this.obscureText = false,
  });
  final String hintText;
  final Widget? suffix;
  Function(String?)? onSaved;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value!.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(scafoldColor),
        suffixIcon: suffix,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Color(0xffC5C0BA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Color(0xffC5C0BA), width: 2),
        ),
      ),
    );
  }
}
