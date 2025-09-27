import 'package:ebra/core/constant/app_const.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.onChanged,
    required this.check,
  });
  final bool check;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color(primaryColor),
      checkColor: Colors.white,
      side: const BorderSide(color: Colors.grey, width: 2),
      value: check,
      onChanged: onChanged,
    );
  }
}
