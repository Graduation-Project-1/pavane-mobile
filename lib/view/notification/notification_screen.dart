import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/constants/colors.dart';

class NotificationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
            itemBuilder: (context, index) => Material(
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
                          Text(
                              "Title",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 280.w,
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
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
            separatorBuilder: (context, index) => SizedBox(height: 20.h,),
            itemCount: 10
        ),
      ),
    );
  }
}
