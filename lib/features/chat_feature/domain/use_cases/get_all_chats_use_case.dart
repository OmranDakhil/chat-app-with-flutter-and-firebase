import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:text_me/core/contacts/contacts_info.dart';
import 'package:text_me/features/chat_feature/domain/entities/chat_to_show_entity.dart';
import 'package:text_me/features/chat_feature/domain/repositories/chat_repository.dart';

import '../../../../core/errors/failures.dart';

class GetAllChatsUseCase {
  final ChatRepository chatRepository;

  GetAllChatsUseCase({required this.chatRepository});

  Future<Either<Failure, Stream<List<ChatToShowEntity>>>> call() async {

    return await chatRepository.getAllChats();
    // Map<String,String> contacts=ContactsInfo
    // return chats.fold((failure) => Left(failure), (allChats) async {
    //
    //   Stream<List<ChatToShowEntity>> loadedChats=allChats.asyncMap((event) async {
    //     List<ChatToShowEntity> chatsToShow = [];
    //     for (var document in event) {
    //       final user =
    //           await chatRepository.getUser(document.contactPhoneNumber);
    //       user.fold((_) => {}, (user) {
    //
    //         chatsToShow.add(ChatToShowEntity(
    //             nameInDevice: document.contactPhoneNumber,
    //             user: user,
    //             lastMessage: document.lastMessage));
    //       });
    //     }
    //
    //     return chatsToShow;
    //   });
    //      return Right(loadedChats!);
    //
    // });
  }
}
