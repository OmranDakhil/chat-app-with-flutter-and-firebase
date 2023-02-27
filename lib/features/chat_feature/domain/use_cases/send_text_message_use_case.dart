import 'package:dartz/dartz.dart';
import 'package:text_me/features/chat_feature/domain/entities/text_message_entity.dart';
import 'package:text_me/features/chat_feature/domain/repositories/chat_repository.dart';

import '../../../../core/errors/failures.dart';

class SendTextMessageUseCase{
  final ChatRepository chatRepository;

  SendTextMessageUseCase({required this.chatRepository});


  Future<Either<Failure,bool>> call({required String receiver, required TextMessageEntity message})
  {
   return chatRepository.sendTextMessage(receiver,message);
  }
}








