import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/constants/colors.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/product_card.dart';
import '../../models/ProductModel.dart';


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

  var access_token = CacheHelper.getData(key: 'access_token');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetProduct(token: access_token, id: product_id),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){
          if(state is GetProductSuccessState){
            productModel = state.productModel;
          }
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: white,
            body: ConditionalBuilder(
              condition: state is GetProductSuccessState,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/dress.png"),
                              fit: BoxFit.cover
                          ),
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
                              onPressed: (){},
                              icon: const ImageIcon(AssetImage("assets/images/heart_icon.png"),),
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
                                children: [
                                  Text(
                                    "Blue Dress",
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "H&M",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "500 L.E",
                                        style: TextStyle(
                                            fontSize: 20.sp
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text(
                                        "600 L.E",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: const Color.fromRGBO(137, 137, 137, 1),
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "4.5",
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
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(95, 95, 95, 1),
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              Text(
                                "Available Sizes",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              SizedBox(
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
                                        "S",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) => SizedBox(width: 15.w,),
                                  itemCount: 4,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              Text(
                                "Available Colors",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  itemBuilder: (context, index) => Container(
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) => SizedBox(width: 15.w,),
                                  itemCount: 4,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
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
                              SizedBox(height: 10.h,),
                              // SizedBox(
                              //   height: 180.h,
                              //   child: ListView.separated(
                              //     itemBuilder: (context, index) => CardBuilder(context: context),
                              //     separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                              //     itemCount: 10,
                              //     scrollDirection: Axis.horizontal,
                              //   ),
                              // ),
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
