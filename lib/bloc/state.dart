import '../models/LoginModel.dart';
import '../models/RegisterModel.dart';

abstract class AppStates {}

class InitialState extends AppStates {}

class ChangePasswordVisibilityState extends AppStates {}

class LoginLoadingState extends AppStates {}

class LoginSuccessState extends AppStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends AppStates {
  final String error;
  LoginErrorState(this.error);
}


class RegisterLoadingState extends AppStates {}

class RegisterSuccessState extends AppStates {
  final RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends AppStates {
  final String error;
  RegisterErrorState(this.error);
}