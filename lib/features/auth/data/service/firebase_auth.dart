import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebra/core/error/custom_excption.dart';
import 'package:ebra/features/auth/data/service/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'otp_service.dart';

/*
 * FirebaseService class
 * handles user authentication with Firebase
 * supports email/password, Google, and Facebook sign-in methods
 * rest the password 
 * manages user data in Firestore
 * saves user session data locally using LocalStorageService
 * throws CustomException on errors with appropriate messages
 */
class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user == null) {
        throw CustomException(errMessage: 'User creation failed.');
      }

      await user.updateDisplayName(name);
      await user.reload();
      log("✅ User created: ${user.email}");

      // await user.sendEmailVerification();
      // log("📩 Verification email sent to: ${user.email}");

      await LocalStorageService.saveUserData(
        uid: user.uid,
        email: user.email!,
        name: name,
      );

      final otpService = OtpService();
      final otp = otpService.generateOtp();
      await otpService.saveOtp(user.uid, otp);
      await otpService.sendOtpToEmail(user.email!, otp);
      log("🔑 OTP sent to ${user.email}");

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw CustomException(
            errMessage: 'The password provided is too weak.',
          );
        case 'email-already-in-use':
          throw CustomException(
            errMessage: 'The account already exists for that email.',
          );
        case 'invalid-email':
          throw CustomException(errMessage: 'The email address is invalid.');
        case 'operation-not-allowed':
          throw CustomException(
            errMessage: 'Email/Password accounts are not enabled.',
          );
        default:
          throw CustomException(
            errMessage: e.message ?? 'Unknown FirebaseAuth error.',
          );
      }
    } catch (e) {
      throw CustomException(errMessage: e.toString());
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw CustomException(errMessage: 'Sign in failed. Please try again.');
      }

      await user.reload();

      final otpDoc = await firestore.collection('otps').doc(user.uid).get();
      if (!otpDoc.exists || otpDoc.data()?['verified'] != true) {
        throw CustomException(
          errMessage:
              'Please verify your email with the OTP before logging in.',
        );
      }

      await firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': user.displayName ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await LocalStorageService.saveUserData(
        uid: user.uid,
        email: user.email!,
        name: user.displayName,
      );

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw CustomException(errMessage: 'The email address is invalid.');
        case 'user-disabled':
          throw CustomException(
            errMessage: 'This user account has been disabled.',
          );
        case 'user-not-found':
          throw CustomException(errMessage: 'No user found for that email.');
        case 'wrong-password':
          throw CustomException(errMessage: 'Wrong password provided.');
        default:
          throw CustomException(
            errMessage: e.message ?? 'Unknown FirebaseAuth error.',
          );
      }
    } catch (e) {
      throw CustomException(errMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();

      await LocalStorageService.clearUserData();
    } catch (e) {
      throw CustomException(errMessage: 'Sign out failed: ${e.toString()}');
    }
  }

  Future<void> forgetPassword({required String newPassword}) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw CustomException(errMessage: 'User is not authenticated.');
      }

      final otpService = OtpService();
      final otp = otpService.generateOtp();
      await otpService.saveOtp(user.uid, otp);
      await otpService.sendOtpToEmail(user.email!, otp);
      log("🔑 OTP sent to ${user.email}");

      // update password
      await user.updatePassword(newPassword);
    } catch (e) {
      throw CustomException(errMessage: e.toString());
    }
  }
}
