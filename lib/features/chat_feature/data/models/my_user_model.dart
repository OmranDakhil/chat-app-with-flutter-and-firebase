import 'package:text_me/features/chat_feature/domain/entities/user_entity.dart';

class MyUserModel extends MyUser {
  MyUserModel(
      {required super.phoneNumber,
      required super.publicName,
      required super.about,
      super.userImageUrl});
  factory MyUserModel.fromJson(Map<String, dynamic> json) {
    return MyUserModel(
        phoneNumber: json['phoneNumber'],
        publicName: json.containsKey('publicName')?json['publicName']:'user',
        about: json.containsKey('about')?json['about']:'i am a new user',
        userImageUrl: json.containsKey('imageUrl')?json['imageUrl']:null);
  }
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'publicName': publicName,
      'about': about,
      'imageUrl': userImageUrl
    };
  }
}
