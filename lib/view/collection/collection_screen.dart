// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, no_logic_in_create_state, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pavane/constants/product_card.dart';
import 'package:pavane/models/CollectionModel.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';

class CollectionScreen extends StatefulWidget {
  var id;
  CollectionScreen(this.id);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState(id);
}

class _CollectionScreenState extends State<CollectionScreen> {
  var id;
  _CollectionScreenState(this.id);

  var access_token = CacheHelper.getData(key: 'access_token');
  bool get = false;
  CollectionModel? collectionModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetCollection(token: access_token, id: id),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is GetCollectionSuccessState) {
            collectionModel = state.collectionModel;
            get = true;
          }
          if (state is LikeCollectionSuccessState) {
            Fluttertoast.showToast(
                msg: "Collection added to liked list",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is LikeCollectionErrorState) {
            Fluttertoast.showToast(
                msg: state.error.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
              condition: get,
              fallback: (context) => Center(
                  child: Image.asset(
                "assets/images/loader.gif",
                scale: .7,
              )),
              builder: (context) => Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.r),
                              bottomRight: Radius.circular(40.r)),
                          image: DecorationImage(
                              image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${collectionModel!.data!.image}'),
                              fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.r),
                              bottomRight: Radius.circular(40.r)),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 255, 255, .42),
                              Color.fromRGBO(128, 128, 128, .42)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: secondaryOrange,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: depOrange,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: secondaryOrange,
                              radius: 22.r,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                child: IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).LikeCollection(
                                        token: access_token,
                                        id: collectionModel!.data!.id.toString(),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: depOrange,
                                    size: 30.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 170.h),
                        child: Center(
                          child: Text(
                            collectionModel!.data!.name.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 407.h,
                    child: GridView.builder(
                      itemCount: collectionModel!.data!.itemsList!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .75),
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardBuilder(
                            context: context,
                            image: collectionModel!.data!.itemsList![index].images![0].toString(),
                            name: collectionModel!.data!.itemsList![index].name.toString(),
                            price: collectionModel!.data!.itemsList![index].price.toString(),
                            rate: collectionModel!.data!.itemsList![index].averageRate.toString(),
                            id: collectionModel!.data!.itemsList![index].id.toString(),
                            brand: collectionModel!.data!.brandId!.name.toString(),
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
