part of 'authentication_bloc.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class SignInAuthenticationState extends AuthenticationState {}

class SignUpAuthenticationState extends AuthenticationState {}

class LoadingAuthenticationState extends AuthenticationState {}

class LoadedAuthenticationState extends AuthenticationState {}

class UserSignedInAuthenticationState extends AuthenticationState {
  final String username;
  UserSignedInAuthenticationState({required this.username});

  @override
  String toString() => 'UserSignedInAuthenticationState(username: $username)';
}

class ErrorAuthenticationState extends AuthenticationState {
  final String message;
  ErrorAuthenticationState({required this.message});

  @override
  String toString() => 'ErrorAuthenticationState(message: $message)';
}

class GoToSignUpPageState extends AuthenticationState {}

class GoToSignInPageState extends AuthenticationState {}
