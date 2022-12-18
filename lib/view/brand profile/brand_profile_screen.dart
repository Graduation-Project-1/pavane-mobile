import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';

class BrandProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
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
                      image: const DecorationImage(
                          image: AssetImage("assets/images/zara_logo.png"),
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
                    Container(
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
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 370.h,
                        width: double.infinity,
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
                    ],
                  ),
                ),
                SizedBox(width: 30.w,),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 175.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45.r),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/Mask Group 4.png"),
                              fit: BoxFit.cover
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 130.h),
                          child: Center(
                            child: Text(
                              'Women',
                              style: TextStyle(
                                  color: depOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.w,),
                      Container(
                        height: 175.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45.r),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/Mask Group 3.png"),
                              fit: BoxFit.cover
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 130.h),
                          child: Center(
                            child: Text(
                              'Men',
                              style: TextStyle(
                                  color: depOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
