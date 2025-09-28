part of 'login_cubit.dart';


/*
 * LoginState class
 * base state class for LoginCubit
 * has subclasses for initial, loading, success, and failure states
 */
@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginFailure extends LoginState {
  final String errMessage;

  LoginFailure({required this.errMessage});
}

final class LoginSuccess extends LoginState {
  final UserEntity userEntity;
  LoginSuccess(this.userEntity);
}
