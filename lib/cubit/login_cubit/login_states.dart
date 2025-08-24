class LoginStates {}

class InitailLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class FailureLoginState extends LoginStates {
  final String errorMessage;

  FailureLoginState({required this.errorMessage});
}
