import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pavane/view/authentication/login_screen.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';


class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? gender;

  final List<String> dayList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'];
  String? day;

  final List<String> monthList = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  String? month;

  final List<String> yearsList = ['2012', '2011' ,'2010', '2009', '2008', '2007', '2006', '2005', '2004', '2003', '2002', '2001', '2000', '1999', '1998', '1997', '1996', '1995', '1994', '1993', '1992', '1991', '1990', '1989', '1988', '1987', '1986', '1985,' '1984', '1983', '1982', '1981', '1980', '1979', '1978', '1977', '1976', '1975', '1974', '1973', '1972', '1971', '1970', '1969', '1968', '1967', '1966', '1965', '1964', '1963', '1962', '1961', '1960', '1959', '1958', '1957', '1956', '1955', '1954', '1953', '1952', '1951', '1950', '1949', '1948', '1947', '1946', '1945', '1944', '1943', '1942', '1941', '1940'];
  String? year;

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){

        if(state is RegisterSuccessState){
          Fluttertoast.showToast(
              msg: "Register Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => LoginScreen())));
        }

        if(state is RegisterErrorState){
          Fluttertoast.showToast(
              msg: state.error.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

      },
      builder: (context, state){
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
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 165.h,),
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 3,
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: depOrange,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your name';
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
                              hintText: "Name",
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Color.fromRGBO(98, 98, 98, 1),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 20.sp,
                                color: const Color.fromRGBO(98, 98, 98, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
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
                        SizedBox(height: 10.h,),
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
                              hintText: "Password",
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: Color.fromRGBO(98, 98, 98, 1),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: InkWell(
                                  onTap: (){
                                    AppCubit.get(context).changePasswordVisibility();
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
                        SizedBox(height: 10.h,),
                        Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 3,
                          child: TextFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: depOrange,
                            obscureText: AppCubit.get(context).isPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
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
                              hintText: "Confirm Password",
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: Color.fromRGBO(98, 98, 98, 1),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: InkWell(
                                  onTap: (){
                                    AppCubit.get(context).changePasswordVisibility();
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
                        SizedBox(height: 10.h,),
                        Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 3,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            cursorColor: depOrange,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone';
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
                              hintText: "Phone",
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Color.fromRGBO(98, 98, 98, 1),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 20.sp,
                                color: const Color.fromRGBO(98, 98, 98, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 3,
                          child: TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: depOrange,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your address';
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
                              hintText: "Address",
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: Color.fromRGBO(98, 98, 98, 1),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 20.sp,
                                color: const Color.fromRGBO(98, 98, 98, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 3,
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            isExpanded: true,
                            hint: Row(
                              children: [
                                Image.asset("assets/images/gender.png", scale: 4.sp,),
                                SizedBox(width: 15.w,),
                                Text(
                                  'Select Your Gender',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: const Color.fromRGBO(98, 98, 98, 1),
                                  ),
                                ),
                              ],
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Color.fromRGBO(98, 98, 98, 1),
                            ),
                            iconSize: 30,
                            buttonHeight: 50,
                            buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            items: genderItems
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ))
                                .toList(),
                            onSaved: (value) {
                              gender = value.toString();
                            },
                            onChanged: (value){},
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                borderRadius: BorderRadius.circular(10.r),
                                elevation: 3,
                                child: CustomDropdownButton2(
                                  hint: 'Day',
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Color.fromRGBO(98, 98, 98, 1),
                                  ),
                                  buttonHeight: 40.h,
                                  iconSize: 25.sp,
                                  dropdownWidth: 110.w,
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: Colors.transparent),
                                    color: white,
                                  ),
                                  dropdownItems: dayList,
                                  value: day,
                                  onChanged: (value) {
                                    setState(() {
                                      day = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 15.h,),
                            Expanded(
                              child: Material(
                                borderRadius: BorderRadius.circular(10.r),
                                elevation: 3,
                                child: CustomDropdownButton2(
                                  hint: 'Month',
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Color.fromRGBO(98, 98, 98, 1),
                                  ),
                                  buttonHeight: 40.h,
                                  iconSize: 25.sp,
                                  dropdownWidth: 110.w,
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: Colors.transparent),
                                    color: white,
                                  ),
                                  dropdownItems: monthList,
                                  value: month,
                                  onChanged: (value) {
                                    setState(() {
                                      month = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 15.h,),
                            Expanded(
                              child: Material(
                                borderRadius: BorderRadius.circular(10.r),
                                elevation: 3,
                                child: CustomDropdownButton2(
                                  hint: 'Year',
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Color.fromRGBO(98, 98, 98, 1),
                                  ),
                                  buttonHeight: 40.h,
                                  iconSize: 25.sp,
                                  dropdownWidth: 110.w,
                                  buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: Colors.transparent),
                                      color: white
                                  ),
                                  dropdownItems: yearsList,
                                  value: year,
                                  onChanged: (value) {
                                    setState(() {
                                      year = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h,),
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
                              print(emailController.text);
                              if(formKey.currentState!.validate()){
                               if(passwordController.text == confirmPasswordController.text){
                                 AppCubit.get(context).Register(
                                     name: nameController.text,
                                     email: emailController.text,
                                     password: passwordController.text,
                                     phone: phoneController.text,
                                     dateOfBirth: "$month $day, $year",
                                     location: addressController.text,
                                     gender: gender.toString(),
                                 );
                               }else{
                                 Fluttertoast.showToast(
                                     msg: "You enter two different passwords",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.TOP,
                                     timeInSecForIosWeb: 3,
                                     backgroundColor: Colors.red,
                                     textColor: Colors.white,
                                     fontSize: 16.0
                                 );
                               }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: state is RegisterLoadingState? const CircularProgressIndicator(color: white,) : Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h,),
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
                                style: TextStyle(
                                    fontSize: 15.sp
                                ),
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
                        SizedBox(height: 25.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: depOrange),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                  child: Image.asset("assets/images/facebook.png"),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: depOrange),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                  child: Image.asset("assets/images/google.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => LoginScreen())));
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: depOrange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                      ],
                    ),
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
