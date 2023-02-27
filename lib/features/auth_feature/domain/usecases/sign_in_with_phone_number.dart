import 'package:dartz/dartz.dart';
import 'package:text_me/features/auth_feature/domain/repositries/auth_repository.dart';

import '../../../../core/errors/failures.dart';

class SignInWithPhoneNumberUsecase
{
  final AuthRepository authRepository;

  SignInWithPhoneNumberUsecase({required this.authRepository});


  Future<Either<Failure,String>>  call({required String phoneNumber})
  {
    return authRepository.signInWithPhoneNumber(phoneNumber);
  }




}