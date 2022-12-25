import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pavane/bloc/state.dart';

import '../dio/dio_helper.dart';
import '../models/AllCategoriesModel.dart';
import '../models/AllProductsModel.dart';
import '../models/LoginModel.dart';
import '../models/ProductModel.dart';
import '../models/RegisterModel.dart';
import '../models/UserModel.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  LoginModel? loginModel;

  void Login({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'loginUser',
      data:{
        'email' : email,
        'password' : password,
      },
    ).then((value)
    {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }
    ).catchError((error)
    {
      emit(LoginErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  RegisterModel? registerModel;

  void Register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String dateOfBirth,
    required String gender,
    required String location,
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'addUser',
      data:{
        "name" : name,
        "email" : email,
        "password" : password,
        "phone" : phone,
        "dateOfBirth" : dateOfBirth,
        "gender" : gender,
        "location" : location
      },
    ).then((value)
    {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }
    ).catchError((error)
    {
      emit(RegisterErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  UserModel? userModel;

  void GetUserData({
    required String token,
  })
  {
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: 'getUser',
      token: token,
    ).then((value)
    {
      userModel = UserModel.fromJson(value.data);
      emit(GetUserDataSuccessState(userModel!));
    }
    ).catchError((error)
    {
      emit(GetUserDataErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  AllCategoriesModel? allCategoriesModel;

  void GetAllCategories({
    required String token,
    required String page,
  })
  {
    emit(GetAllCategoriesLoadingState());
    DioHelper.getData(
      url: 'getAllCategories?page=$page&size=10',
      token: token,
    ).then((value)
    {
      allCategoriesModel = AllCategoriesModel.fromJson(value.data);
      emit(GetAllCategoriesSuccessState(allCategoriesModel!));
    }
    ).catchError((error)
    {
      emit(GetAllCategoriesErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllProductsModel? allProductsModel;

  void GetAllProducts({
    required String token,
    required String page,
  })
  {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: 'getAllProducts?page=$page&size=10',
      token: token,
    ).then((value)
    {
      allProductsModel = AllProductsModel.fromJson(value.data);
      emit(GetAllProductsSuccessState(allProductsModel!));
    }
    ).catchError((error)
    {
      emit(GetAllProductsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  ProductModel? productModel;

  void GetProduct({
    required String token,
    required String id,
  })
  {
    emit(GetProductLoadingState());
    DioHelper.getData(
      url: 'getProductById/:$id',
      token: token,
    ).then((value)
    {
      productModel = ProductModel.fromJson(value.data);
      emit(GetProductSuccessState(productModel!));
    }
    ).catchError((error)
    {
      emit(GetProductErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

}