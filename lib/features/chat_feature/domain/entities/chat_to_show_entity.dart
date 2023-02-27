import 'package:text_me/features/chat_feature/domain/entities/user_entity.dart';

class ChatToShowEntity
{
  final String nameInDevice;
  final MyUser user;
  final String lastMessage;

  ChatToShowEntity({required this.nameInDevice, required this.user, required this.lastMessage});
}