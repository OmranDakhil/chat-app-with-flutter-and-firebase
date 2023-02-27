part of 'chat_bloc.dart';

@immutable
abstract class ChatState extends Equatable{
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}
class ContactsLoaded extends ChatState{
  final List<Contact>? contacts;

  ContactsLoaded({required this.contacts});
  @override
  List<Object> get props => [contacts!];
}
class loadingChatState extends ChatState {}
class UserLoaded extends ChatState
{
  final String nameInDevice;
  final MyUser user;

  UserLoaded({required this.nameInDevice, required this.user});

  @override
  List<Object> get props => [nameInDevice,user];
}
abstract class ErrorChatState extends ChatState {
  final String message;

  ErrorChatState({required this.message});
  @override
  List<Object> get props => [message];

}
class ErrorInChatPageState extends ErrorChatState{
  ErrorInChatPageState({required super.message});

}
class ErrorInContactsPageState extends ErrorChatState{
  ErrorInContactsPageState({required super.message});



}
class ErrorInChatContactPageState extends ErrorChatState{
  ErrorInChatContactPageState({required super.message});

}
class ChatsLoaded extends ChatState{
  final Stream<List<ChatToShowEntity>> chats;

  ChatsLoaded({required this.chats});
  @override
  List<Object> get props => [chats];
}



class AllMessagesLoaded extends ChatState
{
  final Stream<List<TextMessageEntity>>  messages;

  AllMessagesLoaded({required this.messages});

}


class TextMessageSent extends ChatState
{


}
