part of 'signout_cubit.dart';


/*
 * SignoutState class
 * base state class for SignoutCubit
 * has subclasses for initial, loading, success, and failure states
 */
@immutable
sealed class SignoutState {}

class SignOutInitial extends SignoutState {}

class SignOutLoading extends SignoutState {}

class SignOutSuccess extends SignoutState {}

class SignOutFailure extends SignoutState {
  final String errMessage;
  SignOutFailure({required this.errMessage});
}
