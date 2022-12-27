import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pavane/bloc/state.dart';
import '../dio/dio_helper.dart';
import '../models/AllBrandsModel.dart';
import '../models/AllCategoriesModel.dart';
import '../models/AllCollectionsModel.dart';
import '../models/AllProductsModel.dart';
import '../models/BrandModel.dart';
import '../models/LikedBrandsModel.dart';
import '../models/LikedCollectionsModel.dart';
import '../models/LikedProductsModel.dart';
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
      url: 'loginCustomer',
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
      url: 'addCustomer',
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
      url: 'getCustomer',
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
      url: 'getAllItems?page=$page&size=10',
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
      url: 'getItemById/$id',
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


  void LikeProduct({
    required String token,
    required String id,
  })
  {
    emit(LikeProductLoadingState());
    DioHelper.getData(
      url: 'likeItem/$id',
      token: token,
    ).then((value)
    {
      emit(LikeProductSuccessState());
    }
    ).catchError((error)
    {
      emit(LikeProductErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  AllProductsModel? PopularProductsModel;

  void GetPopularProducts({
    required String token,
  })
  {
    emit(GetPopularProductsLoadingState());
    DioHelper.getData(
      url: 'getMostLikedItems',
      token: token,
    ).then((value)
    {
      PopularProductsModel = AllProductsModel.fromJson(value.data);
      emit(GetPopularProductsSuccessState(PopularProductsModel!));
    }
    ).catchError((error)
    {
      emit(GetPopularProductsErrorState(error.toString()));
      print("******************************");
      print(error.toString());
      print("******************************");
    });
  }


  LikedProductsModel? likedProductsModel;

  void GetLikedProducts({
    required String token,
  })
  {
    emit(GetLikedProductsLoadingState());
    DioHelper.getData(
      url: 'getLikedItems',
      token: token,
    ).then((value)
    {
      likedProductsModel = LikedProductsModel.fromJson(value.data);
      emit(GetLikedProductsSuccessState(likedProductsModel!));
    }
    ).catchError((error)
    {
      emit(GetLikedProductsErrorState(error.toString()));
      print("******************************");
      print(error.toString());
      print("******************************");
    });
  }



  AllBrandsModel? popularBrandsModel;

  void GetPopularBrands({
    required String token,
  })
  {
    emit(GetPopularBrandsLoadingState());
    DioHelper.getData(
      url: 'getMostLikedBrands',
      token: token,
    ).then((value)
    {
      popularBrandsModel = AllBrandsModel.fromJson(value.data);
      emit(GetPopularBrandsSuccessState(popularBrandsModel!));
    }
    ).catchError((error)
    {
      emit(GetPopularBrandsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  LikedBrandsModel? likedBrandsModel;

  void GetLikedBrands({
    required String token,
  })
  {
    emit(GetLikedBrandsLoadingState());
    DioHelper.getData(
      url: 'getLikedBrands',
      token: token,
    ).then((value)
    {
      likedBrandsModel = LikedBrandsModel.fromJson(value.data);
      emit(GetLikedBrandsSuccessState(likedBrandsModel!));
    }
    ).catchError((error)
    {
      emit(GetLikedBrandsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  BrandModel? brandModel;


  void GetBrandDetails({
    required String token,
    required String id,
  })
  {
    emit(GetBrandDetailsLoadingState());
    DioHelper.getData(
      url: 'getBrandById/$id',
      token: token,
    ).then((value)
    {
      brandModel = BrandModel.fromJson(value.data);
      emit(GetBrandDetailsSuccessState(brandModel!));
    }
    ).catchError((error)
    {
      emit(GetBrandDetailsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  void LikeBrand({
    required String token,
    required String id,
  })
  {
    emit(LikeBrandLoadingState());
    DioHelper.getData(
      url: 'likeBrand/$id',
      token: token,
    ).then((value)
    {
      emit(LikeBrandSuccessState());
    }
    ).catchError((error)
    {
      emit(LikeBrandErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  AllCollectionsModel? popularCollectionsModel;

  void GetPopularCollections({
    required String token,
  })
  {
    emit(GetPopularCollectionsLoadingState());
    DioHelper.getData(
      url: 'getMostLikedCollections',
      token: token,
    ).then((value)
    {
      popularCollectionsModel = AllCollectionsModel.fromJson(value.data);
      emit(GetPopularCollectionsSuccessState(popularCollectionsModel!));
    }
    ).catchError((error)
    {
      emit(GetPopularCollectionsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  LikedCollectionsModel? likedCollectionsModel;

  void GetLikedCollections({
    required String token,
  })
  {
    emit(GetLikedCollectionsLoadingState());
    DioHelper.getData(
      url: 'getlikedCollections',
      token: token,
    ).then((value)
    {
      likedCollectionsModel = LikedCollectionsModel.fromJson(value.data);
      emit(GetLikedCollectionsSuccessState(likedCollectionsModel!));
    }
    ).catchError((error)
    {
      emit(GetLikedCollectionsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

}