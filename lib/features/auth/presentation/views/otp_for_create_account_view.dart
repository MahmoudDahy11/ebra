import 'package:ebra/core/constant/app_const.dart';
import 'package:ebra/features/auth/presentation/views/widgets/custom_opt_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpForCreateAccountView extends StatefulWidget {
  const OtpForCreateAccountView({super.key});

  @override
  State<OtpForCreateAccountView> createState() =>
      _OtpForCreateAccountViewState();
}

class _OtpForCreateAccountViewState extends State<OtpForCreateAccountView> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    return OtpView(
      title: "إنشاء حساب جديد",
      description: "أدخل الرمز التعريفي المرسل الى البريد الإلكتروني",
      uid: uid,
      email: email,
      onVerified: () => context.go(signupSuccess),
    );
  }
}

// import 'dart:async';

// import 'package:ebra/core/constant/app_const.dart';
// import 'package:ebra/core/helper/show_snak_bar.dart';
// import 'package:ebra/core/style/app_text_style.dart';
// import 'package:ebra/core/widgets/custom_button.dart';
// import 'package:ebra/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
// import 'package:ebra/features/auth/presentation/cubits/otp_cubit/otp_state.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'widgets/custom_pin_code_text_field.dart';

// class OtpView extends StatefulWidget {
//   const OtpView({super.key});

//   @override
//   State<OtpView> createState() => _OtpViewState();
// }

// class _OtpViewState extends State<OtpView> {
//   String enteredOtp = "";
//   int secondsLeft = 60;
//   Timer? _timer;

//   void startTimer() {
//     _timer?.cancel();
//     setState(() {
//       secondsLeft = 60;
//     });
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (secondsLeft == 0) {
//         timer.cancel();
//       } else {
//         setState(() {
//           secondsLeft--;
//         });
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     final email = FirebaseAuth.instance.currentUser!.email!;

//     return BlocConsumer<OtpCubit, OtpState>(
//       listener: (context, state) {
//         if (state is OtpVerified) {
//           context.go(signupSuccess);
//         } else if (state is OtpError) {
//           showSnakBar(context, state.message, isError: true);
//         } else if (state is OtpSent) {
//           startTimer();
//         }
//       },
//       builder: (context, state) {
//         return GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Scaffold(
//             backgroundColor: Color(scafoldColor),
//             body: SafeArea(
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: pagePadding),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       IconButton(
//                         alignment: Alignment.centerRight,
//                         padding: EdgeInsets.zero,
//                         onPressed: () {
//                           context.go(signupView);
//                         },
//                         icon: Icon(Icons.arrow_back),
//                       ),
//                       const SizedBox(height: itemSpace),
//                       const Text(
//                         "إنشاء حساب جديد",
//                         style: AppTextStyles.style30BoldBlack,
//                       ),
//                       const SizedBox(height: itemSpace),
//                       const Text(
//                         "أدخل الرمز التعريفي المرسل الى البريد الإلكتروني",
//                         style: AppTextStyles.style16RegularGrey,
//                       ),
//                       const SizedBox(height: sectionSpace),
//                       CustomPinCodeTextField(
//                         onChanged: (value) {
//                           enteredOtp = value;
//                         },
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: secondsLeft == 0
//                                 ? () {
//                                     context.read<OtpCubit>().sendOtp(
//                                       uid: uid,
//                                       email: email,
//                                     );
//                                   }
//                                 : null,
//                             child: Text(
//                               "أعد ارسال الرمز التعريفى ؟",
//                               style: TextStyle(
//                                 color: secondsLeft == 0
//                                     ? Colors.blue
//                                     : Colors.grey,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             "00:${secondsLeft.toString().padLeft(2, '0')}",
//                             style: AppTextStyles.style16RegularGrey,
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       CustomButton(
//                         text: "تأكيد",
//                         onTap: () {
//                           BlocProvider.of<OtpCubit>(
//                             context,
//                           ).verifyOtp(uid: uid, enteredOtp: enteredOtp);
//                         },
//                       ),
//                       const SizedBox(height: sectionSpace - 10),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
