import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class OtpService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Duration otpValidity = const Duration(minutes: 5);

  final Duration resendCooldown = const Duration(seconds: 60);

  String generateOtp() {
    final rand = Random.secure();
    return (1000 + rand.nextInt(9000)).toString();
  }

  Future<void> saveOtp(String uid, String otp) async {
    await _firestore.collection('otps').doc(uid).set({
      'otp': otp,
      'createdAt': FieldValue.serverTimestamp(),
      'expiresAt': DateTime.now().add(otpValidity),
      'canResendAt': DateTime.now().add(resendCooldown),
    });
  }

  Future<bool> verifyOtp(String uid, String enteredOtp) async {
    final snap = await _firestore.collection('otps').doc(uid).get();
    if (!snap.exists) return false;

    final data = snap.data()!;
    final otp = data['otp'];
    final expiresAt = (data['expiresAt'] as Timestamp).toDate();

    if (DateTime.now().isAfter(expiresAt)) {
      return false;
    }

    final isValid = otp == enteredOtp;

    if (isValid) {
      await _firestore.collection('otps').doc(uid).update({
        'verified': true,
        'verifiedAt': FieldValue.serverTimestamp(),
      });
    }

    return isValid;
  }

  Future<bool> canResendOtp(String uid) async {
    final snap = await _firestore.collection('otps').doc(uid).get();
    if (!snap.exists) return true;

    final data = snap.data()!;
    final canResendAt = (data['canResendAt'] as Timestamp).toDate();

    return DateTime.now().isAfter(canResendAt);
  }

  Future<void> sendOtpToEmail(String email, String otp) async {
    final smtpServer = gmail('dahym2028@gmail.com', 'gakr kkld eebr awww');

    final message = Message()
      ..from = const Address('dahym2028@gmail.com', 'Ebra App')
      ..recipients.add(email)
      ..subject = 'Your OTP Code'
      ..text = 'رمز التحقق الخاص بك هو: $otp (صالح لمدة 5 دقائق)';

    try {
      await send(message, smtpServer);
      if (kDebugMode) {
        print('📩 OTP sent to $email');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to send OTP: $e');
      }
      rethrow;
    }
  }
}
