// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/Cache_helper.dart';
import '../../constants/colors.dart';
import '../../constants/row_builder.dart';
import '../authentication/login_or_register_screen.dart';

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
              color: depOrange, fontSize: 35.sp, fontFamily: "Roller"),
        ),
        iconTheme: const IconThemeData(
          color: depOrange,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            RowBuilder(icon: Icons.group, title: "About", function: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowBuilder(
                icon: Icons.library_books_rounded,
                title: "Terms And Conditions",
                function: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowBuilder(
                icon: Icons.help_outline,
                title: "Help And Support",
                function: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowBuilder(
                icon: Icons.question_answer, title: "FAQ", function: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowBuilder(icon: Icons.chat, title: "Contact US", function: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowBuilder(icon: Icons.payment, title: "Payment", function: () {}),
            SizedBox(
              height: 10.h,
            ),
            RowBuilder(
                icon: Icons.logout_outlined,
                title: "Log Out",
                function: () {
                  CacheHelper.removeData(
                    key: 'access_token',
                  ).then((value) {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                          builder: ((context) => LoginOrRegisterScreen())),
                    );
                  });
                }),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
