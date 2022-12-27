import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../models/BrandModel.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetBrandDetails(token: access_token, id: widget.brand_id),
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
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: white,
            body: ConditionalBuilder(
              condition: get,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r), bottomRight: Radius.circular(40.r)),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/test.png"),
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
                                  image: NetworkImage(brandModel!.data!.image.toString()),
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 370.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.r),
                            image: const DecorationImage(
                                image: AssetImage("assets/images/Mask Group 5.png"),
                                fit: BoxFit.cover
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(25.0.r),
                            child: Text(
                              'Offers',
                              style: TextStyle(
                                  color: depOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w,),
                        SizedBox(
                          height: 365.h,
                          width: 170.w,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(45.r),
                              child: Container(
                                height: 190.h,
                                width: 170.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.r),
                                  image: DecorationImage(
                                      image: NetworkImage(brandModel!.data!.categoryList![index].image.toString()),
                                      fit: BoxFit.cover
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 130.h),
                                  child: Center(
                                    child: Text(
                                      brandModel!.data!.categoryList![index].name.toString(),
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
                            separatorBuilder: (context, index) => SizedBox(height: 20.w,),
                            itemCount: brandModel!.data!.categoryList!.length,
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ],
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
