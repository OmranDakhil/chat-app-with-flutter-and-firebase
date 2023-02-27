import 'package:dartz/dartz.dart';
import 'package:text_me/features/chat_feature/domain/repositories/chat_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/text_message_entity.dart';

class GetAllMessagesToChatUseCase
{
  final ChatRepository chatRepository;

  GetAllMessagesToChatUseCase({required this.chatRepository});


  Future<Either<Failure, Stream<List<TextMessageEntity>>>> call(String userName) async{
    return chatRepository.getAllMessagesToChat(userName);
  }

}