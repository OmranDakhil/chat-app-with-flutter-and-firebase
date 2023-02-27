import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthRepository

{
  Future<Either<Failure,String>> signInWithPhoneNumber(String phoneNumber);
  Future<Either<Failure,Unit>> verifyOTP(String OTP,String verificationId);

}