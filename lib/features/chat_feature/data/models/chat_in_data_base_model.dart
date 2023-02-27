import 'package:text_me/features/chat_feature/domain/entities/chat_in_data_base_entity.dart';

class ChatInDataBaseModel extends ChatInDataBaseEntity {
  ChatInDataBaseModel(
      {required super.lastMessage, required super.contactPhoneNumber});

  factory ChatInDataBaseModel.fromJson(Map<String, dynamic> json) {
    return ChatInDataBaseModel(
      contactPhoneNumber: json['phoneNumber'],
      lastMessage: json['lastMessage'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': contactPhoneNumber,
      'lastMessage': lastMessage,
    };
  }
}
