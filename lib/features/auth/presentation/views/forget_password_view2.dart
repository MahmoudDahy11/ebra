import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/core/widgets/custom_button.dart';
import 'package:ebra/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordView2 extends StatefulWidget {
  const ForgetPasswordView2({super.key});

  @override
  State<ForgetPasswordView2> createState() => _ForgetPasswordView2State();
}

class _ForgetPasswordView2State extends State<ForgetPasswordView2> {
  bool obscureText = false;
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
                      context.go(forgetPasswordView);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  const SizedBox(height: itemSpace),
                  const Text(
                    "إنشاء كلمه مرور جديدة",
                    style: AppTextStyles.style30BoldBlack,
                  ),
                  const SizedBox(height: itemSpace),
                  const Text(
                    "أدخل كلمة المرور",
                    style: AppTextStyles.style16RegularGrey,
                  ),
                  const SizedBox(height: sectionSpace),
                  const Text(
                    "كلمة المرور الجديدة",
                    style: AppTextStyles.style20BoldBlack,
                  ),
                  const SizedBox(height: itemSpace),
                  CustomTextField(
                    hintText: "كلمة المرور",
                    obscureText: obscureText,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText == false
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: Color(greyColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: sectionSpace),
                  const Text(
                    "كلمة المرور مرة أخرى",
                    style: AppTextStyles.style20BoldBlack,
                  ),
                  const SizedBox(height: itemSpace),
                  CustomTextField(
                    hintText: "كلمة المرور",
                    obscureText: obscureText,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText == false
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: Color(greyColor),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(text: "حفظ", onTap: () {}),
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
