import 'package:ebra/features/auth/domain/repo/otp_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_for_create_account_state.dart';

class OtpForCreateAccountCubit extends Cubit<OtpForCreateAccountState> {
  final OtpRepository otpRepository;

  OtpForCreateAccountCubit(this.otpRepository) : super(OtpInitial());

  Future<void> sendOtp({required String uid, required String email}) async {
    emit(OtpLoading());
    try {
      await otpRepository.sendOtp(uid: uid, email: email);
      emit(OtpSent());
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }

  Future<void> verifyOtp({
    required String uid,
    required String enteredOtp,
  }) async {
    emit(OtpLoading());
    try {
      final valid = await otpRepository.verifyOtp(
        uid: uid,
        enteredOtp: enteredOtp,
      );
      if (valid) {
        emit(OtpVerified());
      } else {
        emit(const OtpError("رمز التحقق غير صحيح أو منتهي الصلاحية"));
      }
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }

  Future<bool> canResendOtp({required String uid}) async {
    return await otpRepository.canResendOtp(uid: uid);
  }
}
