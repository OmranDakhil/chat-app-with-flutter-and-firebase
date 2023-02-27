part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {

}

class PhotoChangedState extends ProfileState
{
  final File newImage;

  PhotoChangedState({required this.newImage});

  @override
  // TODO: implement props
  List<Object> get props => [newImage];

}

class PublicNameChangedState extends ProfileState
{
  final String newPublicName;

  PublicNameChangedState({required this.newPublicName});

  @override
  // TODO: implement props
  List<Object> get props => [newPublicName];

}

class AboutChangedState extends ProfileState {
  final String newAbout;
  AboutChangedState({required this.newAbout});
  @override
  // TODO: implement props
  List<Object> get props => [newAbout];

}


class LoadingState extends ProfileState {

}

class ErrorProfileState extends  ProfileState{
  final String message;

  ErrorProfileState({required this.message});
  @override
  List<Object> get props => [message];

}

class ProfileLoaded extends ProfileState{
  final MyUser profile;

  ProfileLoaded({required this.profile});
  @override
  List<Object> get props => [profile];
}

class ErrorGetProfileState extends ErrorProfileState{
  ErrorGetProfileState({required super.message});

}