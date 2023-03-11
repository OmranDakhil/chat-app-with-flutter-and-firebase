import 'package:dartz/dartz.dart';
import 'package:text_me/features/chat_feature/domain/repositories/chat_repository.dart';

import '../../../../core/errors/failures.dart';

class LogOutUseCase{
  final ChatRepository chatRepository;

  LogOutUseCase({required this.chatRepository});



  Future<Either<Failure,Unit>> call() async
  {
    return  chatRepository.logOut();
  }


}