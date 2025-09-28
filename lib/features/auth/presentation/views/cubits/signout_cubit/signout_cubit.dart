import 'package:bloc/bloc.dart';
import 'package:ebra/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signout_state.dart';


/*
 * SignoutCubit class
 * extends Cubit with SignoutState
 * manages the state for user sign-out
 * uses FirebaseAuthRepo for authentication operations
 * emits loading, success, and failure states based on the sign-out process
 */
class SignoutCubit extends Cubit<SignoutState> {
  SignoutCubit(this._firebaseAuthrepo) : super(SignOutInitial());

  final FirebaseAuthRepo _firebaseAuthrepo;

  Future<void> signOut() async {
    emit(SignOutLoading());
    final result = await _firebaseAuthrepo.signOut();
    result.fold(
      (failure) => emit(SignOutFailure(errMessage: failure.errMessage)),
      (_) => emit(SignOutSuccess()),
    );
  }
}
