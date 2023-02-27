import 'package:dartz/dartz.dart';
import 'package:text_me/core/errors/exceptions.dart';
import 'package:text_me/features/auth_feature/domain/repositries/auth_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/networks/network_info.dart';
import '../data_sources/auth_Remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> signInWithPhoneNumber(
      String phoneNumber) async {
    if (await networkInfo.isConnected) {
      try {
        String verificationId =
            await remoteDataSource.signInWithPhoneNumber(phoneNumber);
        return Right(verificationId);
      } on WrongPhoneNumberException {
        return Left(WrongPhoneNumberFailure());
      }catch(e){
        print(e.runtimeType);
        return Left(WrongPhoneNumberFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP(
      String OTP, String verificationId) async {
    // TODO: implement verifyOTP
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.verifyOTP(OTP, verificationId);
        return const Right(unit);
      } on WrongOTPException {
        return Left(WrongOTPFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
