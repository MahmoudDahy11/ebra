import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomCreateAccountButton extends StatelessWidget {
  const CustomCreateAccountButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(primaryColor)),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            textAlign: TextAlign.center,
            "إنشاء حساب",
            style: AppTextStyles.style20BoldBrown,
          ),
        ),
      ),
    );
  }
}
