part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangePhotoEvent extends ProfileEvent{
  final File image;


  ChangePhotoEvent({required this.image});



}


class ChangePublicNameEvent extends ProfileEvent
{
  final String newName;

  const ChangePublicNameEvent({required this.newName});
}
class ChangeAboutEvent extends ProfileEvent
{
  final String newAbout;

  const ChangeAboutEvent({required this.newAbout});
}

