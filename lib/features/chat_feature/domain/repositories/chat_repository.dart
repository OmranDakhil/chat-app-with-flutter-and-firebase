import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:text_me/core/errors/failures.dart';
import 'package:text_me/features/chat_feature/domain/entities/chat_in_data_base_entity.dart';
import 'package:text_me/features/chat_feature/domain/entities/chat_to_show_entity.dart';
import 'package:text_me/features/chat_feature/domain/entities/text_message_entity.dart';
import 'package:text_me/features/chat_feature/domain/entities/user_entity.dart';

abstract class ChatRepository{
  Future<Map<String,String>?>getAllContacts();

  Future<Either<Failure, MyUser>> getUser([String? phoneNumber]) ;
  Future<Either<Failure, Stream<List<ChatToShowEntity>>>> getAllChats();

  Future<Either<Failure, Stream<List<TextMessageEntity>>>> getAllMessagesToChat(String userName);
  Future<Either<Failure,Unit>>  changeProfilePhoto(File image);

  Future<Either<Failure,Unit>> changeProfilePublicName(String newPublicName);

  Future<Either<Failure, Unit>> changeProfileAbout(String newAbout) ;

  Future<Either<Failure, bool>> sendTextMessage(String receiver, TextMessageEntity message);

  Future<Either<Failure, Unit>> logOut();
}