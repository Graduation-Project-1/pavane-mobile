import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../brand profile/brand_profile_screen.dart';

class AllBrandsScreen extends StatefulWidget {

  @override
  State<AllBrandsScreen> createState() => _AllBrandsScreenState();
}

class _AllBrandsScreenState extends State<AllBrandsScreen> {

  bool get_all_brands = false;
  var access_token = CacheHelper.getData(key: 'access_token');

  int page = 1;
  int totalPages = 0;
  final scrollcontroller = ScrollController();
  List<Map<String, dynamic>> list = [];
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).GetAllBrands(page: page.toString(), token: access_token);
    scrollcontroller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if(state is GetAllBrandsSuccessState){
          for (final e in state.allBrandsModel.data!){
            list.add(e.toJson());
          }
          isLoadingMore = false;
          totalPages = (state.allBrandsModel.totalResult!/10).ceil();
          get_all_brands = true;
        }
      },
      builder: (context, state){
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: depOrange,
            ),
            title: Text(
              'All Brands',
              style: TextStyle(
                  color: depOrange,
                  fontSize: 35.sp,
                  fontFamily: "Roller"
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConditionalBuilder(
              condition: get_all_brands,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => GridView.builder(
                controller: scrollcontroller,
                itemCount: isLoadingMore ? list.length + 1 : list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  if(index < list.length){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BrandProfileScreen(list[index]['_id'].toString()))));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                  image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${list[index]['image']}'),
                                  fit: BoxFit.contain
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }else{
                    return const Center(child: CircularProgressIndicator(color: Color.fromRGBO(248, 153, 54, 1),));
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _scrollListener(){
    if(scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent){
      if(page < totalPages){
        setState(() {
          isLoadingMore = true;
        });
        page = page + 1;
        AppCubit.get(context).GetAllBrands(page: page.toString(), token: access_token);
      }
    }
  }
}
