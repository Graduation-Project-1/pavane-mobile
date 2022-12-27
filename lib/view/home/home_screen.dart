import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../constants/product_card.dart';
import '../../models/AllBrandsModel.dart';
import '../../models/AllCategoriesModel.dart';
import '../../models/AllCollectionsModel.dart';
import '../../models/AllProductsModel.dart';
import '../../models/UserModel.dart';
import '../all categories/all_categories_screen.dart';
import '../brand profile/brand_profile_screen.dart';
import '../notification/notification_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> list =['assets/images/Group 62.png', 'assets/images/Group 62.png', 'assets/images/Group 62.png'];
  UserModel? userModel;
  bool get_user = false;
  AllCategoriesModel? allCategoriesModel;
  bool get_cat = false;
  AllProductsModel? allProductsModel;
  bool get_products = false;
  AllProductsModel? PopularProductsModel;
  bool get_popular_products = false;
  AllBrandsModel? popularBrandsModel;
  bool get_popular_brands = false;
  AllCollectionsModel? popularCollectionsModel;
  bool get_popular_collections = false;

  var access_token = CacheHelper.getData(key: 'access_token');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetUserData(token: access_token)..GetAllCategories(token: access_token, page: "1")..GetAllProducts(token: access_token, page: "1")..GetPopularBrands(token: access_token)..GetPopularCollections(token: access_token),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){
          if(state is GetUserDataSuccessState){
            userModel = state.userModel;
            get_user = true;
          }
          if(state is GetAllCategoriesSuccessState){
            allCategoriesModel = state.allCategoriesModel;
            get_cat = true;
          }
          if(state is GetAllProductsSuccessState){
            allProductsModel = state.allProductsModel;
            get_products = true;
          }
          if(state is GetPopularProductsSuccessState){
            PopularProductsModel = state.allProductsModel;
            get_popular_products = true;
          }
          if(state is GetPopularBrandsSuccessState){
            popularBrandsModel = state.allBrandsModel;
            get_popular_brands = true;
          }
          if(state is GetPopularCollectionsSuccessState){
            popularCollectionsModel = state.allCollectionsModel;
            get_popular_collections = true;
          }
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0,
              title: Image.asset('assets/images/title.png', scale: 4.sp,),
              leadingWidth: 75.w,
              leading: Padding(
                padding:  EdgeInsets.only(left: 20.w),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => NotificationScreen())));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: gray,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.notifications_none, color: black, size: 30.sp,),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding:  EdgeInsets.only(right: 20.w),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => SearchScreen())));
                    },
                    child: Container(
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: gray,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(Icons.search, color: black, size: 30.sp,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: get_user && get_cat && get_products && get_popular_brands && get_popular_collections,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Hello ${userModel!.data!.name!.split(" ").first.toString()}!",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 15.h),
                        child: Text(
                          "Lets gets somethings?",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(98, 98, 98, 1),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 20.w, bottom: 15.w),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            height: 130.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Carousel(
                              dotSize: 0,
                              dotSpacing: 0,
                              radius: Radius.circular(20.r),
                              borderRadius: true,
                              showIndicator: false,
                              dotPosition: DotPosition.bottomCenter,
                              images: [
                                for(int i =0 ; i < list.length; i++)
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(list[i]),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 20.w, bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Top Categories",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => AllCategoriesScreen())));
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
                      SizedBox(
                        height: 80.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) => Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(allCategoriesModel!.data![index].image.toString()),
                                radius: 30.r,
                              ),
                              Text(
                                allCategoriesModel!.data![index].name.toString(),
                                style: TextStyle(
                                    fontSize: 15.sp
                                ),
                              ),
                            ],
                          ),
                          separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                          itemCount: allCategoriesModel!.data!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                        child: Text(
                          "All Products",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 175.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) => CardBuilder(context: context, image: allProductsModel!.data![index].cover.toString(), name: allProductsModel!.data![index].name.toString(), price: allProductsModel!.data![index].price.toString(), rate: allProductsModel!.data![index].averageRate.toString(), id: allProductsModel!.data![index].id.toString(), brand: allProductsModel!.data![index].brandId!.name.toString()),
                          separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                          itemCount: allProductsModel!.data!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),

                      SizedBox(height: 15.h,),

                      Text(
                        "Popular Brands",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                        child: SizedBox(
                          height: 85.h,
                          child: ListView.separated(
                            itemBuilder: (context, index) =>  InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => BrandProfileScreen(popularBrandsModel!.data![index].id.toString()))));
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Container(
                                  width: 170.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                        image: NetworkImage(popularBrandsModel!.data![index].image.toString()),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                            itemCount: popularBrandsModel!.data!.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),

                      // Text(
                      //   "Popular Products",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 20.sp
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                      //   child: SizedBox(
                      //     height: 180.h,
                      //     child: ListView.separated(
                      //       itemBuilder: (context, index) => CardBuilder(context: context, image: PopularProductsModel!.data![index].cover.toString(), name: PopularProductsModel!.data![index].name.toString(), price: PopularProductsModel!.data![index].price.toString(), rate: PopularProductsModel!.data![index].averageRate.toString(), id: PopularProductsModel!.data![index].id.toString()),
                      //       separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                      //       itemCount: allProductsModel!.data!.length,
                      //       scrollDirection: Axis.horizontal,
                      //     ),
                      //   ),
                      // ),

                      Text(
                        "Popular Collections",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: SizedBox(
                          height: 115.h,
                          child: ListView.separated(
                            itemBuilder: (context, index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 110.h,
                                  width: 170.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                        image: NetworkImage(popularCollectionsModel!.data![index].image.toString()),
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
                                    popularCollectionsModel!.data![index].name.toString(),
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
                            separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                            itemCount: popularCollectionsModel!.data!.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
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
