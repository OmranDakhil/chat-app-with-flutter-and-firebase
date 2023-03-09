
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:text_me/core/errors/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/edit_Profile_use_case.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EditProfileUseCase editProfile;
  ProfileBloc({required this.editProfile}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ChangePhotoEvent) {
        //emit(PhotoChangedState(newImage: event.image));
        final failureOrNewImage = await editProfile.changeProfilePhoto(
            event.image);
        emit(_mapFailureOrNewImage(failureOrNewImage,event.image));
      }

      if (event is ChangePublicNameEvent) {
        //emit(ErrorProfileState(message: "error"));
        final failureOrSuccessNameChange =
            await editProfile.changeProfilePublicName(event.newName);
        emit(_mapFailureOrSuccessNameChange(
            failureOrSuccessNameChange, event.newName));
      }

      if (event is ChangeAboutEvent) {
        //emit(AboutChangedState(newAbout: event.newAbout));
        final failureOrSuccessAboutChange =
            await editProfile.changeProfileAbout(event.newAbout);
        emit(_mapFailureOrSuccessAboutChange(
            failureOrSuccessAboutChange, event.newAbout));
      }
    });
  }

  ProfileState _mapFailureOrNewImage(
      Either<Failure, Unit> failureOrNewImage,File image) {
    return failureOrNewImage.fold(
        (failure) => ErrorProfileState(message: _mapFailureToMessage(failure)),
        (_) => PhotoChangedState(newImage:image));
  }

  ProfileState _mapFailureOrSuccessNameChange(
      Either<Failure, Unit> failureOrSuccessChange, String newName) {
    return failureOrSuccessChange.fold(
        (failure) => ErrorProfileState(message: _mapFailureToMessage(failure)),
        (_) => PublicNameChangedState(newPublicName: newName));
  }

  ProfileState _mapFailureOrSuccessAboutChange(
      Either<Failure, Unit> failureOrSuccessAboutChange, String newAbout) {
    return failureOrSuccessAboutChange.fold(
        (failure) => ErrorProfileState(message: _mapFailureToMessage(failure)),
        (_) => AboutChangedState(newAbout: newAbout));
  }



  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OffLineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "UNEXPECTED ERROR, please try again";
    }
  }


}
