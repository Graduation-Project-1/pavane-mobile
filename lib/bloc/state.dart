import '../models/AllBrandsModel.dart';
import '../models/AllCategoriesModel.dart';
import '../models/AllCollectionsModel.dart';
import '../models/AllProductsModel.dart';
import '../models/BrandModel.dart';
import '../models/CollectionModel.dart';
import '../models/LikedBrandsModel.dart';
import '../models/LikedCollectionsModel.dart';
import '../models/LikedProductsModel.dart';
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

class LikeProductLoadingState extends AppStates {}

class LikeProductSuccessState extends AppStates {}

class  LikeProductErrorState extends AppStates {
  final String error;
  LikeProductErrorState(this.error);
}

class GetPopularProductsLoadingState extends AppStates {}

class GetPopularProductsSuccessState extends AppStates {
  final AllProductsModel allProductsModel;
  GetPopularProductsSuccessState(this.allProductsModel);
}

class  GetPopularProductsErrorState extends AppStates {
  final String error;
  GetPopularProductsErrorState(this.error);
}

class GetLikedProductsLoadingState extends AppStates {}

class GetLikedProductsSuccessState extends AppStates {
  final LikedProductsModel likedProductsModel;
  GetLikedProductsSuccessState(this.likedProductsModel);
}

class  GetLikedProductsErrorState extends AppStates {
  final String error;
  GetLikedProductsErrorState(this.error);
}

class GetPopularBrandsLoadingState extends AppStates {}

class GetPopularBrandsSuccessState extends AppStates {
  final AllBrandsModel allBrandsModel;
  GetPopularBrandsSuccessState(this.allBrandsModel);
}

class  GetPopularBrandsErrorState extends AppStates {
  final String error;
  GetPopularBrandsErrorState(this.error);
}


class GetAllBrandsLoadingState extends AppStates {}

class GetAllBrandsSuccessState extends AppStates {
  final AllBrandsModel allBrandsModel;
  GetAllBrandsSuccessState(this.allBrandsModel);
}

class  GetAllBrandsErrorState extends AppStates {
  final String error;
  GetAllBrandsErrorState(this.error);
}

class GetLikedBrandsLoadingState extends AppStates {}

class GetLikedBrandsSuccessState extends AppStates {
  final LikedBrandsModel likedBrandsModel;
  GetLikedBrandsSuccessState(this.likedBrandsModel);
}

class  GetLikedBrandsErrorState extends AppStates {
  final String error;
  GetLikedBrandsErrorState(this.error);
}

class GetBrandDetailsLoadingState extends AppStates {}

class GetBrandDetailsSuccessState extends AppStates {
  final BrandModel brandModel;
  GetBrandDetailsSuccessState(this.brandModel);
}

class  GetBrandDetailsErrorState extends AppStates {
  final String error;
  GetBrandDetailsErrorState(this.error);
}

class LikeBrandLoadingState extends AppStates {}

class LikeBrandSuccessState extends AppStates {}

class  LikeBrandErrorState extends AppStates {
  final String error;
  LikeBrandErrorState(this.error);
}

class GetPopularCollectionsLoadingState extends AppStates {}

class GetPopularCollectionsSuccessState extends AppStates {
  final AllCollectionsModel allCollectionsModel;
  GetPopularCollectionsSuccessState(this.allCollectionsModel);
}

class  GetPopularCollectionsErrorState extends AppStates {
  final String error;
  GetPopularCollectionsErrorState(this.error);
}

class GetLikedCollectionsLoadingState extends AppStates {}

class GetLikedCollectionsSuccessState extends AppStates {
  final LikedCollectionsModel likedCollectionsModel;
  GetLikedCollectionsSuccessState(this.likedCollectionsModel);
}

class  GetLikedCollectionsErrorState extends AppStates {
  final String error;
  GetLikedCollectionsErrorState(this.error);
}

class GetAllCollectionsLoadingState extends AppStates {}

class GetAllCollectionsSuccessState extends AppStates {
  final AllCollectionsModel allCollectionsModel;
  GetAllCollectionsSuccessState(this.allCollectionsModel);
}

class  GetAllCollectionsErrorState extends AppStates {
  final String error;
  GetAllCollectionsErrorState(this.error);
}


class GetCollectionLoadingState extends AppStates {}

class GetCollectionSuccessState extends AppStates {
  final CollectionModel collectionModel;
  GetCollectionSuccessState(this.collectionModel);
}

class  GetCollectionErrorState extends AppStates {
  final String error;
  GetCollectionErrorState(this.error);
}

class LikeCollectionLoadingState extends AppStates {}

class LikeCollectionSuccessState extends AppStates {}

class  LikeCollectionErrorState extends AppStates {
  final String error;
  LikeCollectionErrorState(this.error);
}