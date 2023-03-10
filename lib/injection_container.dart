import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:phone_number/phone_number.dart';
import 'package:text_me/core/contacts/contacts_info.dart';
import 'package:text_me/features/auth_feature/data/data_sources/auth_Remote_data_source.dart';
import 'package:text_me/features/auth_feature/data/repositories/auth_repository_impl.dart';
import 'package:text_me/features/auth_feature/domain/usecases/otp_verify.dart';
import 'package:text_me/features/auth_feature/domain/usecases/sign_in_with_phone_number.dart';
import 'package:text_me/features/auth_feature/presentation/bloc/auth_bloc.dart';
import 'package:text_me/features/chat_feature/data/data_sources/remote_data_source.dart';
import 'package:text_me/features/chat_feature/data/repositories/chat_repository_impl.dart';
import 'package:text_me/features/chat_feature/domain/repositories/chat_repository.dart';
import 'package:text_me/features/chat_feature/domain/use_cases/edit_Profile_use_case.dart';
import 'package:text_me/features/chat_feature/domain/use_cases/get_all_chats_use_case.dart';
import 'package:text_me/features/chat_feature/domain/use_cases/get_all_contacts_use_case.dart';
import 'package:text_me/features/chat_feature/domain/use_cases/get_all_messages_to_chat_use_case.dart';
import 'package:text_me/features/chat_feature/domain/use_cases/get_user_use_case.dart';
import 'package:text_me/features/chat_feature/domain/use_cases/log_out_use_case.dart';
import 'package:text_me/features/chat_feature/domain/use_cases/send_text_message_use_case.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:text_me/features/chat_feature/presentation/bloc/pop_up_menu_bloc/pop_up_menu_bloc.dart';
import 'core/networks/network_info.dart';
import 'features/auth_feature/domain/repositries/auth_repository.dart';
import 'features/chat_feature/presentation/bloc/profile_bloc/profile_bloc.dart';
final sl = GetIt.instance;

Future<void> init() async {
  //blocs
  sl.registerFactory(() => AuthBloc(otpVerify: sl(), signInWithPhoneNumber: sl()));
  sl.registerFactory(() => ChatBloc(getAllContacts: sl(),getUser: sl(),getAllChats: sl(),getAllMessagesToChat: sl(),sendTextMessage: sl()));
  sl.registerFactory(() => ProfileBloc(editProfile: sl()));
  sl.registerFactory(() => PopUpMenuBloc(editProfile: sl(), logOut: sl()));


  // use cases
  sl.registerLazySingleton(() => SendTextMessageUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetAllContactsUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetAllMessagesToChatUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetAllChatsUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => OTPVerifyUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => SignInWithPhoneNumberUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogOutUseCase(chatRepository: sl()));


  //  repositories
  sl.registerLazySingleton<ChatRepository>(() =>ChatRepositoryImpl(contactInfo: sl(),networkInfo: sl(),remoteDataSource: sl()) );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));





  //remote data source
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceWithFirebaseAuth(auth: sl()));
  sl.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(firebaseAuth: sl(),firebaseFirestore: sl(),firebaseStorage: sl()));


  //  external
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() =>ContactsInfo(phoneNumberUtil: sl()) );
  sl.registerLazySingleton(() =>PhoneNumberUtil());


  // firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}