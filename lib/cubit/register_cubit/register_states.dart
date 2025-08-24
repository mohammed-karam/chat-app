
class RegisterStates {}

class InitailRegisterState extends RegisterStates{}
class SuccessRegisterState extends RegisterStates{}
class LoadingRegisterState extends RegisterStates{}
class FailureRegisterState extends RegisterStates{
  final String errorMessage;
  FailureRegisterState({required this.errorMessage});
}