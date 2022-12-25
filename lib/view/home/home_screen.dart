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
import '../../models/AllCategoriesModel.dart';
import '../../models/AllProductsModel.dart';
import '../../models/UserModel.dart';
import '../all categories/all_categories_screen.dart';
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

  var access_token = CacheHelper.getData(key: 'access_token');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetUserData(token: access_token)..GetAllCategories(token: access_token, page: "1")..GetAllProducts(token: access_token, page: "1"),
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
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0,
              title: Image.asset('assets/images/title.png', scale: 4.sp,),
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
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
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => SearchScreen())));
                    },
                    child: Container(
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
              condition: get_user && get_cat && get_products,
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
                      SizedBox(height: 5.h,),
                      Text(
                        "Lets gets somethings?",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(98, 98, 98, 1),
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            height: 170.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: ListView(
                                children: [
                                  Container(
                                    height: 170.0,
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
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
                      SizedBox(height: 10.h,),
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
                      SizedBox(height: 15.h,),
                      Text(
                        "All Products",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        height: 180.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) => CardBuilder(context: context, image: allProductsModel!.data![index].cover.toString(), name: allProductsModel!.data![index].name.toString(), price: allProductsModel!.data![index].price.toString(), rate: "4.5", id: allProductsModel!.data![index].id.toString()),
                          separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                          itemCount: allProductsModel!.data!.length,
                          scrollDirection: Axis.horizontal,
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
