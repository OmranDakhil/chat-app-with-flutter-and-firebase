import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:text_me/core/networks/network_info.dart';
import 'package:text_me/core/strings/done_messages.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/usecases/otp_verify.dart';
import '../../domain/usecases/sign_in_with_phone_number.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final OTPVerifyUsecase otpVerify;
  final SignInWithPhoneNumberUsecase signInWithPhoneNumber;

  AuthBloc({required this.otpVerify, required this.signInWithPhoneNumber})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is SignInEvent) {
        emit(LoadingState());
        if (await InternetConnectionChecker().hasConnection) {
          await FirebaseAuth.instance.verifyPhoneNumber(
              timeout: const Duration(seconds: 60),
              phoneNumber: event.phoneNumber,
              verificationCompleted: (PhoneAuthCredential credential) async {},
              verificationFailed: (FirebaseAuthException e) async {
                // if (e.code == 'invalid-phone-number') {
                print(e.message);
                add(AuthErrorEvent(message: e.message!));
                // }
              },
              codeSent: (verificationId, resendingToken) async {
                add(OTPSentEvent(
                    verifyId: verificationId, phoneNumber: event.phoneNumber));
                //   emit.isDone;
                //
                //   emit(SignInSuccessState(
                //       verificationId: verificationId,
                //       message: CODE_SENDED,
                //       phoneNumber: event.phoneNumber));
              },
              codeAutoRetrievalTimeout: (verificationId) async {});
        } else {
          emit(ErrorAuthState(message: OFFLINE_FAILURE_MESSAGE));
        }
      } else if (event is OTPSentEvent) {
        emit(SignInSuccessState(
            verificationId: event.verifyId,
            message: CODE_SENDED,
            phoneNumber: event.phoneNumber));
      } else if (event is AuthErrorEvent) {
        emit(ErrorAuthState(message: event.message));
      }
      //   final failureOrVerifyId= await signInWithPhoneNumber(phoneNumber: event.phoneNumber);
      //   emit(_mapFailureOrSuccessSignInState(failureOrVerifyId,event.phoneNumber));
      //
      // }
      else if (event is verifyOTPEvent) {
        emit(LoadingState());
        final failureOrDoneMessage =
            await otpVerify(OTP: event.OTP, verificationId: event.verifyId);
        emit(_mapFailureOrSuccessOtpVerifyState(failureOrDoneMessage));
      }
    });
  }
  // AuthState _mapFailureOrSuccessSignInState(
  //     Either<Failure, String> either, String phoneNumber) {
  //   return either.fold(
  //       (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
  //       (verifyId) => SignInSuccessState(
  //           verificationId: verifyId,
  //           message: CODE_SENDED,
  //           phoneNumber: phoneNumber));
  // }

  AuthState _mapFailureOrSuccessOtpVerifyState(Either<Failure, Unit> either) {
    return either.fold(
        (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
        (_) => VerifyOtpSuccessState(message: CODE_ACEPTED));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case WrongOTPFailure:
        return WRONG_OTP_MESSAGE;
      case WrongPhoneNumberFailure:
        return WRONG_PHONENUMBER_MESSAGE;
      case OffLineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "UNEXCEPTED ERROR, please try again";
    }
  }
}
