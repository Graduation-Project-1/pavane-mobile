import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../constants/product_card.dart';
import '../../models/AllCollectionsModel.dart';
import '../../models/AllProductsModel.dart';
import '../../models/BrandModel.dart';
import '../all collections/all_collections_screen.dart';
import '../all products/all_products_screen.dart';
import '../collection/collection_screen.dart';
import '../products by brand and category screen/products_by_brand_and_category_screen.dart';

class BrandProfileScreen extends StatefulWidget {

  String brand_id;
  BrandProfileScreen(this.brand_id);

  @override
  State<BrandProfileScreen> createState() => _BrandProfileScreenState(brand_id);
}

class _BrandProfileScreenState extends State<BrandProfileScreen> {

  String brand_id;
  _BrandProfileScreenState(this.brand_id);

  var access_token = CacheHelper.getData(key: 'access_token');

  BrandModel? brandModel;
  bool get = false;
  AllProductsModel? allProductsModel;
  bool get_products = false;
  AllCollectionsModel? collectionsByBrandModel;
  bool get_collections = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetBrandDetails(token: access_token, id: widget.brand_id)..GetProductsByBrand(token: access_token, page: "1", brand_id: brand_id)..GetCollectionsByBrand(token: access_token, brand_id: brand_id, page: 1),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){
          if(state is GetBrandDetailsSuccessState){
            brandModel = state.brandModel;
            get = true;
          }
          if(state is LikeBrandSuccessState){
            Fluttertoast.showToast(
                msg: "Brand added to liked list",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          if(state is LikeBrandErrorState){
            Fluttertoast.showToast(
                msg: state.error.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          if(state is GetAllProductsSuccessState){
            allProductsModel = state.allProductsModel;
            get_products = true;
          }
          if(state is GetPopularCollectionsSuccessState){
            collectionsByBrandModel = state.allCollectionsModel;
            get_collections = true;
          }
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: white,
            body: ConditionalBuilder(
              condition: get && get_products && get_collections,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r), bottomRight: Radius.circular(40.r)),
                            image: DecorationImage(
                                image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${brandModel!.data!.coverImage}'),
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
                          child: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios, color: depOrange,),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 80.h),
                          child: Center(
                            child: Container(
                              width: 100.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.r),
                                image: DecorationImage(
                                    image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${brandModel!.data!.image}'),
                                    fit: BoxFit.cover
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 180.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  AppCubit.get(context).LikeBrand(token: access_token, id: brand_id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                                    child: Text(
                                      "Like",
                                      style: TextStyle(
                                          color: depOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.sp
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30.w,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                                  child: Text(
                                    "Review",
                                    style: TextStyle(
                                        color: depOrange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    collectionsByBrandModel!.data!.isEmpty ? Container() : Padding(
                      padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Collections",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => AllCollectionsScreen(brandModel!.data!.id))));
                            },
                            child: Text(
                              "SEE ALL",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                  color: depOrange
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (collectionsByBrandModel!.data!.isEmpty) Container() else Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 20.w),
                      child: SizedBox(
                        height: 115.h,
                        child: ConditionalBuilder(
                          condition: collectionsByBrandModel!.data != null,
                          fallback: (context) => const Center(child: Text("No Liked Collections Added Yet")),
                          builder: (context) => ListView.separated(
                            itemBuilder: (context, index) => InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => CollectionScreen(collectionsByBrandModel!.data![index].id))));
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 110.h,
                                    width: 170.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: DecorationImage(
                                          image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${collectionsByBrandModel!.data![index].image.toString()}'),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 110.h,
                                    width: 170.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      gradient: const LinearGradient(
                                        colors: [Color.fromRGBO(255, 255, 255, .42), Color.fromRGBO(128, 128, 128, .42)],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      collectionsByBrandModel!.data![index].name.toString().substring(0, 10),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                            itemCount: collectionsByBrandModel!.data!.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                    ),

                    brandModel!.data!.categoryList!.isEmpty ? Container() : Padding(
                      padding: EdgeInsets.only(top: 15.h, left: 20.w),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    brandModel!.data!.categoryList!.isEmpty ? Container() :  Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 20.w),
                      child: SizedBox(
                        height: 170.h,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => ProductsByBrandAndCategoryScreen(brandModel!.data!.categoryList![index].id, brandModel!.data!.categoryList![index].name, brandModel!.data!.id))));
                            },
                            child: Container(
                              height: 170.h,
                              width: 170.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45.r),
                                image: DecorationImage(
                                    image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${brandModel!.data!.categoryList![index].image.toString()}'),
                                    fit: BoxFit.cover
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 130.h, left: 5.w, right: 5.w),
                                child: Center(
                                  child: Text(
                                    brandModel!.data!.categoryList![index].name.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: depOrange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                          itemCount: brandModel!.data!.categoryList!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Items",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => AllProductsScreen(brandModel!.data!.id))));
                            },
                            child: Text(
                              "SEE ALL",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                  color: depOrange
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 20.w),
                      child: SizedBox(
                        height: 200.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) => CardBuilder(context: context, image: allProductsModel!.data![index].images![0].toString(), name: allProductsModel!.data![index].name.toString(), price: allProductsModel!.data![index].price.toString(), rate: allProductsModel!.data![index].averageRate.toString(), id: allProductsModel!.data![index].id.toString(), brand: allProductsModel!.data![index].brandId!.name.toString()),
                          separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                          itemCount: allProductsModel!.data!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
