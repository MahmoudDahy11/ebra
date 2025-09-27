import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/core/widgets/custom_button.dart';
import 'package:ebra/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(scafoldColor),
        body: SafeArea(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: pagePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.go(loginView);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  const SizedBox(height: itemSpace),
                  const Text(
                    "نسيت كلمة المرور؟",
                    style: AppTextStyles.style30BoldBlack,
                  ),
                  const SizedBox(height: itemSpace),
                  const Text(
                    "أدخل بريدك الالكترونى",
                    style: AppTextStyles.style16RegularGrey,
                  ),
                  const SizedBox(height: sectionSpace),
                  const Text(
                    "البريد الالكترونى",
                    style: AppTextStyles.style20BoldBlack,
                  ),
                  const SizedBox(height: itemSpace),
                  CustomTextField(hintText: "البريد الالكترونى"),
                  const Spacer(),
                  CustomButton(
                    text: "التالي",
                    onTap: () {
                      context.go(forgetPasswordView2);
                    },
                  ),
                  SizedBox(height: sectionSpace - 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
