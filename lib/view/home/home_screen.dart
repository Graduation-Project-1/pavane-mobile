import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors/colors.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> list =['assets/images/Group 62.png', 'assets/images/Group 62.png', 'assets/images/Group 62.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Image.asset('assets/images/title.png', scale: 4.sp,),
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: gray,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.notifications_none, color: black, size: 30.sp,),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                color: gray,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(Icons.search, color: black, size: 30.sp,),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Hello Ahmed!",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h,),
              Text(
                "Lets gets somethings?",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(98, 98, 98, 1),
                ),
              ),
              SizedBox(height: 15.h,),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    height: 170.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: ListView(
                        children: [
                          Container(
                            height: 170.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Carousel(
                              dotSize: 0,
                              dotSpacing: 0,
                              radius: Radius.circular(20.r),
                              borderRadius: true,
                              showIndicator: false,
                              dotPosition: DotPosition.bottomCenter,
                              images: [
                                for(int i =0 ; i < list.length; i++)
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(list[i]),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h,),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Top Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp
                      ),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Text(
                        "SEE ALL",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: depOrange
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              SizedBox(
                height: 70.h,
                child: ListView.separated(
                    itemBuilder: (context, index) => Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: const AssetImage('assets/images/test.jpg'),
                          radius: 30.r,
                        ),
                        Text(
                            "Jeans",
                          style: TextStyle(
                            fontSize: 15.sp
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 15.h,),
              Text(
                "From Your Favorite Brands",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp
                ),
              ),
              SizedBox(height: 10.h,),
              SizedBox(
                height: 180.h,
                child: ListView.separated(
                  itemBuilder: (context, index) => CardBuilder(),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 15.h,),
              Text(
                "People Also Liked",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp
                ),
              ),
              SizedBox(height: 10.h,),
              SizedBox(
                height: 180.h,
                child: ListView.separated(
                  itemBuilder: (context, index) => CardBuilder(),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CardBuilder(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 130.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Container(
                width: 130.w,
                height: 130.h,
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
    );
  }

}
