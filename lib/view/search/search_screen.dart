import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

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
          'Search',
          style: TextStyle(
              color: depOrange,
              fontSize: 35.sp,
              fontFamily: "Roller"
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              keyboardType: TextInputType.text,
              cursorColor: depOrange,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: depOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: depOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
                ),
                contentPadding: const EdgeInsets.only(left: 25, top: 15, bottom: 10, right: 10),
                hintText: "What do you want?",
                prefixIcon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Color.fromRGBO(98, 98, 98, 1),
                ),
                hintStyle: TextStyle(
                  fontSize: 20.sp,
                  color: const Color.fromRGBO(98, 98, 98, 1),
                ),
              ),
            ),
            SizedBox(height: 15.h,),
            Text(
              "Brands",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: depOrange
              ),
            ),
            SizedBox(height: 15.h,),
            SizedBox(
              height: 220.h,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.r),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/zara_logo.png'),
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Text(
                "Show All",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: depOrange
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
