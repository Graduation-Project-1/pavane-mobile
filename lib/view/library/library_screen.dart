import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import '../../constants/product_card.dart';
import '../search/search_screen.dart';

class LibraryScreen extends StatefulWidget {

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  int x = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leadingWidth: 75.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: depOrange,
                child: Text("A", style: TextStyle(fontSize: 35.sp, color: white),),
              ),
            ],
          ),
        ),
        title: Text(
          'Your Library',
          style: TextStyle(
              color: depOrange,
              fontSize: 35.sp,
              fontFamily: "Roller"
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w, top: 10.h),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => SearchScreen())));
              },
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
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 10.h, left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      x = 1;
                    });
                  },
                  child: Container(
                    height: 30.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: depOrange),
                      color:  x == 1 ? depOrange : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Wishlist",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: x == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      x = 2;
                    });
                  },
                  child: Container(
                    height: 30.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: depOrange),
                      color:  x == 2 ? depOrange : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Likes",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: x == 2 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      x = 3;
                    });
                  },
                  child: Container(
                    height: 30.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: depOrange),
                      color:  x == 3 ? depOrange : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "For You",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: x == 3 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if(x == 1)
            Wishlist(),
          if(x == 2)
            Expanded(child: Likes()),
          if(x == 3)
            Expanded(child: ForYou()),
        ],
      ),
    );
  }
}

class Wishlist extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 11,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .85),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: CardBuilder(context: context),
        ),
      ),
    );
  }
}

class Likes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Collections",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 15.h,),
            SizedBox(
              height: 115.h,
              child: ListView.separated(
                  itemBuilder: (context, index) => Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 110.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/summer.jpg"),
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                      Container(
                        height: 110.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: const LinearGradient(
                              colors: [Color.fromRGBO(255, 255, 255, .42), Color.fromRGBO(128, 128, 128, .42)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Text(
                          "Summer",
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 15.h,),
            Text(
              "Products",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 15.h,),
            SizedBox(
              height: 180.h,
              child: ListView.separated(
                itemBuilder: (context, index) => CardBuilder(context: context),
                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 15.h,),
            Text(
              "Brands",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 15.h,),
            SizedBox(
              height: 85.h,
              child: ListView.separated(
                itemBuilder: (context, index) => Material(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    width: 170.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/zara_logo.png'),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 15.w,),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 15.h,),
          ],
        ),
      ),
    );
  }
}

class ForYou extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Collections",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 15.h,),
            SizedBox(
              height: 115.h,
              child: ListView.separated(
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 110.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/summer.jpg"),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Container(
                      height: 110.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        gradient: const LinearGradient(
                          colors: [Color.fromRGBO(255, 255, 255, .42), Color.fromRGBO(128, 128, 128, .42)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Text(
                      "Summer",
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                itemCount: 5,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 15.h,),
            Text(
              "Products",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 15.h,),
            SizedBox(
              height: 180.h,
              child: ListView.separated(
                itemBuilder: (context, index) => CardBuilder(context: context),
                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 15.h,),
            Text(
              "Brands",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 15.h,),
            SizedBox(
              height: 85.h,
              child: ListView.separated(
                itemBuilder: (context, index) => Material(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    width: 170.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/zara_logo.png'),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 15.w,),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 15.h,),
          ],
        ),
      ),
    );
  }
}
