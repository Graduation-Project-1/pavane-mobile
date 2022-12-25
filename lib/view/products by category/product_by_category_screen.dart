import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/constants/product_card.dart';

import '../../constants/colors.dart';

class ProductByCategoryScreen extends StatelessWidget {

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
          'Category Name',
          style: TextStyle(
              color: depOrange,
              fontSize: 35.sp,
              fontFamily: "Roller"
          ),
        ),
      ),
      // body: GridView.builder(
      //     itemCount: 11,
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .85),
      //     itemBuilder: (context, index) => Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: CardBuilder(context: context),
      //     ),
      // ),
    );
  }
}
