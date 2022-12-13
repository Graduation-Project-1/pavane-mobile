import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';

class ForgetPasswordScreen extends StatelessWidget {

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Login.png"),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 180.h,),
                Text(
                  "Forget Password",
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(
                  "Please enter your mail to send\nrecovery mail. ",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color.fromRGBO(98, 98, 98, 1),
                  ),
                ),
                SizedBox(height: 30.h,),
                Material(
                  borderRadius: BorderRadius.circular(10.r),
                  elevation: 3,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: depOrange,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email address';
                      }
                      else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                        return 'please enter correct email';
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
                      ),
                      contentPadding: const EdgeInsets.only(left: 25, top: 15, bottom: 10, right: 10),
                      hintText: "Email",
                      prefixIcon: const Icon(
                        Icons.alternate_email,
                        color: Color.fromRGBO(98, 98, 98, 1),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 20.sp,
                        color: const Color.fromRGBO(98, 98, 98, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(depOrange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            )
                        )
                    ),
                    onPressed: (){

                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                          "SEND",
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 70.h, horizontal: 10.w),
            child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: depOrange,
                ),
            ),
          ),
        ],
      ),
    );
  }
}
