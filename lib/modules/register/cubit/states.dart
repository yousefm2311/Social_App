abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class RegisterVisibilityState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}
class CreateUserSuccessState extends RegisterStates {}
class CreateUserErrorState extends RegisterStates {
    final String error;
  CreateUserErrorState(this.error);
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterLoadingState extends RegisterStates {}
