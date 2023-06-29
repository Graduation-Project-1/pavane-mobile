// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, no_logic_in_create_state, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../models/UserModel.dart';
import '../profile/profile_screen.dart';
import 'edit_personal_data_screen.dart';

class PersonalDataScreen extends StatefulWidget {

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {

  UserModel? userModel;
  var access_token = CacheHelper.getData(key: 'access_token');
  bool get = false;

  @override
  void initState() {
    AppCubit.get(context).GetUserData(token: access_token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is GetUserDataSuccessState){
          userModel = state.userModel;
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
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => ProfileScreen())));
            },
            icon: const Icon(
              Icons.arrow_back_ios, color: depOrange,
            ),
          ),
          title: Text(
            'Profile Data',
            style: TextStyle(
                color: depOrange, fontSize: 35.sp, fontFamily: "Roller"),
          ),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => EditPersonalDataScreen(userModel))));
                },
                icon: Icon(
                  Icons.edit,
                  color: depOrange,
                  size: 25.sp,
                ),
            ),
          ],
        ),
        body: ConditionalBuilder(
          condition: get,
          fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
          builder: (context){
            ImageProvider getImage(){
              if(userModel!.data!.image != null){
                if(userModel!.data!.image.toString().split(":").first.toString() == "http" || userModel!.data!.image.toString().split(":").first.toString() == "https") {
                  return NetworkImage(userModel!.data!.image.toString());
                }else{
                  return NetworkImage("https://graduation-project-23.s3.amazonaws.com/${userModel!.data!.image.toString()}");
                }
              }else{
                return const AssetImage('assets/images/person-icon.png');
              }
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                      child: SizedBox(
                        width: 170.w,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Positioned(
                              right: 10.w,
                              child: CircleAvatar(
                                backgroundColor: depOrange,
                                radius: 80.r,
                              ),
                            ),
                            CircleAvatar(
                              radius: 80.r,
                              backgroundImage: getImage(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
                      child: Text(
                      userModel!.data!.name != null ? userModel!.data!.name!.toString() : "",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: depOrange
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromRGBO(129, 129, 129, 1),
                    ),

                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
                      child: Text(
                        userModel!.data!.email != null ? userModel!.data!.email!.toString() : "",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: depOrange
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromRGBO(129, 129, 129, 1),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
                      child: Text(
                        userModel!.data!.gender != null ? userModel!.data!.gender!.toString() : "",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: depOrange
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromRGBO(129, 129, 129, 1),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Phone",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
                      child: Text(
                        userModel!.data!.phone != null ? userModel!.data!.phone!.toString() : "",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: depOrange
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromRGBO(129, 129, 129, 1),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
                      child: Text(
                        userModel!.data!.location != null ? userModel!.data!.location!.toString() : "",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: depOrange
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromRGBO(129, 129, 129, 1),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Date Of Birth",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
                      child: Text(
                        userModel!.data!.dateOfBirth != null ? userModel!.data!.dateOfBirth!.toString().split("T").first : "",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: depOrange
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromRGBO(129, 129, 129, 1),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
