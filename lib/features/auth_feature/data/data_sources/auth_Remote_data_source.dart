import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_me/core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<String> signInWithPhoneNumber(String phoneNumber);
  Future<Unit> verifyOTP(String OTP, String verificationId);
}

class AuthRemoteDataSourceWithFirebaseAuth implements AuthRemoteDataSource {
  final FirebaseAuth auth;

  AuthRemoteDataSourceWithFirebaseAuth({required this.auth});
  @override
  Future<String> signInWithPhoneNumber(String phoneNumber) async {
    String? _verificationId;
    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) async {
          if (e.code == 'invalid-phone-number') {
            throw WrongPhoneNumberException();
          }
        },
        codeSent: (verificationId, resendingToken) async {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
    return _verificationId!;
  }

  @override
  Future<Unit> verifyOTP(String OTP, String verificationId) async {
    try {
      var credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: OTP);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      String userPhoneNumber = userCredential.user!.phoneNumber!;
      FirebaseFirestore.instance
          .collection('users')
          .doc(userPhoneNumber)
          .collection('chats')
          .doc(userPhoneNumber)
          .set({'chatId': ""});
      return Future.value(unit);
    } catch (_) {
      throw WrongOTPException();
    }
  }
}
