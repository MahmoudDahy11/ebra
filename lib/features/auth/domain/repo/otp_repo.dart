abstract class OtpRepository {
  Future<void> sendOtp({required String uid, required String email});
  Future<bool> verifyOtp({required String uid, required String enteredOtp});
  Future<bool> canResendOtp({required String uid});
}
