import 'package:bloc/bloc.dart';
import 'package:ebra/features/auth/domain/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._firebaseAuthrepo) : super(ForgetPasswordInitial());
  final FirebaseAuthRepo _firebaseAuthrepo;

  Future<void> resetPassword(String newPassword) async {
    emit(ForgetPasswordLoading());
    final result = await _firebaseAuthrepo.forgetPassword(
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(ForgetPasswordFailure(errMessage: failure.errMessage)),
      (_) => emit(ForgetPasswordSuccess(message: 'تم تغيير كلمة المرور بنجاح')),
    );
  }
}
