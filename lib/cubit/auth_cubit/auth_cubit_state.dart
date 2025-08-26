part of 'auth_cubit.dart';


class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}


// Login States

class InitailLoginState extends AuthCubitState {}
class SuccessLoginState extends AuthCubitState {}
class LoadingLoginState extends AuthCubitState {}
class FailureLoginState extends AuthCubitState {
  final String errorMessage;
  FailureLoginState({required this.errorMessage});
}


// Sign Up States

class InitailRegisterState extends AuthCubitState{}
class SuccessRegisterState extends AuthCubitState{}
class LoadingRegisterState extends AuthCubitState{}
class FailureRegisterState extends AuthCubitState{
  final String errorMessage;
  FailureRegisterState({required this.errorMessage});
}