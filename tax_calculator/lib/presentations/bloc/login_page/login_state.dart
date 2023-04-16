part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object> get props => [];
}

class LoginSubmit extends LoginState {
  final String username;
  final String password;

  const LoginSubmit(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LoginError extends LoginState {
  final String errorMessage;

  const LoginError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
