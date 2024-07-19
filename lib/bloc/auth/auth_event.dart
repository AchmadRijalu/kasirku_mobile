part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}


class AuthGetCurrentUser extends AuthEvent {}

class AuthLogout extends AuthEvent{
  
}