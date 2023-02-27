part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String phoneNumber;

  SignInEvent({required this.phoneNumber});
  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];

}

class verifyOTPEvent extends AuthEvent {
  final String OTP;
  final String verifyId;
  verifyOTPEvent( {required this.OTP,required this.verifyId});

  @override
  // TODO: implement props
  List<Object?> get props => [OTP,verifyId];

}
class OTPSentEvent extends AuthEvent {

  final String verifyId;
  final String phoneNumber;
   OTPSentEvent(  {required this.phoneNumber,required this.verifyId});

  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber,verifyId];}
class AuthErrorEvent extends AuthEvent {

  final String message;
  AuthErrorEvent( {required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];}

