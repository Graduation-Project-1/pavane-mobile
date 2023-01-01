import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../models/AllCategoriesModel.dart';
import '../products by category/product_by_category_screen.dart';

class AllCategoriesScreen extends StatefulWidget {

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {

  var access_token = CacheHelper.getData(key: 'access_token');
  bool get = false;
  int page = 1;
  int totalPages = 0;
  final scrollcontroller = ScrollController();
  List<Map<String, dynamic>> list = [];
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).GetAllCategories(page: page.toString(), token: access_token);
    scrollcontroller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if(state is GetAllCategoriesSuccessState){
          for (final e in state.allCategoriesModel.data!){
            list.add(e.toJson());
          }
          isLoadingMore = false;
          totalPages = (state.allCategoriesModel.totalResult!/10).ceil();
          get = true;
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
              'All Categories',
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
              condition: get,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => GridView.builder(
                controller: scrollcontroller,
                itemCount: isLoadingMore ? list.length + 1 : list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.3),
                itemBuilder: (BuildContext context, int index) {
                  if(index < list.length){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => ProductByCategoryScreen(list[index]['_id'], list[index]['name'], 0))));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 3,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                      image: NetworkImage('https://graduation-project-23.s3.amazonaws.com/${list[index]['image']}'),
                                      fit: BoxFit.cover
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: const Color.fromRGBO(0, 0, 0, .22)
                                ),
                              ),
                              Center(
                                child: Text(
                                  list[index]['name'].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp
                                  ),
                                ),
                              ),
                            ],
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
        AppCubit.get(context).GetAllCategories(page: page.toString(), token: access_token);
      }
    }
  }

}
