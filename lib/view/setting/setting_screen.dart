import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import '../../constants/row_builder.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Setting',
          style: TextStyle(
              color: depOrange,
              fontSize: 35.sp,
              fontFamily: "Roller"
          ),
        ),
        iconTheme: const IconThemeData(
          color: depOrange,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.group, title: "About", function: (){}),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.library_books_rounded, title: "Terms And Conditions", function: (){}),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.help_outline, title: "Help And Support", function: (){}),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.question_answer, title: "FAQ", function: (){}),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.chat, title: "Contact US", function: (){}),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.language, title: "Language", function: (){}),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.payment, title: "Payment", function: (){}),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }
}
