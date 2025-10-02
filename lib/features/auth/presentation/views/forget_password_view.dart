import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/helper/show_snak_bar.dart';

import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/core/widgets/custom_button.dart';
import 'package:ebra/core/widgets/custom_text_field.dart';
import 'package:ebra/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:ebra/features/auth/presentation/cubits/otp_cubit/otp_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpSent) {
          context.push(otpForForgetPasswordView);
        } else if (state is OtpError) {
          showSnakBar(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: Color(scafoldColor),
              body: SafeArea(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: pagePadding,
                    ),
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
                        CustomTextField(
                          hintText: "البريد الالكترونى",
                          onSaved: (value) {
                            email = value;
                          },
                        ),
                        const Spacer(),
                        CustomButton(
                          text: "التالي",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                            }
                            final enteredEmail = email.toString().trim();
                            final user = auth.currentUser;

                            if (user == null) {
                              showSnakBar(context, "أنت غير مسجل دخول");
                              return;
                            }

                            if (enteredEmail != user.email) {
                              showSnakBar(
                                context,
                                "الإيميل غير مطابق لأي ايميل موجود",
                              );
                              return;
                            }

                            context.read<OtpCubit>().sendOtp(
                              uid: user.uid,
                              email: enteredEmail,
                            );
                          },
                        ),
                        SizedBox(height: sectionSpace - 10),
                      ],
                    ),
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
