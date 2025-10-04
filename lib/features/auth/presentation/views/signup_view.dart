import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/helper/awesome_dialog.dart';
import 'package:ebra/core/helper/show_snak_bar.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/core/widgets/custom_button.dart';
import 'package:ebra/core/widgets/custom_text_field.dart';
import 'package:ebra/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool obscureText = true;
  String? email, password, fullName, newPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
        } else if (state is SignupFailure) {
          showDialogMessage(context, desc: state.errMessage);
        } else if (state is SignupSuccess) {
          showSnakBar(context, "Email created successfully");
          context.go(otpForCreateAccountView);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ModalProgressHUD(
              inAsyncCall: state is SignupLoading,
              child: Scaffold(
                backgroundColor: Color(scafoldColor),
                body: SafeArea(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: pagePadding,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
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
                              "إنشاء حساب جديد",
                              style: AppTextStyles.style30BoldBlack,
                            ),
                            const SizedBox(height: itemSpace),
                            const Text(
                              "أدخل البيانات المطلوبة بالاسفل",
                              style: AppTextStyles.style16RegularGrey,
                            ),
                            const SizedBox(height: sectionSpace),
                            const Text(
                              "الأسم بالكامل",
                              style: AppTextStyles.style20BoldBlack,
                            ),
                            const SizedBox(height: itemSpace),
                            CustomTextField(
                              hintText: "ادخل الاسم بالكامل",
                              onSaved: (value) {
                                fullName = value;
                              },
                            ),
                            const SizedBox(height: sectionSpace - 10),
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
                              "أدخل كلمة المرور ",
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
                            const Text(
                              "كلمة المرور مرة اخري",
                              style: AppTextStyles.style20BoldBlack,
                            ),
                            const SizedBox(height: itemSpace),
                            CustomTextField(
                              onSaved: (value) {
                                newPassword = value;
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
                            const SizedBox(height: sectionSpace * 3),
                            CustomButton(
                              text: "إنشاء حساب جديد",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  if (password != newPassword) {
                                    showSnakBar(
                                      context,
                                      "كلمة المرور غير متطابقة",
                                      isError: true,
                                    );
                                    return;
                                  }
                                  BlocProvider.of<SignupCubit>(
                                    context,
                                  ).createUserWithEmailAndPassword(
                                    email: email!,
                                    password: password!,
                                    name: fullName!,
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: sectionSpace - 10),
                          ],
                        ),
                      ),
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
