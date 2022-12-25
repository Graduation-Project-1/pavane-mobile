import '../models/AllCategoriesModel.dart';
import '../models/AllProductsModel.dart';
import '../models/LoginModel.dart';
import '../models/ProductModel.dart';
import '../models/RegisterModel.dart';
import '../models/UserModel.dart';

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


class GetUserDataLoadingState extends AppStates {}

class GetUserDataSuccessState extends AppStates {
  final UserModel userModel;
  GetUserDataSuccessState(this.userModel);
}

class GetUserDataErrorState extends AppStates {
  final String error;
  GetUserDataErrorState(this.error);
}

class GetAllCategoriesLoadingState extends AppStates {}

class GetAllCategoriesSuccessState extends AppStates {
  final AllCategoriesModel allCategoriesModel;
  GetAllCategoriesSuccessState(this.allCategoriesModel);
}

class GetAllCategoriesErrorState extends AppStates {
  final String error;
  GetAllCategoriesErrorState(this.error);
}

class GetAllProductsLoadingState extends AppStates {}

class GetAllProductsSuccessState extends AppStates {
  final AllProductsModel allProductsModel;
  GetAllProductsSuccessState(this.allProductsModel);
}

class  GetAllProductsErrorState extends AppStates {
  final String error;
  GetAllProductsErrorState(this.error);
}

class GetProductLoadingState extends AppStates {}

class GetProductSuccessState extends AppStates {
  final ProductModel productModel;
  GetProductSuccessState(this.productModel);
}

class  GetProductErrorState extends AppStates {
  final String error;
  GetProductErrorState(this.error);
}