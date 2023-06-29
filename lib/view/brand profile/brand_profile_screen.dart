// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors, no_logic_in_create_state, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../constants/product_card.dart';
import '../../models/AllCollectionsModel.dart';
import '../../models/AllProductsModel.dart';
import '../../models/BrandModel.dart';
import '../all collections/all_collections_screen.dart';
import '../all products/all_Brand_products_screen.dart';
import '../collection/collection_screen.dart';
import '../products by brand and category screen/products_by_brand_and_category_screen.dart';
import 'all_brand_reviews_screen.dart';

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

  var reviewController = TextEditingController();
  var final_rate;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async {
    setState(() {
      get = false;
      get_products = false;
      get_collections = false;
    });
    AppCubit.get(context)..GetBrandDetails(token: access_token, id: widget.brand_id)..GetProductsByBrand(token: access_token, page: "1", brand_id: brand_id)..GetCollectionsByBrand(token: access_token, brand_id: brand_id, page: 1);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    AppCubit.get(context)..GetBrandDetails(token: access_token, id: widget.brand_id)..GetProductsByBrand(token: access_token, page: "1", brand_id: brand_id)..GetCollectionsByBrand(token: access_token, brand_id: brand_id, page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
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
        if(state is AddBrandReviewSuccessState){
          Fluttertoast.showToast(
              msg: "Review Added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pop(context);
        }
        if(state is AddBrandReviewErrorState){
          Fluttertoast.showToast(
              msg: state.error.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state){
        return Scaffold(
          backgroundColor: white,
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            header: const WaterDropHeader(),
            child: ConditionalBuilder(
              condition: get && get_products && get_collections,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 400.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 250.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r), bottomRight: Radius.circular(40.r)),
                              image: DecorationImage(
                                  image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${brandModel!.data!.coverImage}'),
                                  fit: BoxFit.contain
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
                            child: CircleAvatar(
                              backgroundColor: secondaryOrange,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios, color: depOrange,),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 210.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
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


                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Text(brandModel!.data!.name!.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(brandModel!.data!.phone!.toString().split("[").last.split("]").first, style: TextStyle(fontSize: 16.sp),),

                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: ((context) => AllBrandReviewsScreen(brand_id))));
                                      },
                                        child: Text("See All Reviews (${brandModel!.data!.numberOfReviews})", style: TextStyle(fontSize: 16.sp, color: depOrange),)),
                                  ],
                                ),

                                SizedBox(height: 10.h,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        AppCubit.get(context).LikeBrand(token: access_token, id: brand_id);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.r),
                                          color: secondaryOrange,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                                          child: state is LikeBrandLoadingState ? const CircularProgressIndicator(color: depOrange,) : Text(
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
                                    InkWell(
                                      onTap: (){
                                        showModalBottomSheet(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r),),
                                          backgroundColor: Colors.white,
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContextcontext) => Padding(
                                            padding: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w, bottom: 20.h),
                                            child: SizedBox(
                                              height: 400.h,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Review ${brandModel!.data!.name!}",
                                                    style: TextStyle(
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                       height: 15.h,
                                                  ),
                                                  Material(
                                                    elevation: 10,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                    child: Container(
                                                      width: 195.w,
                                                      height: 130.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15.r),
                                                        image: brandModel!.data!.image != null ? DecorationImage(
                                                          image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${brandModel!.data!.image}'),
                                                          fit: BoxFit.cover,
                                                        ) : const DecorationImage(
                                                          image: AssetImage('assets/images/zara_logo.png'),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 0,
                                                    minRating: 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    glow: false,
                                                    itemSize: 40.sp,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
                                                    itemBuilder: (context, _) => const Icon(
                                                        Icons.star,
                                                        color: depOrange),
                                                    onRatingUpdate: (rating) {
                                                      final_rate = rating;
                                                      },
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  TextFormField(
                                                    controller: reviewController,
                                                    keyboardType: TextInputType.emailAddress,
                                                    cursorColor: depOrange,
                                                    minLines: 3,
                                                    maxLines: 10,
                                                    decoration: InputDecoration(
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10.r),
                                                        borderSide: const BorderSide(color: depOrange,),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10.r),
                                                        borderSide: BorderSide(color: Colors.grey, width: 2.0.w,),
                                                      ),
                                                      contentPadding: EdgeInsets.only(left: 25.w, top: 20.h, bottom: 20.h, right: 10.w),
                                                      hintText: "Write Your Review",
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: const Color.fromRGBO(134, 129, 124, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child:
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        AppCubit.get(context).AddBrandReview(token: access_token, brand_id: brand_id, rate: final_rate, comment: reviewController.text);
                                                      },
                                                      style: ButtonStyle(
                                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r))),
                                                        side: MaterialStateProperty.all(const BorderSide(color: depOrange)),
                                                      ),
                                                      child:
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 15.h),
                                                        child: state is AddBrandReviewLoadingState ? const CircularProgressIndicator(color: depOrange,) : Text(
                                                          "Confirm",
                                                          style: TextStyle(
                                                              fontSize: 17.sp,
                                                              color: depOrange),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.r),
                                          color: secondaryOrange,
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
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
                        height: 150.h,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => ProductsByBrandAndCategoryScreen(brandModel!.data!.categoryList![index].id, brandModel!.data!.categoryList![index].name, brandModel!.data!.id))));
                            },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: 150.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    image: DecorationImage(
                                        image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${brandModel!.data!.categoryList![index].image.toString()}'),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: SizedBox(
                                    width: 115.w,
                                    child: Text(
                                      brandModel!.data!.categoryList![index].name.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: depOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => AllBrandProductsScreen(brandModel!.data!.id))));
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
          ),
        );
      },
    );
  }
}
