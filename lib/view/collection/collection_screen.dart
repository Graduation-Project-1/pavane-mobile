import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        listener: (context, state){
          if(state is GetCollectionSuccessState){
            collectionModel = state.collectionModel;
            get = true;
          }
        },
        builder: (context, state){
          return Scaffold(
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
                          image: DecorationImage(
                              image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${collectionModel!.data!.image}'),
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r), bottomRight: Radius.circular(40.r)),
                          gradient: const LinearGradient(
                            colors: [Color.fromRGBO(255, 255, 255, .42), Color.fromRGBO(128, 128, 128, .42)],
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
                            IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios, color: depOrange,),
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.favorite_border, color: depOrange, size: 30.sp,),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 170.h),
                        child: Center(child: Text(collectionModel!.data!.name.toString(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 23.sp, fontWeight: FontWeight.bold),),),
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
                          brand: collectionModel!.data!.brandId!.name.toString()
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
