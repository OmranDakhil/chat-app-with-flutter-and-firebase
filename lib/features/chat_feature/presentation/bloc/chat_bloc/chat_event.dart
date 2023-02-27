part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}
class GetAllContactsEvent implements ChatEvent {}


class GetUserEvent implements ChatEvent {
  final Contact contact;

  GetUserEvent({required this.contact});
}


class GetAllChatsEvent implements ChatEvent {}



class GetAllMessagesToChatEvent implements ChatEvent {
  final String userName;

  GetAllMessagesToChatEvent({required this.userName});

}


class SendMessageEvent implements ChatEvent  {
  final String userName;
  final TextMessageEntity message;

  SendMessageEvent({required this.userName, required this.message});

}

