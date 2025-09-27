import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/features/on_boarding/views/first_page.dart';
import 'package:ebra/features/on_boarding/views/second_page.dart';
import 'package:ebra/features/on_boarding/views/third_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:go_router/go_router.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  PageController controller = PageController();
  List<Widget> screens = [];
  int currentIndex = 0;
  double pageValue = 0.0;

  @override
  void initState() {
    screens.addAll([
      FirstPage(controller: controller),
      SecondPage(controller: controller),
      ThirdPage(controller: controller),
    ]);
    controller.addListener(() {
      setState(() {
        pageValue = controller.page ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: PageView(
              controller: controller,
              children: screens,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: pageValue * (pi / 2),
                      child: CustomPaint(
                        size: const Size(90, 90),
                        painter: ArcAroundCirclePainter(pageValue),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.page! < screens.length - 1) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          context.go(loginView);
                        }
                      },
                      child: Container(
                        width: 74,
                        height: 74,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC79C45),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArcAroundCirclePainter extends CustomPainter {
  final double progress;

  ArcAroundCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFC79C44)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    double sweepAngle = (pi / 2) + (progress * (pi / 2));

    canvas.drawArc(rect, -pi / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant ArcAroundCirclePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
