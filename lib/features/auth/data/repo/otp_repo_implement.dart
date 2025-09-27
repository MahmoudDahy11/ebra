import 'package:ebra/features/auth/data/service/otp_service.dart';
import 'package:ebra/features/auth/domain/repo/otp_repo.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpService otpService;

  OtpRepositoryImpl({required this.otpService});

  @override
  Future<void> sendOtp({required String uid, required String email}) async {
    final otp = otpService.generateOtp();
    await otpService.saveOtp(uid, otp);
    await otpService.sendOtpToEmail(email, otp);
  }

  @override
  Future<bool> verifyOtp({
    required String uid,
    required String enteredOtp,
  }) async {
    return await otpService.verifyOtp(uid, enteredOtp);
  }

  @override
  Future<bool> canResendOtp({required String uid}) async {
    return await otpService.canResendOtp(uid);
  }
}
