// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../constants/product_card.dart';
import '../../models/LikedBrandsModel.dart';
import '../../models/LikedCollectionsModel.dart';
import '../../models/LikedProductsModel.dart';
import '../brand profile/brand_profile_screen.dart';
import '../collection/collection_screen.dart';

class LikesScreen extends StatefulWidget {

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {

  var access_token = CacheHelper.getData(key: 'access_token');

  LikedBrandsModel? likedBrandsModel;
  bool get_liked_brands = false;

  LikedCollectionsModel? likedCollectionsModel;
  bool get_liked_collections = false;

  LikedProductsModel? likedProductsModel;
  bool get_liked_products = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetLikedCollections(token: access_token)..GetLikedProducts(token: access_token)..GetLikedBrands(token: access_token),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state){
            if(state is GetLikedCollectionsSuccessState){
              likedCollectionsModel = state.likedCollectionsModel;
              get_liked_collections = true;
            }
            if(state is GetLikedProductsSuccessState){
              likedProductsModel = state.likedProductsModel;
              get_liked_products = true;
            }
            if(state is GetLikedBrandsSuccessState){
              likedBrandsModel = state.likedBrandsModel;
              get_liked_brands = true;
            }
          },
          builder: (context, state) => Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: depOrange,
              ),
              title: Text(
                'Likes',
                style: TextStyle(
                    color: depOrange,
                    fontSize: 35.sp,
                    fontFamily: "Roller"
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
              child: ConditionalBuilder(
                condition: get_liked_collections && get_liked_brands && get_liked_products,
                fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
                builder: (context) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Collections",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: SizedBox(
                          height: 115.h,
                          child: ConditionalBuilder(
                            condition: likedCollectionsModel!.likedCollections!.isNotEmpty,
                            fallback: (context) => Center(child: Text("No Liked Collections Added Yet", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),)),
                            builder: (context) => ListView.separated(
                              itemBuilder: (context, index) => InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: ((context) => CollectionScreen(likedCollectionsModel!.likedCollections![index].id))));
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
                                            image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${likedCollectionsModel!.likedCollections![index].image}'),
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
                                        likedCollectionsModel!.likedCollections![index].name!.length > 20 ? likedCollectionsModel!.likedCollections![index].name!.toString().substring(0, 20) : likedCollectionsModel!.likedCollections![index].name.toString(),
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
                              itemCount: likedCollectionsModel!.likedCollections!.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        "Products",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: SizedBox(
                          height: 200.h,
                          child: ConditionalBuilder(
                            condition: likedProductsModel!.likedItems!.isNotEmpty,
                            fallback: (context) => Center(child: Text("No Liked Products Added Yet", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),)),
                            builder: (context) => ListView.separated(
                              itemBuilder: (context, index) => CardBuilder(context: context, image: likedProductsModel!.likedItems![index].images![0].toString(), name: likedProductsModel!.likedItems![index].name.toString(), price: likedProductsModel!.likedItems![index].price.toString(), rate: likedProductsModel!.likedItems![index].averageRate.toString(), id: likedProductsModel!.likedItems![index].id.toString(), brand: likedProductsModel!.likedItems![index].brandId!.toString()),
                              separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                              itemCount: likedProductsModel!.likedItems!.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        "Brands",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: SizedBox(
                          height: 90.h,
                          child: ConditionalBuilder(
                            condition: likedBrandsModel!.likedBrands!.isNotEmpty,
                            fallback: (context) => Center(child: Text("No Liked Brands Added Yet", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),)),
                            builder: (context) => ListView.separated(
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: ((context) => BrandProfileScreen(likedBrandsModel!.likedBrands![index].id.toString()))));
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.r),
                                    elevation: 3,
                                    child: Container(
                                      width: 170.w,
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        image: DecorationImage(
                                            image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${likedBrandsModel!.likedBrands![index].image}'),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) => SizedBox(width: 15.w,),
                              itemCount: likedBrandsModel!.likedBrands!.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
