part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class SignInEvent extends AuthenticationEvent {
  final SignInParams params;
  SignInEvent({required this.params});
}

class SignUpEvent extends AuthenticationEvent {
  final SignUpParams params;
  SignUpEvent({required this.params});

  @override
  String toString() => 'SignUpEvent(params: $params)';
}

class GoToSignUpPageEvent extends AuthenticationEvent {}

class GoToSignInPageEvent extends AuthenticationEvent {}
