import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/constant/app_images.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // context.go(otpForCreateAccountView);
                      // showSnakBar(context, "أهلا بك في ابره");
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  const SizedBox(height: itemSpace),
                  Image.asset(AppImages.imagesPerson),
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text(
                      "تم إنشاء الحساب بنجاح",
                      style: AppTextStyles.style20BoldBlack,
                    ),
                  ),
                  const SizedBox(height: itemSpace),
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text(
                      "يمكنك تصفح  التطبيق الان مع اخر العروض والخصومات",
                      style: AppTextStyles.style16RegularGrey,
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: "تم",
                    onTap: () {
                      context.go(loginView);
                    },
                  ),
                  const SizedBox(height: sectionSpace - 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
