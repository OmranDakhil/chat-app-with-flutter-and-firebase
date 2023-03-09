part of 'pop_up_menu_bloc.dart';

abstract class PopUpMenuEvent extends Equatable {
  const PopUpMenuEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetMyProfileEvent extends PopUpMenuEvent {}

class LogOutEvent extends PopUpMenuEvent {}
