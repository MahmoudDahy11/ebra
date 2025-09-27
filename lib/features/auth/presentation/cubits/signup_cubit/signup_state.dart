part of 'signup_cubit.dart';


/*
 * SignupState class
 * base state class for SignupCubit
 * has subclasses for initial, loading, success, and failure states
 */
@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupFailure extends SignupState {
  final String errMessage;

  SignupFailure({required this.errMessage});
}

final class SignupSuccess extends SignupState {
   final UserEntity user;
  SignupSuccess(this.user);
}
