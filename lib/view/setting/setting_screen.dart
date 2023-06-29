// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/bloc/cubit.dart';
import 'package:pavane/bloc/state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/Cache_helper.dart';
import '../../constants/colors.dart';
import '../../constants/row_builder.dart';
import '../authentication/login_or_register_screen.dart';

class SettingScreen extends StatelessWidget {

  var access_token = CacheHelper.getData(key: 'access_token');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is SubscribeSuccessState){
          launchUrl(Uri.parse(state.subscribeModel.url.toString()));
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          title: Text(
            'Setting',
            style: TextStyle(
                color: depOrange, fontSize: 35.sp, fontFamily: "Roller"),
          ),
          iconTheme: const IconThemeData(
            color: depOrange,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              RowBuilder(icon: Icons.group, title: "About", function: () {}),
              SizedBox(
                height: 10.h,
              ),
              RowBuilder(
                  icon: Icons.library_books_rounded, title: "Terms And Conditions", function: () {}),
              SizedBox(
                height: 10.h,
              ),
              RowBuilder(
                  icon: Icons.question_answer, title: "FAQ", function: () {}),
              SizedBox(
                height: 10.h,
              ),
              RowBuilder(icon: Icons.chat, title: "Contact US", function: () {}),
              SizedBox(
                height: 10.h,
              ),
              RowBuilder(icon: Icons.payment, title: "Subscribe", function: () {
                AppCubit.get(context).Subscribe(token: access_token);
              }),
              SizedBox(
                height: 10.h,
              ),
              RowBuilder(
                  icon: Icons.logout_outlined,
                  title: "Log Out",
                  function: () {
                    CacheHelper.removeData(
                      key: 'access_token',
                    ).then((value) {
                      Navigator.of(context, rootNavigator: true).pushReplacement(
                        MaterialPageRoute(builder: ((context) => LoginOrRegisterScreen())),
                      );
                    });
                  }),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
