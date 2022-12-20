import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pavane/bloc/state.dart';

import '../dio/dio_helper.dart';
import '../models/LoginModel.dart';
import '../models/RegisterModel.dart';

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
      emit(LoginErrorState(error.toString()));
      print("******************************");
      print(error.toString());
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
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'addUser',
      data:{
        "name" : "ahmed",
        "email" : "sameh7098@gmail.com",
        "password" : "123456789",
        "phone" : "01111058038",
        "dateOfBirth" : "2020-10-10",
        "gender" : "male",
        "location" : "alex"
      },
    ).then((value)
    {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }
    ).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
      print("******************************");
      print(error.toString());
      print("******************************");
    });
  }

}