import 'dart:developer';

import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/constant/app_images.dart';
import 'package:ebra/core/helper/awesome_dialog.dart';
import 'package:ebra/core/helper/show_snak_bar.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/core/widgets/custom_button.dart';
import 'package:ebra/core/widgets/custom_text_field.dart';
import 'package:ebra/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_check_box.dart';
import '../widgets/custom_create_account.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool obscureText = false;
  bool check = false;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
        } else if (state is LoginFailure) {
          showDialogMessage(context, desc: state.errMessage);
          log(state.errMessage);
        } else if (state is LoginSuccess) {
          showSnakBar(context, "Login Success");
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: Color(scafoldColor),
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: pagePadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(AppImages.imagesOnboardebra),
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
                        const SizedBox(height: sectionSpace - 10),
                        const Text(
                          "كلمه المرور",
                          style: AppTextStyles.style20BoldBlack,
                        ),
                        const SizedBox(height: itemSpace),
                        CustomTextField(
                          onSaved: (value) {
                            password = value;
                          },
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
                        const SizedBox(height: sectionSpace - 10),
                        SizedBox(
                          child: Row(
                            children: [
                              CustomCheckBox(
                                onChanged: (value) {
                                  setState(() {
                                    check = value ?? false;
                                  });
                                },
                                check: check,
                              ),

                              const Text(
                                "تذاكرنى",
                                style: AppTextStyles.style16BoldBlack,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  context.go(forgetPasswordView);
                                },
                                child: const Text(
                                  "نسيت كلمه المرور",
                                  style: AppTextStyles.style16BoldBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: sectionSpace - 10),
                        CustomButton(
                          text: 'تسجيل الدخول',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              BlocProvider.of<LoginCubit>(
                                context,
                              ).signInWithEmailAndPassword(
                                email: email!,
                                password: password!,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: itemSpace),
                        CustomCreateAccountButton(
                          onTap: () {
                            context.go(signupView);
                          },
                        ),
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
