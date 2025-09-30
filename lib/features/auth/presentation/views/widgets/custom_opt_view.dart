import 'dart:async';
import 'package:ebra/features/auth/presentation/views/widgets/custom_pin_code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/helper/show_snak_bar.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/core/widgets/custom_button.dart';
import 'package:ebra/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:ebra/features/auth/presentation/cubits/otp_cubit/otp_state.dart';
import 'package:go_router/go_router.dart';

class OtpView extends StatefulWidget {
  final String title;
  final String description;
  final String uid;
  final String email;
  final VoidCallback onVerified; // هتتنده بعد نجاح التحقق
  final VoidCallback? onBack; // لو عايز تتحكم في زرار الرجوع

  const OtpView({
    super.key,
    required this.title,
    required this.description,
    required this.uid,
    required this.email,
    required this.onVerified,
    this.onBack,
  });

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String enteredOtp = "";
  int secondsLeft = 60;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    setState(() {
      secondsLeft = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() {
          secondsLeft--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          widget.onVerified();
        } else if (state is OtpError) {
          showSnakBar(context, state.message, isError: true);
        } else if (state is OtpSent) {
          startTimer();
        }
      },
      builder: (context, state) {
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
                          if (widget.onBack != null) {
                            widget.onBack!();
                          } else {
                            context.go(signupView);
                          }
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(height: itemSpace),
                      Text(widget.title, style: AppTextStyles.style30BoldBlack),
                      const SizedBox(height: itemSpace),
                      Text(
                        widget.description,
                        style: AppTextStyles.style16RegularGrey,
                      ),
                      const SizedBox(height: sectionSpace),
                      CustomPinCodeTextField(
                        onChanged: (value) {
                          enteredOtp = value;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: secondsLeft == 0
                                ? () {
                                    context.read<OtpCubit>().sendOtp(
                                      uid: widget.uid,
                                      email: widget.email,
                                    );
                                  }
                                : null,
                            child: Text(
                              "أعد ارسال الرمز ؟",
                              style: TextStyle(
                                color: secondsLeft == 0
                                    ? Color(primaryColor)
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            "00:${secondsLeft.toString().padLeft(2, '0')}",
                            style: AppTextStyles.style16RegularGrey,
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        text: "تأكيد",
                        onTap: () {
                          context.read<OtpCubit>().verifyOtp(
                            uid: widget.uid,
                            enteredOtp: enteredOtp,
                          );
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
      },
    );
  }
}
