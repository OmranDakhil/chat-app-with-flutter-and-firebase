part of 'pop_up_menu_bloc.dart';

abstract class PopUpMenuState extends Equatable {
  const PopUpMenuState();
  @override
  List<Object> get props => [];
}

class PopUpMenuInitial extends PopUpMenuState {}

class ProfileLoadedState extends PopUpMenuState {
  final MyUser profile;

  const ProfileLoadedState({required this.profile});
  @override
  List<Object> get props => [profile];
}

class ErrorPopUpMenuState extends PopUpMenuState {
  final String message;

  const ErrorPopUpMenuState({required this.message});
  @override
  List<Object> get props => [message];
}

class LogOutSuccessState extends PopUpMenuState {}

class PopUpMenuLoadingState extends PopUpMenuState {}
