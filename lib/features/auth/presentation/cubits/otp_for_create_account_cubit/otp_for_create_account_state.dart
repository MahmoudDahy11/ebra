import 'package:equatable/equatable.dart';

abstract class OtpForCreateAccountState extends Equatable {
  const OtpForCreateAccountState();

  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpForCreateAccountState {}

class OtpLoading extends OtpForCreateAccountState {}

class OtpSent extends OtpForCreateAccountState {}

class OtpVerified extends OtpForCreateAccountState {}

class OtpError extends OtpForCreateAccountState {
  final String message;
  const OtpError(this.message);

  @override
  List<Object?> get props => [message];
}
