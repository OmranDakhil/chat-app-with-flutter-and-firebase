import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:text_me/features/auth_feature/presentation/bloc/auth_bloc.dart';
import 'package:text_me/features/chat_feature/domain/entities/chat_to_show_entity.dart';
import 'package:text_me/features/chat_feature/domain/entities/text_message_entity.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/get_all_chats_use_case.dart';
import '../../../domain/use_cases/get_all_contacts_use_case.dart';
import '../../../domain/use_cases/get_all_messages_to_chat_use_case.dart';
import '../../../domain/use_cases/get_user_use_case.dart';
import '../../../domain/use_cases/send_text_message_use_case.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetAllContactsUseCase getAllContacts;
  final GetUserUseCase getUser;
  final GetAllChatsUseCase getAllChats;
  final GetAllMessagesToChatUseCase getAllMessagesToChat;
  final SendTextMessageUseCase  sendTextMessage;
  ChatBloc(
      {required this.getAllContacts,
      required this.getUser,
      required this.getAllChats,
      required this.getAllMessagesToChat,
        required this.sendTextMessage,})
      : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is GetAllContactsEvent) {
        emit(loadingChatState());
        List<Contact>? contacts = await getAllContacts();
        emit(ContactsLoaded(contacts: contacts));
      }
      if (event is GetUserEvent) {
        emit(loadingChatState());
        final failureOrUser = await getUser(event.contact.PhoneNumber);
        emit(_mapFailureOrGetUserState(failureOrUser, event.contact.Name));
      }
      if (event is GetAllChatsEvent) {
        emit(loadingChatState());
        final failureOrStreamOfChats = await getAllChats();
        emit(_mapFailureOrStreamOfChats(failureOrStreamOfChats));
      }

      if (event is GetAllMessagesToChatEvent) {
        emit(loadingChatState());
        final failureOrStreamOfMessages =
        await getAllMessagesToChat(event.userName);
        emit(_mapFailureOrStreamOfMessages(failureOrStreamOfMessages));
      }
      if(event is SendMessageEvent)
        {
          final failureOrsuccessedSend =
          await sendTextMessage(receiver: event.userName,message: event.message);
          failureOrsuccessedSend.fold(
                  (failure) => emit(ErrorInChatContactPageState(message: _mapFailureToMessage(failure))),
                  (isFirstMessage) {
                    emit(TextMessageSent());
                    if(isFirstMessage) {
                      add(GetAllMessagesToChatEvent(userName: event.userName ));
                    }
                  });
        }

    });
  }


  ChatState _mapFailureOrStreamOfMessages(
      Either<Failure, Stream<List<TextMessageEntity>>>
      either) {
    return either.fold(
            (failure) => ErrorInChatContactPageState(message: _mapFailureToMessage(failure)),
    (messages) => AllMessagesLoaded(messages: messages),);
  }


  ChatState _mapFailureOrGetUserState(
      Either<Failure, MyUser> either, String name) {
    return either.fold(
        (failure) => ErrorInContactsPageState(message: _mapFailureToMessage(failure)),
        (user) => UserLoaded(nameInDevice: name, user: user));
  }

  ChatState _mapFailureOrStreamOfChats(
      Either<Failure, Stream<List<ChatToShowEntity>>> either) {
    return either.fold(
      (failure) => ErrorInChatPageState(message: _mapFailureToMessage(failure)),
      (chats) => ChatsLoaded(chats: chats),
    );
  }


  // ChatState _mapFailureOrsuccessedSend(Either<Failure, bool> failureOrsuccessedSend) {
  //   return failureOrsuccessedSend.fold(
  //           (failure) => ErrorChatState(message: _mapFailureToMessage(failure)),
  //           (isFirstMessage) => TextMessageSent());
  // }


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case UserNotFoundFailure:
        return USER_NOT_FOUND_MESSAGE;
      case OffLineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case ChatNotFoundFailure:
        return Chat_NOT_FOUND_MESSAGE;
      default:
        return "UNEXPECTED ERROR, please try again";
    }
  }




}
