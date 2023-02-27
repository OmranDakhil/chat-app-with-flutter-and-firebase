import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:text_me/core/errors/exceptions.dart';
import 'package:text_me/core/errors/failures.dart';
import 'package:text_me/features/chat_feature/data/models/text_message_model.dart';
import 'package:text_me/features/chat_feature/domain/entities/chat_in_data_base_entity.dart';
import 'package:text_me/features/chat_feature/domain/entities/chat_to_show_entity.dart';
import 'package:text_me/features/chat_feature/domain/entities/text_message_entity.dart';
import 'package:text_me/features/chat_feature/domain/entities/user_entity.dart';
import 'package:text_me/features/chat_feature/domain/repositories/chat_repository.dart';

import '../../../../core/contacts/contacts_info.dart';
import '../../../../core/networks/network_info.dart';
import '../data_sources/remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final NetworkInfo networkInfo;
  final ContactsInfo contactInfo;
  final ChatRemoteDataSource remoteDataSource;
  ChatRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.contactInfo});

  @override
  Future<Map<String, String>?> getAllContacts() {
    return contactInfo.fetchContacts();
  }

  @override
  Future<Either<Failure, MyUser>> getUser([String? phoneNumber]) async {
    if (await networkInfo.isConnected) {
      try {


        MyUser user= await remoteDataSource.getUser(phoneNumber);

        return right(user);
      } on UserNotFoundException {
        return left(UserNotFoundFailure());
      } on Exception {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<ChatToShowEntity>>>> getAllChats() async {
    if (await networkInfo.isConnected) {
      try {
        Stream<List<ChatInDataBaseEntity>> chats =
            await remoteDataSource.getAllChats();
        Map<String, String>? contacts = await contactInfo.fetchContacts();
        Stream<List<ChatToShowEntity>> loadedChats =
            chats.asyncMap((event) async {
          List<ChatToShowEntity> chatsToShow = [];
          for (var document in event) {
            final user = await getUser(document.contactPhoneNumber);
            user.fold((_) => {}, (user) {
              chatsToShow.add(ChatToShowEntity(
                  nameInDevice:
                      contacts!.containsKey(document.contactPhoneNumber)
                          ? contacts[document.contactPhoneNumber]!
                          : document.contactPhoneNumber,
                  user: user,
                  lastMessage: document.lastMessage));
            });
          }

          return chatsToShow;
        });
        return Right(loadedChats!);
      } on Exception {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<TextMessageEntity>>>> getAllMessagesToChat(
      String userName) async {
    if (await networkInfo.isConnected) {
      try {
        Stream<List<TextMessageEntity>> messages =
            await remoteDataSource.getAllMessagesToChat(userName);
        return right(messages);
      } on ChatNotFoundException {
        return left(ChatNotFoundFailure());
      } on Exception {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> changeProfileAbout(String newAbout) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.changeProfileAbout(newAbout);
        return right(unit);
      } on Exception {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> changeProfilePhoto(
      File image) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.changeProfilePhoto(image);
        return right(unit);
      } on Exception {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> changeProfilePublicName(
      String newPublicName) async {
    // TODO: implement changeProfilePublicName
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.changeProfilePublicName(newPublicName);
        return right(unit);
      } on Exception {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendTextMessage(
      String receiver, TextMessageEntity message) async {
    if (await networkInfo.isConnected) {
      try {
        TextMessageModel messageModel = TextMessageModel(
            isSender: message.isSender, message: message.message);
        bool isFirstMessage =
            await remoteDataSource.sendTextMessage(receiver, messageModel);
        return right(isFirstMessage);
      } on Exception {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }
}
