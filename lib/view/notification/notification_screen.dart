// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/constants/colors.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../models/AllNotificationModel.dart';
import '../collection/collection_screen.dart';
import '../sale/sale_screen.dart';

class NotificationScreen extends StatelessWidget {

  var access_token = CacheHelper.getData(key: 'access_token');
  AllNotificationModel? allNotificationModel;
  bool get = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetNotification(token: access_token),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is GetNotificationSuccessState){
            allNotificationModel = state.allNotificationModel;
            get = true;
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
              'Notification',
              style: TextStyle(
                  color: depOrange,
                  fontSize: 35.sp,
                  fontFamily: "Roller"
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: get,
            fallback: (context) => Center(
                child: Image.asset(
                  "assets/images/loader.gif",
                  scale: .7,
                )),
            builder: (context) => ConditionalBuilder(
              condition: allNotificationModel!.data!.isNotEmpty,
              fallback: (context) => Center(
                  child: Text(
                    "No Notifications Found",
                    style: TextStyle(fontSize: 20.sp),
                  )),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                      onTap: (){
                        if(allNotificationModel!.data![index].type!.toString() == "collection"){
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => CollectionScreen(allNotificationModel!.data![index].id))));
                        }else if(allNotificationModel!.data![index].type!.toString() == "sale"){
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => SaleScreen(allNotificationModel!.data![index].id))));
                        }
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(15.r),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: depOrange,
                                  radius: 30.r,
                                  child: const Text(
                                    'PAVANE',
                                    style: TextStyle(
                                      fontFamily: 'Roller',
                                      color: white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 280.w,
                                      child: Text(
                                        allNotificationModel!.data![index].name!,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                    itemCount: allNotificationModel!.data!.length
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
