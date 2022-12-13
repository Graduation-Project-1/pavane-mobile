import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/product details/product_details_screen.dart';
import 'colors.dart';

Widget CardBuilder({required BuildContext context}){
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: ((context) => ProductDetailsScreen())));
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Container(
                width: 150.w,
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/test.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Container(
                width: 130.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "name",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color.fromRGBO(101, 101, 101, 1),
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "500 L.E",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "4.5",
                                style: TextStyle(
                                    color: depOrange,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Icon(Icons.star, color: depOrange, size: 18.sp,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}