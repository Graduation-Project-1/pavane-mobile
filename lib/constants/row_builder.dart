import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

Widget RowBuilder({required IconData icon, required String title, required var function}){
  return InkWell(
    onTap: function,
    child: Material(
      borderRadius: BorderRadius.circular(15.r),
      elevation: 3,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: depOrange, size: 35.sp,),
                  SizedBox(width: 15.w,),
                  Text(title, style: TextStyle(fontSize: 20.sp),),
                ],
              ),

              const Icon(Icons.arrow_forward_ios, color: depOrange,),
            ],
          ),
        ),
      ),
    ),
  );
}