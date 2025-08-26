part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


// Login States

class InitailLoginState extends AuthState {}
class SuccessLoginState extends AuthState {}
class LoadingLoginState extends AuthState {}
class FailureLoginState extends AuthState {
  final String errorMessage;
  FailureLoginState({required this.errorMessage});
}


// Sign Up States

class InitailRegisterState extends AuthState{}
class SuccessRegisterState extends AuthState{}
class LoadingRegisterState extends AuthState{}
class FailureRegisterState extends AuthState{
  final String errorMessage;
  FailureRegisterState({required this.errorMessage});
}