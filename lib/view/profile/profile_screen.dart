import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/constants/colors.dart';
import 'package:pavane/models/UserModel.dart';
import 'package:pavane/view/setting/setting_screen.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/row_builder.dart';
import '../personal data/personal_data_screen.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var access_token = CacheHelper.getData(key: 'access_token');
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetUserData(token: access_token),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is GetUserDataSuccessState){
            userModel = state.userModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: white,
              title: Text(
                'My Profile',
                style: TextStyle(
                    color: depOrange,
                    fontSize: 35.sp,
                    fontFamily: "Roller"
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: state is GetUserDataSuccessState,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 25.h,),
                    Center(
                      child: SizedBox(
                        width: 170.w,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: depOrange,
                              radius: 80.r,
                            ),
                            Positioned(
                              left: 9.w,
                              child: CircleAvatar(
                                radius: 80.r,
                                backgroundImage: const AssetImage('assets/images/person-icon.png'),
                                // backgroundImage: NetworkImage(userModel!.data!.image.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      userModel!.data!.name.toString(),
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    RowBuilder(icon: Icons.person, title: "Personal Data", function: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => PersonalDataScreen(userModel))));
                    }),
                    SizedBox(height: 10.h,),
                    RowBuilder(icon: Icons.favorite_border, title: "Likes", function: (){}),
                    SizedBox(height: 10.h,),
                    RowBuilder(icon: Icons.settings, title: "Settings", function: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => SettingScreen())));
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
