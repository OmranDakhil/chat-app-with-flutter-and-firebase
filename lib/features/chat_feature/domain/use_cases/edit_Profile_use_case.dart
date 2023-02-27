import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:text_me/core/errors/failures.dart';
import 'package:text_me/features/chat_feature/domain/entities/user_entity.dart';
import 'package:text_me/features/chat_feature/domain/repositories/chat_repository.dart';

class EditProfileUseCase
{
  final ChatRepository chatRepository;

  EditProfileUseCase({required this.chatRepository});

  Future<Either<Failure,Unit>>  changeProfilePhoto(File image)
  {
    return  chatRepository.changeProfilePhoto(image);
  }

  Future<Either<Failure,Unit>> changeProfilePublicName(String newPublicName){
    return chatRepository.changeProfilePublicName(newPublicName);
  }

  Future<Either<Failure,Unit>> changeProfileAbout(String newAbout){
    return chatRepository.changeProfileAbout(newAbout);
  }
  Future<Either<Failure,MyUser>> getMyProfile(){
    return  chatRepository.getUser();
  }
}