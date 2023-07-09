// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pavane/bloc/state.dart';
import '../dio/dio_helper.dart';
import '../models/AdsModel.dart';
import '../models/AllBrandsModel.dart';
import '../models/AllCategoriesModel.dart';
import '../models/AllCollectionsModel.dart';
import '../models/AllNotificationModel.dart';
import '../models/AllProductsModel.dart';
import '../models/BrandModel.dart';
import '../models/CollectionModel.dart';
import '../models/FittingRoomItemsModel.dart';
import '../models/LikedBrandsModel.dart';
import '../models/LikedCollectionsModel.dart';
import '../models/LikedProductsModel.dart';
import '../models/LoginModel.dart';
import '../models/ProductModel.dart';
import '../models/RecommendationsModel.dart';
import '../models/RegisterModel.dart';
import '../models/ReviewModel.dart';
import '../models/SubscribeModel.dart';
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
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'loginCustomer',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
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
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'addCustomer',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "location": location
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  UserModel? userModel;

  void GetUserData({
    required String token,
  }) {
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: 'getCustomer',
      token: token,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(GetUserDataSuccessState(userModel!));
    }).catchError((error) {
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
  }) {
    emit(GetAllCategoriesLoadingState());
    DioHelper.getData(
      url: 'getAllCategories?page=$page&size=10',
      token: token,
    ).then((value) {
      allCategoriesModel = AllCategoriesModel.fromJson(value.data);
      emit(GetAllCategoriesSuccessState(allCategoriesModel!));
    }).catchError((error) {
      emit(GetAllCategoriesErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllProductsModel? allProductsModel;

  void GetAllProducts({
    required String token,
    required String page,
  }) {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: 'getAllItems?page=$page&size=10',
      token: token,
    ).then((value) {
      allProductsModel = AllProductsModel.fromJson(value.data);
      emit(GetAllProductsSuccessState(allProductsModel!));
    }).catchError((error) {
      emit(GetAllProductsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllProductsModel? ProductsByCatModel;

  void GetProductsByCat({
    required String token,
    required String page,
    required var cat_id,
  }) {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: 'getAllItemsWithFilter?categoryList=$cat_id&page=$page&size=10',
      token: token,
    ).then((value) {
      ProductsByCatModel = AllProductsModel.fromJson(value.data);
      emit(GetAllProductsSuccessState(ProductsByCatModel!));
    }).catchError((error) {
      emit(GetAllProductsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllProductsModel? ProductsByBrandModel;

  void GetProductsByBrand({
    required String token,
    required String page,
    required var brand_id,
  }) {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: 'getAllItemsWithFilter?brandId=$brand_id&page=$page&size=10',
      token: token,
    ).then((value) {
      ProductsByBrandModel = AllProductsModel.fromJson(value.data);
      emit(GetAllProductsSuccessState(ProductsByBrandModel!));
    }).catchError((error) {
      emit(GetAllProductsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllProductsModel? ProductsByBrandAndCatModel;

  void GetProductsByBrandAndCat({
    required String token,
    required String page,
    required var brand_id,
    required var cat_id,
  }) {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: 'getAllItemsWithFilter?brandId=$brand_id&categoryList=$cat_id&page=$page&size=10',
      token: token,
    ).then((value) {
      ProductsByBrandAndCatModel = AllProductsModel.fromJson(value.data);
      emit(GetAllProductsSuccessState(ProductsByBrandAndCatModel!));
    }).catchError((error) {
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
  }) {
    emit(GetProductLoadingState());
    DioHelper.getData(
      url: 'getItemById/$id',
      token: token,
    ).then((value) {
      productModel = ProductModel.fromJson(value.data);
      emit(GetProductSuccessState(productModel!));
    }).catchError((error) {
      emit(GetProductErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void LikeProduct({
    required String token,
    required String id,
  }) {
    emit(LikeProductLoadingState());
    DioHelper.getData(
      url: 'likeItem/$id',
      token: token,
    ).then((value) {
      emit(LikeProductSuccessState());
    }).catchError((error) {
      emit(LikeProductErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllProductsModel? PopularProductsModel;

  void GetPopularProducts({
    required String token,
  }) {
    emit(GetPopularProductsLoadingState());
    DioHelper.getData(
      url: 'getMostLikedItems',
      token: token,
    ).then((value) {
      PopularProductsModel = AllProductsModel.fromJson(value.data);
      emit(GetPopularProductsSuccessState(PopularProductsModel!));
    }).catchError((error) {
      emit(GetPopularProductsErrorState(error.toString()));
      print("******************************");
      print(error.toString());
      print("******************************");
    });
  }

  LikedProductsModel? likedProductsModel;

  void GetLikedProducts({
    required String token,
  }) {
    emit(GetLikedProductsLoadingState());
    DioHelper.getData(
      url: 'getLikedItems',
      token: token,
    ).then((value) {
      likedProductsModel = LikedProductsModel.fromJson(value.data);
      emit(GetLikedProductsSuccessState(likedProductsModel!));
    }).catchError((error) {
      emit(GetLikedProductsErrorState(error.toString()));
      print("******************************");
      print(error.toString());
      print("******************************");
    });
  }

  AllBrandsModel? popularBrandsModel;

  void GetPopularBrands({
    required String token,
  }) {
    emit(GetPopularBrandsLoadingState());
    DioHelper.getData(
      url: 'getMostLikedBrands',
      token: token,
    ).then((value) {
      popularBrandsModel = AllBrandsModel.fromJson(value.data);
      emit(GetPopularBrandsSuccessState(popularBrandsModel!));
    }).catchError((error) {
      emit(GetPopularBrandsErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllBrandsModel? allBrandsModel;

  void GetAllBrands({
    required String token,
    required var page,
  }) {
    emit(GetAllBrandsLoadingState());
    DioHelper.getData(
      url: 'getAllBrands?page=$page&size=10',
      token: token,
    ).then((value) {
      allBrandsModel = AllBrandsModel.fromJson(value.data);
      emit(GetAllBrandsSuccessState(allBrandsModel!));
    }).catchError((error) {
      emit(GetAllBrandsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  LikedBrandsModel? likedBrandsModel;

  void GetLikedBrands({
    required String token,
  }) {
    emit(GetLikedBrandsLoadingState());
    DioHelper.getData(
      url: 'getLikedBrands',
      token: token,
    ).then((value) {
      likedBrandsModel = LikedBrandsModel.fromJson(value.data);
      emit(GetLikedBrandsSuccessState(likedBrandsModel!));
    }).catchError((error) {
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
  }) {
    emit(GetBrandDetailsLoadingState());
    DioHelper.getData(
      url: 'getBrandById/$id',
      token: token,
    ).then((value) {
      brandModel = BrandModel.fromJson(value.data);
      emit(GetBrandDetailsSuccessState(brandModel!));
    }).catchError((error) {
      emit(
          GetBrandDetailsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void LikeBrand({
    required String token,
    required String id,
  }) {
    emit(LikeBrandLoadingState());
    DioHelper.getData(
      url: 'likeBrand/$id',
      token: token,
    ).then((value) {
      emit(LikeBrandSuccessState());
    }).catchError((error) {
      emit(LikeBrandErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllCollectionsModel? popularCollectionsModel;

  void GetPopularCollections({
    required String token,
  }) {
    emit(GetPopularCollectionsLoadingState());
    DioHelper.getData(
      url: 'getMostLikedCollections',
      token: token,
    ).then((value) {
      popularCollectionsModel = AllCollectionsModel.fromJson(value.data);
      emit(GetPopularCollectionsSuccessState(popularCollectionsModel!));
    }).catchError((error) {
      emit(GetPopularCollectionsErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllCollectionsModel? allCollectionsModel;

  void GetAllCollections({
    required String token,
    required var page,
  }) {
    emit(GetAllCollectionsLoadingState());
    DioHelper.getData(
      url: 'getAllCollections?page=$page&size=10',
      token: token,
    ).then((value) {
      allCollectionsModel = AllCollectionsModel.fromJson(value.data);
      emit(GetAllCollectionsSuccessState(allCollectionsModel!));
    }).catchError((error) {
      emit(GetAllCollectionsErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllCollectionsModel? collectionsByBrandModel;

  void GetCollectionsByBrand({
    required String token,
    required var brand_id,
    required var page,
  }) {
    emit(GetPopularCollectionsLoadingState());
    DioHelper.getData(
      url: 'getAllCollections?brandId=$brand_id&page=$page&size=10',
      token: token,
    ).then((value) {
      collectionsByBrandModel = AllCollectionsModel.fromJson(value.data);
      emit(GetPopularCollectionsSuccessState(collectionsByBrandModel!));
    }).catchError((error) {
      emit(GetPopularCollectionsErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  LikedCollectionsModel? likedCollectionsModel;

  void GetLikedCollections({
    required String token,
  }) {
    emit(GetLikedCollectionsLoadingState());
    DioHelper.getData(
      url: 'getlikedCollections',
      token: token,
    ).then((value) {
      likedCollectionsModel = LikedCollectionsModel.fromJson(value.data);
      emit(GetLikedCollectionsSuccessState(likedCollectionsModel!));
    }).catchError((error) {
      emit(GetLikedCollectionsErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  CollectionModel? collectionModel;

  void GetCollection({
    required String token,
    required var id,
  }) {
    emit(GetCollectionLoadingState());
    DioHelper.getData(
      url: 'getCollectionById/$id',
      token: token,
    ).then((value) {
      collectionModel = CollectionModel.fromJson(value.data);
      emit(GetCollectionSuccessState(collectionModel!));
    }).catchError((error) {
      emit(GetCollectionErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void LikeCollection({
    required String token,
    required String id,
  }) {
    emit(LikeCollectionLoadingState());
    DioHelper.getData(
      url: 'likeCollection/$id',
      token: token,
    ).then((value) {
      emit(LikeCollectionSuccessState());
    }).catchError((error) {
      emit(LikeCollectionErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllCollectionsModel? allCollectionsByCatModel;

  void GetAllCollectionsByCat({
    required String token,
    required var page,
    required var cat_id,
  }) {
    emit(GetAllCollectionsLoadingState());
    DioHelper.getData(
      url: 'getAllCollections?categoryList=$cat_id&page=$page&size=10',
      token: token,
    ).then((value) {
      allCollectionsByCatModel = AllCollectionsModel.fromJson(value.data);
      emit(GetAllCollectionsSuccessState(allCollectionsByCatModel!));
    }).catchError((error) {
      emit(GetAllCollectionsErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AllBrandsModel? allBrandsModelByCat;

  void GetAllBrandsBYCat({
    required String token,
    required var page,
    required var cat_id,
  }) {
    emit(GetAllBrandsLoadingState());
    DioHelper.getData(
      url: 'getAllBrands?categoryList=$cat_id&page=$page&size=10',
      token: token,
    ).then((value) {
      allBrandsModelByCat = AllBrandsModel.fromJson(value.data);
      emit(GetAllBrandsSuccessState(allBrandsModelByCat!));
    }).catchError((error) {
      emit(GetAllBrandsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  AdsModel? adsModel;

  void GetAds({
    required String token,
  }) {
    emit(GetAdsLoadingState());
    DioHelper.getData(
      url: 'getAllAdvertisement',
      token: token,
    ).then((value) {
      adsModel = AdsModel.fromJson(value.data);
      emit(GetAdsSuccessState(adsModel!));
    }).catchError((error) {
      emit(GetAdsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  ReviewModel? reviewModel;

  void GetProductReviews({
    required String token,
    required String id,
    var page = 1,
    var size = 10,
  }) {
    emit(GetProductReviewsLoadingState());
    DioHelper.getData(
      url: 'getAllItemReviews/$id?page=$page&size=$size',
      token: token,
    ).then((value) {
      reviewModel = ReviewModel.fromJson(value.data);
      emit(GetProductReviewsSuccessState(reviewModel!));
    }).catchError((error) {
      emit(GetProductReviewsErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void AddProductReview({
    required String token,
    required String product_id,
    required var rate,
    required String comment,
  }) {
    emit(AddProductReviewLoadingState());
    DioHelper.postData(
      url: 'addItemReview',
      token: token,
      data: {"rate": rate, "comment": comment, "itemId": product_id},
    ).then((value) {
      emit(AddProductReviewSuccessState());
    }).catchError((error) {
      emit(AddProductReviewErrorState(
          error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void AddBrandReview({
    required String token,
    required String brand_id,
    required var rate,
    required String comment,
  }) {
    emit(AddBrandReviewLoadingState());
    DioHelper.postData(
      url: 'addBrandReview',
      token: token,
      data: {"rate": rate, "comment": comment, "brandId": brand_id},
    ).then((value) {
      emit(AddBrandReviewSuccessState());
    }).catchError((error) {
      emit(AddBrandReviewErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void GetBrandReviews({
    required String token,
    required String id,
    var page = 1,
    var size = 10,
  }) {
    emit(GetBrandReviewsLoadingState());
    DioHelper.getData(
      url: 'getAllBrandReviews/$id?page=$page&size=$size',
      token: token,
    ).then((value) {
      reviewModel = ReviewModel.fromJson(value.data);
      emit(GetBrandReviewsSuccessState(reviewModel!));
    }).catchError((error) {
      emit(
          GetBrandReviewsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void GetAllSales({
    required String token,
    required var page,
  }) {
    emit(GetAllSalesLoadingState());
    DioHelper.getData(
      url: 'getAllSales?page=$page&size=10',
      token: token,
    ).then((value) {
      allCollectionsModel = AllCollectionsModel.fromJson(value.data);
      emit(GetAllSalesSuccessState(allCollectionsModel!));
    }).catchError((error) {
      emit(GetAllSalesErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void GetSale({
    required String token,
    required var id,
  }) {
    emit(GetSalesLoadingState());
    DioHelper.getData(
      url: 'getSaleById/$id',
      token: token,
    ).then((value) {
      collectionModel = CollectionModel.fromJson(value.data);
      emit(GetSalesSuccessState(collectionModel!));
    }).catchError((error) {
      emit(GetSalesErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void UploadUserImage({
    required String token,
    required var formData,
    required var id,
  }) {
    emit(UploadUserImageLoadingState());
    DioHelper.uploadData(
      url: 'uploadImageCustomer/$id',
      token: token,
      data: formData,
    ).then((value) {
      emit(UploadUserImageSuccessState());
    }).catchError((error) {
      emit(UploadUserImageErrorState(error.toString()));
      print("******************************");
      print(error.toString());
      print("******************************");
    });
  }

  void EditUserData({
    required String token,
    required var formData,
  }) {
    emit(EditUserDataLoadingState());
    DioHelper.putData(
      url: 'updateProfileCustomer',
      token: token,
      data: formData,
    ).then((value) {
      emit(EditUserDataSuccessState());
    }).catchError((error) {
      emit(EditUserDataErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  AllNotificationModel? allNotificationModel;

  void GetNotification({
    required String token,
  }) {
    emit(GetNotificationLoadingState());
    DioHelper.getData(
      url: 'getAllNotifications',
      token: token,
    ).then((value) {
      allNotificationModel = AllNotificationModel.fromJson(value.data);
      emit(GetNotificationSuccessState(allNotificationModel!));
    }).catchError((error) {
      emit(GetNotificationErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  SubscribeModel? subscribeModel;

  void Subscribe({
    required String token,
  }) {
    emit(SubscribeLoadingState());
    DioHelper.postData(
      url: 'subscribe',
      token: token,
      data: {},
    ).then((value) {
      subscribeModel = SubscribeModel.fromJson(value.data);
      emit(SubscribeSuccessState(subscribeModel!));
    }).catchError((error) {
      emit(SubscribeErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }


  RecommendationsModel? recommendationsModel;

  void GetRecommendations({
    required String token,
  }) {
    emit(GetRecommendationsLoadingState());
    DioHelper.getData(
      url: 'getRecommendation',
      token: token,
    ).then((value) {
      recommendationsModel = RecommendationsModel.fromJson(value.data);
      emit(GetRecommendationsSuccessState(recommendationsModel!));
    }).catchError((error) {
      emit(GetRecommendationsErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void AddToFittingRoom({
    required String token,
    required String id,
  }) {
    emit(AddToFittingRoomLoadingState());
    DioHelper.putData(
      url: 'selectItem/$id',
      token: token,
      data: {},
    ).then((value) {
      emit(AddToFittingRoomSuccessState());
    }).catchError((error) {
      emit(AddToFittingRoomErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  void RomoveFromFittingRoom({
    required String token,
    required String id,
  }) {
    emit(RomoveFromFittingRoomLoadingState());
    DioHelper.putData(
      url: 'removeItem/$id',
      token: token,
      data: {},
    ).then((value) {
      emit(RomoveFromFittingRoomSuccessState());
    }).catchError((error) {
      emit(RomoveFromFittingRoomErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

  FittingRoomItemsModel? fittingRoomItemsModel;

  void GetFittingRoom({
    required String token,
  }) {
    emit(GetFittingRoomLoadingState());
    DioHelper.getData(
      url: 'getSelectedItems',
      token: token,
    ).then((value) {
      fittingRoomItemsModel = FittingRoomItemsModel.fromJson(value.data);
      emit(GetFittingRoomSuccessState(fittingRoomItemsModel!));
    }).catchError((error) {
      emit(GetFittingRoomErrorState(error.response.data['message'].toString()));
      print("******************************");
      print(error.response.data.toString());
      print("******************************");
    });
  }

}
