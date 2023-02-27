import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:text_me/core/errors/exceptions.dart';
import 'package:text_me/features/chat_feature/data/models/chat_in_data_base_model.dart';
import 'package:text_me/features/chat_feature/data/models/my_user_model.dart';
import 'package:text_me/features/chat_feature/data/models/text_message_model.dart';

abstract class ChatRemoteDataSource {
  Future<MyUserModel> getUser(String? phoneNumber);
  Future<Stream<List<ChatInDataBaseModel>>> getAllChats();
  Future<Stream<List<TextMessageModel>>> getAllMessagesToChat(String userName);
  Future<Unit> changeProfileAbout(String newAbout);
  Future<Unit> changeProfilePhoto(File image);
  Future<Unit> changeProfilePublicName(String newPublicName);
  Future<bool> sendTextMessage(String receiver, TextMessageModel message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;
  ChatRemoteDataSourceImpl(
      {required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.firebaseStorage});

  @override
  Future<bool> sendTextMessage(
      String receiver, TextMessageModel message) async {
    String phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
    int timeStamp = Timestamp.now().millisecondsSinceEpoch;
    DocumentSnapshot<Map<String, dynamic>> chat = await firebaseFirestore
        .collection('users')
        .doc(phoneNumber)
        .collection('chats')
        .doc(receiver)
        .get();
    if (chat.exists) {
      String chatId = chat.data()!['chatId'];
      await firebaseFirestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': phoneNumber,
        'message': message.message,
        'createdAt': timeStamp
      });
      await firebaseFirestore.collection('chats').doc(chatId).update(
          {'lastMessage': message.message, 'lastMessageCreatedAt': timeStamp});
      return false;
    } else {
      DocumentReference<Map<String, dynamic>> docRef = await firebaseFirestore
          .collection('chats')
          .add({
        'lastMessage': message.message,
        'lastMessageCreatedAt': timeStamp
      });
      docRef.collection('messages').add({
        'senderId': phoneNumber,
        'message': message.message,
        'createdAt': timeStamp
      });

      await firebaseFirestore
          .collection('users')
          .doc(receiver)
          .collection('chats')
          .doc(phoneNumber)
          .set({
        'chatId': docRef.id,
      });
      await firebaseFirestore
          .collection('users')
          .doc(phoneNumber)
          .collection('chats')
          .doc(receiver)
          .set({
        'chatId': docRef.id,
      });
      return true;
    }
  }

  @override
  Future<Unit> changeProfileAbout(String newAbout) async {
    String phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
    await firebaseFirestore
        .collection("users")
        .doc(phoneNumber)
        .set({"about": newAbout}, SetOptions(merge: true));
    return Future.value(unit);
  }

  @override
  Future<Unit> changeProfilePhoto(File image) async {
    String phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
    int rand = Random().nextInt(100000);
    String imageName = "$rand" + path.basename(image.path);
    Reference ref = firebaseStorage.ref("profileImages").child(imageName);
    await ref.putFile(image);
    String newImageUrl = await ref.getDownloadURL();
    DocumentSnapshot<Map<String, dynamic>> user=await firebaseFirestore
        .collection("users")
        .doc(phoneNumber).get();
    String? previousImageUrl;
    if(user.data()!.containsKey('imageUrl'))
      {
        previousImageUrl=user.data()!['imageUrl'];

      }
    await user.reference.set({"imageUrl": newImageUrl}, SetOptions(merge: true));

    if(previousImageUrl!=null)
      {
        await firebaseStorage.refFromURL(previousImageUrl).delete();
      }
    return Future.value(unit);
  }

  @override
  Future<Unit> changeProfilePublicName(String newPublicName) async {
    String phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
    await firebaseFirestore
        .collection("users")
        .doc(phoneNumber)
        .set({"publicName": newPublicName}, SetOptions(merge: true));
    return Future.value(unit);
  }

  @override
  Future<Stream<List<ChatInDataBaseModel>>> getAllChats() async {
    String phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
    Stream<QuerySnapshot<Map<String, dynamic>>> userChats = firebaseFirestore
        .collection('users')
        .doc(phoneNumber)
        .collection('chats')
        .snapshots();
    return userChats.asyncMap((event) async {
      List<ChatInDataBaseModel> chats = [];
      for (var document in event.docs) {
        if (document.id != phoneNumber) {
          DocumentSnapshot<Map<String, dynamic>> chat = await firebaseFirestore
              .collection('chats')
              .doc(document.data()['chatId'])
              .get();

          chats.add(ChatInDataBaseModel(
              lastMessage: chat.data()!['lastMessage'],
              contactPhoneNumber: document.id));
        }
      }
      return chats;
    });
  }

  @override
  Future<Stream<List<TextMessageModel>>> getAllMessagesToChat(
      String userName) async {
    String phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
    DocumentSnapshot<Map<String, dynamic>> chat = await firebaseFirestore
        .collection('users')
        .doc(phoneNumber)
        .collection('chats')
        .doc(userName)
        .get();
    if (chat.exists) {
      Stream<QuerySnapshot<Map<String, dynamic>>> streamMessages =
          firebaseFirestore
              .collection('chats')
              .doc(chat.data()!['chatId'])
              .collection('messages')
              .orderBy('createdAt', descending: true)
              .snapshots();

      return streamMessages.asyncMap((event) async {
        List<TextMessageModel> messages = [];
        for (var document in event.docs) {
          final data = document.data();
          String senderId = data['senderId'];
          data.addAll({
            'isSender': senderId == phoneNumber,
          });

          messages.add(TextMessageModel.fromJson(data));
        }
        return messages;
      });
    } else {
      throw ChatNotFoundException();
    }
  }

  @override
  Future<MyUserModel> getUser(String? phoneNumber) async {
    String myNumber = firebaseAuth.currentUser!.phoneNumber!;
    DocumentSnapshot<Map<String, dynamic>> doc;
    if (phoneNumber != null) {
      doc = await firebaseFirestore.collection('users').doc(phoneNumber).get();
    } else {
      doc = await firebaseFirestore.collection('users').doc(myNumber).get();
    }
    if (doc.exists) {
      final data = doc.data()!;
      if (phoneNumber != null) {
        data.addAll({'phoneNumber': phoneNumber});
      } else {
        data.addAll({'phoneNumber': myNumber});
      }
      return MyUserModel.fromJson(data);
    } else {
      throw UserNotFoundException();
    }
  }
}
