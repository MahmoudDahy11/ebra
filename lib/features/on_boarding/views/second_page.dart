import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/constant/app_images.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(scafoldColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: pagePadding),
        child: Stack(
          children: [
            Positioned(
              right: MediaQuery.sizeOf(context).width * .75,
              top: MediaQuery.sizeOf(context).height * .07,
              child: GestureDetector(
                onTap: () {
                  controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text("تخطى", style: AppTextStyles.style16RegularSkip),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Image.asset(AppImages.imagesOnboardingOnboarding2),
                // const SizedBox(height: sectionSpace),
                const Text(
                  "مقاسك مضبوط على غرزة",
                  style: AppTextStyles.style36BoldBlack,
                ),
                const SizedBox(height: itemSpace),
                const Text(
                  "سجّل مقاساتك مرة واحدة، وسيب الباقي علينا.",
                  style: AppTextStyles.style16RegularGrey,
                ),
                const SizedBox(height: itemSpace),
                const Text(
                  "كل مرة تطلب، هنوصللك خياطة مفصلة على جسمك بالظبط.",
                  style: AppTextStyles.style16RegularGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
