import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}
class OffLineFailure extends Failure{
  @override

  List<Object?> get props => [];
}
class ServerFailure extends Failure{
  @override

  List<Object?> get props => [];
}
class EmptyCacheFailure extends Failure{
  @override

  List<Object?> get props => [];
}
class WrongPhoneNumberFailure extends Failure
{
  @override

  List<Object?> get props => [];
}


class WrongOTPFailure extends Failure
{
  @override

  List<Object?> get props => [];
}
class UserNotFoundFailure extends Failure
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class ChatNotFoundFailure extends Failure
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}