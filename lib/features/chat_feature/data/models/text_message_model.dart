import 'package:text_me/features/chat_feature/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity
{
  TextMessageModel({required super.isSender, required super.message});
  factory TextMessageModel.fromJson(Map<String,dynamic> json)
  {
    return TextMessageModel(isSender: json['isSender'],message: json['message']);
  }
  Map<String,dynamic> toJson(){
    return
      {
        'isSender': isSender,
        'message':message,

      };
  }
}