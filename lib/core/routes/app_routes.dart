import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/core/service/get_it.dart';
import 'package:ebra/core/style/app_text_style.dart';
import 'package:ebra/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:ebra/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:ebra/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:ebra/features/auth/presentation/views/forget_password_view.dart';
import 'package:ebra/features/auth/presentation/views/forget_password_view2.dart';
import 'package:ebra/features/auth/presentation/views/login_view.dart';
import 'package:ebra/features/auth/presentation/views/otp_view.dart';
import 'package:ebra/features/auth/presentation/views/signup_success.dart';
import 'package:ebra/features/auth/presentation/views/signup_view.dart';
import 'package:ebra/features/on_boarding/views/root.dart';
import 'package:ebra/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: root,
        name: 'root',
        builder: (context, state) => const Root(),
      ),
      GoRoute(
        path: loginView,
        name: 'loginView',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: signupView,
        name: 'signupView',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignupCubit>(),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: forgetPasswordView,
        name: 'forgetPasswordView',
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: forgetPasswordView2,
        name: 'forgetPasswordView2',
        builder: (context, state) => const ForgetPasswordView2(),
      ),
      GoRoute(
        path: otpView,
        name: 'otpView',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<OtpCubit>(),
          child: const OtpView(),
        ),
      ),
      GoRoute(
        path: signupSuccess,
        name: 'signupSuccess',
        builder: (context, state) => const RegisterSuccess(),
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('الصفحة غير موجودة', style: AppTextStyles.style36BoldBlack),
      ),
    ),
  );
}
