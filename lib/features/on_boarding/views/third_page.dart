import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/constant/app_images.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key, required this.controller});
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
                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (!context.mounted) return;
                    context.go(loginView);
                  });
                },

                child: Text("تخطى", style: AppTextStyles.style16RegularSkip),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Image.asset(AppImages.imagesOnboardingOnboarding3),
                // const SizedBox(height: sectionSpace),
                const Text(
                  " اطلب تفصيلك في دقائق",
                  style: AppTextStyles.style36BoldBlack,
                ),
                const SizedBox(height: itemSpace),
                const Text(
                  "إبرة مش بس خياطة، ده فن.",
                  style: AppTextStyles.style16RegularGrey,
                ),
                const SizedBox(height: itemSpace),
                const Text(
                  "كل قطعة بتتعمل بإيدين محترفين وخامات مختارة بعناية",
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
