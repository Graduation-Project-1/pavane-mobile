// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/view/authentication/login_screen.dart';
import 'package:pavane/view/authentication/register_screen.dart';
import '../../constants/colors.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300.h,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/cover.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(70.r),
                  bottomLeft: Radius.circular(70.r)),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "Find Your\nFavorite Clothes",
            style: TextStyle(
              fontSize: 35.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Explore off the most trending Clothes\nBased on your interest  ",
            style: TextStyle(
              fontSize: 20.sp,
              color: const Color.fromRGBO(98, 98, 98, 1),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 120.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 75.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: depOrange),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => RegisterScreen())));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: depOrange,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(20.r),
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(20.r))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        child: Text(
                          "Register",
                          style: TextStyle(color: white, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => LoginScreen())));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, left: 30),
                      child: Text(
                        "Login",
                        style: TextStyle(color: depOrange, fontSize: 20.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
