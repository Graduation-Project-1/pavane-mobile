// ignore_for_file: use_key_in_widget_constructors, no_logic_in_create_state, must_be_immutable, depend_on_referenced_packages, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pavane/view/personal%20data/personal_data_screen.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../models/UserModel.dart';
import 'package:http_parser/http_parser.dart';


class EditPersonalDataScreen extends StatefulWidget {

  UserModel? userModel;
  EditPersonalDataScreen(this.userModel);

  @override
  State<EditPersonalDataScreen> createState() => _EditPersonalDataScreenState(userModel);
}

class _EditPersonalDataScreenState extends State<EditPersonalDataScreen> {

  UserModel? userModel;
  _EditPersonalDataScreenState(this.userModel);
  var access_token = CacheHelper.getData(key: 'access_token');

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? gender;

  final List<String> dayList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  String? day;

  final List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  String? month;

  final List<String> yearsList = [
    '2012',
    '2011',
    '2010',
    '2009',
    '2008',
    '2007',
    '2006',
    '2005',
    '2004',
    '2003',
    '2002',
    '2001',
    '2000',
    '1999',
    '1998',
    '1997',
    '1996',
    '1995',
    '1994',
    '1993',
    '1992',
    '1991',
    '1990',
    '1989',
    '1988',
    '1987',
    '1986',
    '1985',
    '1984',
    '1983',
    '1982',
    '1981',
    '1980',
    '1979',
    '1978',
    '1977',
    '1976',
    '1975',
    '1974',
    '1973',
    '1972',
    '1971',
    '1970',
    '1969',
    '1968',
    '1967',
    '1966',
    '1965',
    '1964',
    '1963',
    '1962',
    '1961',
    '1960',
    '1959',
    '1958',
    '1957',
    '1956',
    '1955',
    '1954',
    '1953',
    '1952',
    '1951',
    '1950',
    '1949',
    '1948',
    '1947',
    '1946',
    '1945',
    '1944',
    '1943',
    '1942',
    '1941',
    '1940'
  ];
  String? year;

  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    setState(() {});
    var formData = FormData.fromMap({
      'images': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last.toString(),
        contentType: MediaType("image", "jpeg"),
      ),
    });
    AppCubit.get(context).UploadUserImage(token: access_token, formData: formData, id: userModel!.data!.id);
  }

  @override
  void initState() {
    nameController.text = userModel!.data!.name.toString();
    emailController.text = userModel!.data!.email.toString();
    phoneController.text = userModel!.data!.phone.toString();
    locationController.text = userModel!.data!.location.toString();
    gender = userModel!.data!.gender!.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider getImage(){
      if (image != null) {
        return FileImage(image!);
      } else if (userModel!.data!.image != null) {
        if (userModel!.data!.image.toString().split(":").first.toString() == "http" || userModel!.data!.image.toString().split(":").first.toString() == "https") {
          return NetworkImage(userModel!.data!.image.toString());
        } else {
          return NetworkImage("https://graduation-project-23.s3.amazonaws.com/${userModel!.data!.image.toString()}");
        }
      } else {
        return const AssetImage('assets/images/person-icon.png');
      }
    }
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is EditUserDataSuccessState){
          Fluttertoast.showToast(
              msg: "Data Changed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => PersonalDataScreen())));
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: depOrange,
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => PersonalDataScreen())));
            },
            icon: const Icon(
              Icons.arrow_back_ios, color: depOrange,
            ),
          ),
          title: Text(
            'Edit Profile',
            style: TextStyle(
                color: depOrange, fontSize: 35.sp, fontFamily: "Roller"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: SizedBox(
                    width: 170.w,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Positioned(
                          right: 10.w,
                          child: CircleAvatar(
                            backgroundColor: depOrange,
                            radius: 80.r,
                          ),
                        ),
                        CircleAvatar(
                          radius: 80.r,
                          backgroundImage: getImage(),
                        ),
                        InkWell(
                          onTap: () async {
                            pickImage();
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundColor: depOrange,
                            radius: 17.sp,
                            child: state is UploadUserImageLoadingState ? const CircularProgressIndicator(color: Colors.white,):  const Icon(
                              Icons.edit,
                              color: white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: const Color.fromRGBO(129, 129, 129, 1),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: depOrange,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: depOrange),
                    ),
                    contentPadding: const EdgeInsets.only(left: 5, top: 15, bottom: 10, right: 10),
                    hintText: "Name",
                    hintStyle: TextStyle(
                      fontSize: 20.sp,
                      color: const Color.fromRGBO(98, 98, 98, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: const Color.fromRGBO(129, 129, 129, 1),
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: depOrange,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: depOrange),
                    ),
                    contentPadding: const EdgeInsets.only(left: 5, top: 15, bottom: 10, right: 10),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      fontSize: 20.sp,
                      color: const Color.fromRGBO(98, 98, 98, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Phone",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: const Color.fromRGBO(129, 129, 129, 1),
                  ),
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  cursorColor: depOrange,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: depOrange),
                    ),
                    contentPadding: const EdgeInsets.only(left: 5, top: 15, bottom: 10, right: 10),
                    hintText: "Phone",
                    hintStyle: TextStyle(
                      fontSize: 20.sp,
                      color: const Color.fromRGBO(98, 98, 98, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: const Color.fromRGBO(129, 129, 129, 1),
                  ),
                ),
                TextFormField(
                  controller: locationController,
                  keyboardType: TextInputType.name,
                  cursorColor: depOrange,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: depOrange),
                    ),
                    contentPadding: const EdgeInsets.only(left: 5, top: 15, bottom: 10, right: 10),
                    hintText: "Location",
                    hintStyle: TextStyle(
                      fontSize: 20.sp,
                      color: const Color.fromRGBO(98, 98, 98, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: const Color.fromRGBO(129, 129, 129, 1),
                  ),
                ),
                DropdownButtonFormField2(
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: depOrange),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    userModel!.data!.gender.toString(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color.fromRGBO(98, 98, 98, 1),
                    ),
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
                  items: genderItems.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  )).toList(),
                  onSaved: (value) {
                    gender = value.toString();
                  },
                  onChanged: (value) {
                    gender = value.toString();
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Date Of Birth",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: const Color.fromRGBO(129, 129, 129, 1),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownButton2(
                        hint: userModel!.data!.dateOfBirth!.split("-").elementAt(2)[0] + userModel!.data!.dateOfBirth!.split("-").elementAt(2)[1],
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Color.fromRGBO(98, 98, 98, 1),
                        ),
                        buttonHeight: 40.h,
                        iconSize: 25.sp,
                        dropdownWidth: 110.w,
                        buttonDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: .5.w,
                            ),
                          ),
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
                    SizedBox(
                      width: 15.h,
                    ),
                    Expanded(
                      child: CustomDropdownButton2(
                        hint: userModel!.data!.dateOfBirth!.split("-").elementAt(1),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Color.fromRGBO(98, 98, 98, 1),
                        ),
                        buttonHeight: 40.h,
                        iconSize: 25.sp,
                        dropdownWidth: 110.w,
                        buttonDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: .5.w,
                            ),
                          ),
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
                    SizedBox(
                      width: 15.h,
                    ),
                    Expanded(
                      child: CustomDropdownButton2(
                        hint: userModel!.data!.dateOfBirth!.split("-").elementAt(0),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Color.fromRGBO(98, 98, 98, 1),
                        ),
                        buttonHeight: 40.h,
                        iconSize: 25.sp,
                        dropdownWidth: 110.w,
                        buttonDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: .5.w,
                            ),
                          ),
                          color: white,
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
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(depOrange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),))),
                    onPressed: () {
                      AppCubit.get(context).EditUserData(token: access_token, formData: {
                        "name" : nameController.text,
                        "email" : emailController.text,
                        "phone" : phoneController.text,
                        if(userModel!.data!.dateOfBirth!.split("-").elementAt(0) != year || userModel!.data!.dateOfBirth!.split("-").elementAt(1) != month || userModel!.data!.dateOfBirth!.split("-").elementAt(2)[0] + userModel!.data!.dateOfBirth!.split("-").elementAt(2)[1] != day) "dateOfBirth" : "$month $day, $year",
                        "gender" : gender,
                        "location" : locationController.text,
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 50.w),
                      child: state is EditUserDataLoadingState ? const CircularProgressIndicator(color: Colors.white,) : Text("Confirm",
                          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
