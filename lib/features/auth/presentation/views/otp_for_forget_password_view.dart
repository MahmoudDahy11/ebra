import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/features/auth/presentation/views/widgets/custom_opt_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpForForgetPasswordView extends StatefulWidget {
  const OtpForForgetPasswordView({super.key});

  @override
  State<OtpForForgetPasswordView> createState() =>
      _OtpForForgetPasswordViewState();
}

class _OtpForForgetPasswordViewState extends State<OtpForForgetPasswordView> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    return OtpView(
      title: "نسيت كلمة المرور",
      description: "أدخل الرمز التعريفي المرسل الى البريد الإلكتروني",
      uid: uid,
      email: email,
      onVerified: () => context.go(forgetPasswordView2),
    );
  }
}
