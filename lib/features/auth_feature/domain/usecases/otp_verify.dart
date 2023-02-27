import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_me/features/auth_feature/domain/repositries/auth_repository.dart';

import '../../../../core/errors/failures.dart';

class OTPVerifyUsecase
{
  final AuthRepository authRepository;

  OTPVerifyUsecase({required this.authRepository});


  Future<Either<Failure,Unit>> call({required String OTP,required String verificationId})

  {
    return authRepository.verifyOTP(OTP,verificationId);
  }


}