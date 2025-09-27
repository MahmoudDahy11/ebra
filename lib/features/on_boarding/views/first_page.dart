import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/constant/app_images.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(scafoldColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: onboardingHieght),
            Image.asset(AppImages.imagesOnboardingOnboarding1),
            const SizedBox(height: sectionSpace),
            Text(" تصميمك… على مزاجك", style: AppTextStyles.style36BoldBlack),
            const SizedBox(height: itemSpace),
            const Text(
              "عايز بدلة رسمية، جلابية، فستان أو حتى تعديل؟",
              style: AppTextStyles.style16RegularGrey,
            ),
            const SizedBox(height: itemSpace),
            const Text(
              "إبرة بتقدملك كتالوج متنوع، أو تقدر ترفع صورتك الخاصة ونفصلها مخصوص ليك",
              style: AppTextStyles.style16RegularGrey,
            ),
          ],
        ),
      ),
    );
  }
}
