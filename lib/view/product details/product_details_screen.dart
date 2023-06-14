// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pavane/constants/colors.dart';
import 'package:readmore/readmore.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/product_card.dart';
import '../../models/AllProductsModel.dart';
import '../../models/ProductModel.dart';
import '../../models/ReviewModel.dart';
import 'all_product_reviews_screen.dart';


class ProductDetailsScreen extends StatefulWidget {

  String product_id;
  ProductDetailsScreen(this.product_id);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState(product_id);
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  String product_id;
  _ProductDetailsScreenState(this.product_id);
  ProductModel? productModel;
  bool get_details = false;
  AllProductsModel? allProductsModel;
  bool get_products = false;
  ReviewModel? reviewsModel;
  bool get_reviews = false;

  var reviewController = TextEditingController();
  var final_rate;

  var access_token = CacheHelper.getData(key: 'access_token');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetProduct(token: access_token, id: product_id)..GetAllProducts(token: access_token, page: "1")..GetProductReviews(token: access_token, id: product_id),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){
          if(state is GetProductSuccessState){
            productModel = state.productModel;
            get_details = true;
          }
          if(state is GetAllProductsSuccessState){
            allProductsModel = state.allProductsModel;
            get_products = true;
          }
          if(state is GetProductReviewsSuccessState){
            reviewsModel = state.reviewModel;
            get_reviews = true;
          }
          if(state is LikeProductSuccessState){
            Fluttertoast.showToast(
                msg: "Product added to liked list",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          if(state is LikeProductErrorState){
            Fluttertoast.showToast(
                msg: state.error.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          if(state is AddProductReviewSuccessState){
            Fluttertoast.showToast(
                msg: "Review Added",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          if(state is AddProductReviewErrorState){
            Fluttertoast.showToast(
                msg: state.error.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: white,
            body: ConditionalBuilder(
              condition: get_details && get_products && get_reviews,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 300.h,
                        width: double.infinity,
                        child: Carousel(
                          dotSize: 0,
                          dotSpacing: 0,
                          radius: Radius.circular(20.r),
                          borderRadius: true,
                          showIndicator: false,
                          dotPosition: DotPosition.bottomCenter,
                          images: [
                            for(int i =0 ; i < productModel!.data!.images!.length; i++)
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(productModel!.data!.images![i].toString()),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).LikeProduct(token: access_token, id: product_id);
                              },
                              icon: const Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 270.h),
                    child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      productModel!.data!.name.toString(),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    productModel!.data!.brandId!.name.toString(),
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${productModel!.data!.price} L.E",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        productModel!.data!.averageRate.toString().length > 3 ?productModel!.data!.averageRate.toString().substring(0, 3) : productModel!.data!.averageRate.toString() ,
                                        style: TextStyle(
                                            color: depOrange,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.sp
                                        ),
                                      ),
                                      const Icon(Icons.star, color: depOrange,),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(height: 10.h,),

                              ReadMoreText(
                                productModel!.data!.description.toString(),
                                trimLines: 5,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: depOrange),
                                lessStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: depOrange),
                              ),
                              SizedBox(height: 15.h,),
                              productModel!.data!.sizes!.isEmpty? Container() : Text(
                                "Available Sizes",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              productModel!.data!.sizes!.isEmpty? Container() :  SizedBox(height: 10.h,),
                              productModel!.data!.sizes!.isEmpty? Container() :   SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  itemBuilder: (context, index) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: const Color.fromRGBO(112, 112, 112, 1),),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                      child: Text(
                                        productModel!.data!.sizes![index].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) => SizedBox(width: 15.w,),
                                  itemCount: productModel!.data!.sizes!.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Reviews",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 20.sp),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: ((context) => AllProductReviewsScreen(product_id))));
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

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: ListView.separated(
                                  itemBuilder: (context, index) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(radius: 13.r, backgroundColor: Colors.grey, child: const Icon(Icons.person, color: Colors.white,),),
                                              SizedBox(width: 10.w,),
                                              Text(reviewsModel!.data![index].customerId!.name!.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                reviewsModel!.data![index].rate!.toString(),
                                                style: TextStyle(
                                                    color: depOrange,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp
                                                ),
                                              ),
                                              Icon(Icons.star, color: depOrange, size: 20.sp,),
                                            ],
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(reviewsModel!.data![index].comment!.toString()),
                                      ),
                                    ],
                                  ),
                                  separatorBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Container(height: 1.h, width: double.infinity, color: Colors.grey.shade300,),
                                  ),
                                  itemCount: reviewsModel!.data!.length > 5 ? 5 : reviewsModel!.data!.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                              ),

                              SizedBox(height: 15.h,),
                              Text(
                                "Add Review",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                                child: RatingBar.builder(
                                  initialRating: 0,
                                  minRating: .5,
                                  glow: false,
                                  itemSize: 25,
                                  ignoreGestures: false,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: depOrange,
                                  ),
                                  onRatingUpdate: (value) {
                                    final_rate = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                                child: TextFormField(
                                  controller: reviewController,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: depOrange,
                                  minLines: 3,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: depOrange,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0.w,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 25.w, top: 20.h, bottom: 20.h, right: 10.w),
                                    hintText: "Write Review",
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color.fromRGBO(134, 129, 124, 1),
                                        fontFamily: "Open_Sans"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Center(
                                child: OutlinedButton(
                                  onPressed: () {
                                    AppCubit.get(context).AddProductReview(token: access_token, product_id: product_id, rate: final_rate, comment: reviewController.text);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0.r))),
                                    side: MaterialStateProperty.all(const BorderSide(
                                      color: depOrange,
                                    )),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 120.w, vertical: 10.h),
                                    child: state is AddProductReviewLoadingState? const CircularProgressIndicator(color: depOrange,) : Text(
                                      "Confirm",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontFamily: "Open_Sans",
                                        color: depOrange,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 15.h,),
                              Text(
                                "Similar Products",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: SizedBox(
                                  height: 200.h,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) => CardBuilder(context: context, image: allProductsModel!.data![index].images![0].toString(), name: allProductsModel!.data![index].name.toString(), price: allProductsModel!.data![index].price.toString(), rate: "4.5", id: allProductsModel!.data![index].id.toString(), brand: allProductsModel!.data![index].brandId!.name.toString()),
                                    separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                                    itemCount: allProductsModel!.data!.length,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
