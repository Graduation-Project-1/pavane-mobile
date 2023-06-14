// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, must_be_immutable, no_logic_in_create_state, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/view/library/library_screen.dart';

import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../constants/product_card.dart';
import '../../models/AllBrandsModel.dart';
import '../../models/AllCollectionsModel.dart';
import '../../models/AllProductsModel.dart';
import '../all products/all_cat_products_screen.dart';
import '../brand profile/brand_profile_screen.dart';
import '../collection/collection_screen.dart';

class CategoryScreen extends StatefulWidget {

  var id;
  var name;
  CategoryScreen(this.id, this.name);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState(id, name);
}

class _CategoryScreenState extends State<CategoryScreen> {

  var id;
  var name;
  _CategoryScreenState(this.id, this.name);

  AllProductsModel? productsByCatModel;
  bool product = false;
  AllCollectionsModel? allCollectionsByCatModel;
  bool collection = false;
  AllBrandsModel? allBrandsModelByCat;
  bool brand = false;

  var access_token = CacheHelper.getData(key: 'access_token');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetProductsByCat(token: access_token, page: '1', cat_id: id)..GetAllCollectionsByCat(token: access_token, page: '1', cat_id: id)..GetAllBrandsBYCat(token: access_token, page: '1', cat_id: id),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){
          if(state is GetAllProductsSuccessState){
            productsByCatModel = state.allProductsModel;
            product = true;
          }
          if(state is GetAllCollectionsSuccessState){
            allCollectionsByCatModel = state.allCollectionsModel;
            collection = true;
          }
          if(state is GetAllBrandsSuccessState){
            allBrandsModelByCat = state.allBrandsModel;
            brand = true;
          }
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: depOrange,
              ),
              title: Text(
                name,
                style: TextStyle(
                    color: depOrange,
                    fontSize: 35.sp,
                    fontFamily: "Roller"
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: product && collection && brand,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 10.h, right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Products",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => AllCatProductsScreen(widget.id))));
                              },
                              child: Text(
                                "SEE ALL",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: depOrange),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                        child: productsByCatModel!.data!.isEmpty ? const Center(child: Text("No Products Found")) : ListView.separated(
                          itemBuilder: (context, index) => CardBuilder
                            (context: context,
                              image: productsByCatModel!.data![index].images![0].toString(),
                              name: productsByCatModel!.data![index].name.toString(),
                              price: productsByCatModel!.data![index].price.toString(),
                              rate: productsByCatModel!.data![index].averageRate.toString(),
                              id: productsByCatModel!.data![index].id.toString(),
                              brand: productsByCatModel!.data![index].brandId!.name.toString(),
                          ),
                          separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                          itemCount: productsByCatModel!.data!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),

                      SizedBox(height: 15.h,),

                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Text(
                          "Brands",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: SizedBox(
                          height: 125.h,
                          child: allBrandsModelByCat!.data!.isEmpty ? const Center(child: Text("No Brands Found")) : ListView.separated(
                            itemBuilder: (context, index) =>  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: ((context) => BrandProfileScreen(allBrandsModelByCat!.data![index].id.toString()))));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10.r),
                                  elevation: 3,
                                  child: Container(
                                    width: 200.w,
                                    height: 125.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: DecorationImage(
                                          image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${allBrandsModelByCat!.data![index].image}'),
                                          fit: BoxFit.contain
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                            itemCount: allBrandsModelByCat!.data!.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),

                      SizedBox(height: 15.h,),

                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Text(
                          "Collections",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: SizedBox(
                          height: 125.h,
                          child: allCollectionsByCatModel!.data!.isEmpty ? const Center(child: Text("No Collections Found")) : ListView.separated(
                            itemBuilder: (context, index) => InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => CollectionScreen(allCollectionsByCatModel!.data![index].id))));
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 125.h,
                                    width: 190.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: DecorationImage(
                                          image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${allCollectionsByCatModel!.data![index].image}'),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 125.h,
                                    width: 190.w,
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
                                      allCollectionsByCatModel!.data![index].name!.length > 20 ? allCollectionsByCatModel!.data![index].name!.toString().substring(0, 20) : allCollectionsByCatModel!.data![index].name.toString(),
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
                            itemCount: allCollectionsByCatModel!.data!.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),

                      SizedBox(height: 15.h,),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
