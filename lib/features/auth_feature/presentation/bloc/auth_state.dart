part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object> get props => [];
}
class SignInSuccessState extends AuthState{
  final String verificationId;
  final String phoneNumber;
  final String message;
  SignInSuccessState( {required this.phoneNumber, required this.message,required this.verificationId});
  @override
  List<Object> get props => [verificationId];
}
class VerifyOtpSuccessState extends AuthState{
  final String message;

  VerifyOtpSuccessState({ required this.message});
  @override
  List<Object> get props => [];
}

class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState({required this.message});
  @override
  List<Object> get props => [message];
}
