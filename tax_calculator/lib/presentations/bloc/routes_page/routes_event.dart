part of 'routes_bloc.dart';

abstract class RoutesEvent extends Equatable {
  const RoutesEvent();

  @override
  List<Object> get props => [];
}

class LogOut extends RoutesEvent {
  const LogOut();
}

class UserStatusChange extends RoutesEvent {
  const UserStatusChange();
}
