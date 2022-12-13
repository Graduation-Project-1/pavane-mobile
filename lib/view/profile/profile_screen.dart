import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/constants/colors.dart';
import 'package:pavane/view/setting/setting_screen.dart';

import '../../constants/row_builder.dart';
import '../personal data/personal_data_screen.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'My Profile',
          style: TextStyle(
              color: depOrange,
              fontSize: 35.sp,
              fontFamily: "Roller"
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 25.h,),
            Center(
              child: SizedBox(
                width: 170.w,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: depOrange,
                      radius: 80.r,
                    ),
                    Positioned(
                      left: 9.w,
                      child: CircleAvatar(
                        radius: 80.r,
                        backgroundImage: const AssetImage('assets/images/person2.jpg'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Text(
                "User Name",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 30.h,),
            RowBuilder(icon: Icons.person, title: "Personal Data", function: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) => PersonalDataScreen())));
            }),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.list, title: "Wishlist", function: (){}),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.favorite_border, title: "Likes", function: (){}),
            SizedBox(height: 10.h,),
            RowBuilder(icon: Icons.settings, title: "Settings", function: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) => SettingScreen())));
            }),
          ],
        ),
      ),
    );
  }
}
