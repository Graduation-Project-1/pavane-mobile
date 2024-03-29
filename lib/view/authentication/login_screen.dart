import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pavane/view/authentication/register_screen.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../bottom nav bar/bottom_nav_bar_screen.dart';
import 'forget_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Fluttertoast.showToast(
              msg: "Login Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          CacheHelper.saveData(
            key: 'access_token',
            value: state.loginModel.token,
          ).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => BottomNavBarScreen())));
          }).catchError((error) {
            debugPrint(error.toString());
          });
        }

        if (state is LoginErrorState) {
          Fluttertoast.showToast(
              msg: state.error.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
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
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 180.h,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Please sign in to continue",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color.fromRGBO(98, 98, 98, 1),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
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
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'please enter correct email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0.r)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0.r)),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 25, top: 15, bottom: 10, right: 10),
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(10.r),
                        elevation: 3,
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: depOrange,
                          obscureText: AppCubit.get(context).isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0.r)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0.r)),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 25, top: 15, bottom: 10, right: 10),
                            hintText: "Password",
                            prefixIcon: const Icon(
                              Icons.lock_outlined,
                              color: Color.fromRGBO(98, 98, 98, 1),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: InkWell(
                                onTap: () {
                                  AppCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                child: Icon(
                                  AppCubit.get(context).suffix,
                                  color: const Color.fromRGBO(248, 153, 54, 1),
                                ),
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 20.sp,
                              color: const Color.fromRGBO(98, 98, 98, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          ForgetPasswordScreen())));
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: depOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(depOrange),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ))),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AppCubit.get(context).Login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: state is LoginLoadingState
                                ? const CircularProgressIndicator(
                                    color: white,
                                  )
                                : Text("LOGIN",
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.h,
                              color: black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Text(
                              "Or continue with",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1.h,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: depOrange),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.w),
                                child:
                                    Image.asset("assets/images/facebook.png"),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: depOrange),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.w),
                                child: Image.asset("assets/images/google.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          RegisterScreen())));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: depOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 55.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
