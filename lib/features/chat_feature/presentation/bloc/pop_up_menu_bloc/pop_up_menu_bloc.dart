import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/edit_Profile_use_case.dart';
import '../../../domain/use_cases/log_out_use_case.dart';

part 'pop_up_menu_event.dart';
part 'pop_up_menu_state.dart';

class PopUpMenuBloc extends Bloc<PopUpMenuEvent, PopUpMenuState> {
  final EditProfileUseCase editProfile;
  final LogOutUseCase logOut;
  PopUpMenuBloc({required this.editProfile, required this.logOut})
      : super(PopUpMenuInitial()) {
    on<PopUpMenuEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is GetMyProfileEvent) {
        emit(PopUpMenuLoadingState());
        final failureOrUser = await editProfile.getMyProfile();
        emit(_mapFailureOrUser(failureOrUser));
      }

      if (event is LogOutEvent) {
        emit(PopUpMenuLoadingState());
        final failureOrLogOutSuccess = await logOut();
        emit(_mapFailureOrLogOutSuccess(failureOrLogOutSuccess));
      }
    });
  }

  PopUpMenuState _mapFailureOrUser(Either<Failure, MyUser> failureOrUser) {
    return failureOrUser.fold(
        (failure) =>
            ErrorPopUpMenuState(message: _mapFailureToMessage(failure)),
        (user) => ProfileLoadedState(profile: user));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OffLineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "UNEXPECTED ERROR, please try again";
    }
  }

  PopUpMenuState _mapFailureOrLogOutSuccess(
      Either<Failure, Unit> failureOrLogOutSuccess) {
    return failureOrLogOutSuccess.fold(
        (failure) =>
            ErrorPopUpMenuState(message: _mapFailureToMessage(failure)),
        (_) => LogOutSuccessState());
  }
}
