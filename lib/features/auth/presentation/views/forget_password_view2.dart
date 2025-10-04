import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/helper/awesome_dialog.dart';
import 'package:ebra/core/helper/show_snak_bar.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/core/widgets/custom_button.dart';
import 'package:ebra/core/widgets/custom_text_field.dart';
import 'package:ebra/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordView2 extends StatefulWidget {
  const ForgetPasswordView2({super.key});

  @override
  State<ForgetPasswordView2> createState() => _ForgetPasswordView2State();
}

class _ForgetPasswordView2State extends State<ForgetPasswordView2> {
  bool obscureText = true;
  String? password, confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
        } else if (state is ForgetPasswordFailure) {
          showDialogMessage(context, desc: state.errMessage);
        } else if (state is ForgetPasswordSuccess) {
          showSnakBar(context, "Passwrd changed successfully");
          context.go(loginView);
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
                        const SizedBox(height: sectionSpace),
                        const Text(
                          "كلمة المرور مرة أخرى",
                          style: AppTextStyles.style20BoldBlack,
                        ),
                        const SizedBox(height: itemSpace),
                        CustomTextField(
                          onSaved: (value) {
                            confirmPassword = value;
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
                        const Spacer(),
                        CustomButton(
                          text: "حفظ",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              if (password != confirmPassword) {
                                showSnakBar(
                                  context,
                                  "كلمة المرور غير متطابقة",
                                  isError: true,
                                );
                                return;
                              } else if (password == confirmPassword) {
                                context
                                    .read<ForgetPasswordCubit>()
                                    .resetPassword(password!);
                              }
                            }
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
