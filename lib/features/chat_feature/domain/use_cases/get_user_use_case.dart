import 'package:dartz/dartz.dart';
import 'package:text_me/core/errors/failures.dart';

import '../entities/user_entity.dart';
import '../repositories/chat_repository.dart';

class GetUserUseCase
{
  final ChatRepository chatRepository;

  GetUserUseCase({required this.chatRepository});



  Future<Either<Failure,MyUser>> call(String phoneNumber) async
  {
    return  chatRepository.getUser(phoneNumber);
  }

}