import 'package:bloc/bloc.dart';
import 'package:ebra/features/auth/domain/entity/user_entity.dart';
import 'package:ebra/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';


/*
 * SignupCubit class
 * extends Cubit with SignupState
 * manages the state for user sign-up
 * uses FirebaseAuthRepo for authentication operations
 * emits loading, success, and failure states based on the sign-up process
 */
class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._firebaseAuthrepo) : super(SignupInitial());
  final FirebaseAuthRepo _firebaseAuthrepo;

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignupLoading());
    final result = await _firebaseAuthrepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(SignupFailure(errMessage: failure.errMessage)),
      (user) => emit(SignupSuccess(user)),
    );
  }
}
