// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../collection/collection_screen.dart';

class AllCollectionsScreen extends StatefulWidget {

  var brand_id;
  AllCollectionsScreen(this.brand_id);

  @override
  State<AllCollectionsScreen> createState() => _AllCollectionsScreenState(brand_id);
}

class _AllCollectionsScreenState extends State<AllCollectionsScreen> {

  var brand_id;
  _AllCollectionsScreenState(this.brand_id);

  bool get_all_collections = false;
  var access_token = CacheHelper.getData(key: 'access_token');

  int page = 1;
  int totalPages = 0;
  final scrollcontroller = ScrollController();
  List<Map<String, dynamic>> list = [];
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    if(brand_id == null){
      AppCubit.get(context).GetAllCollections(page: page.toString(), token: access_token);
    }else{
      AppCubit.get(context).GetCollectionsByBrand(token: access_token, brand_id: brand_id, page: page);
    }
    scrollcontroller.addListener(_scrollListener);
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if(state is GetAllCollectionsSuccessState){
          for (final e in state.allCollectionsModel.data!){
            list.add(e.toJson());
          }
          isLoadingMore = false;
          totalPages = (state.allCollectionsModel.totalResult!/10).ceil();
          get_all_collections = true;
        }
        if(state is GetPopularCollectionsSuccessState){
          for (final e in state.allCollectionsModel.data!){
            list.add(e.toJson());
          }
          isLoadingMore = false;
          totalPages = (state.allCollectionsModel.totalResult!/10).ceil();
          get_all_collections = true;
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
              'All Collections',
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
              condition: get_all_collections,
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
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => CollectionScreen(list[index]['_id']))));
                        },
                        child: Stack(
                          alignment: Alignment.center,
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
                                gradient: const LinearGradient(
                                  colors: [Color.fromRGBO(255, 255, 255, .42), Color.fromRGBO(128, 128, 128, .42)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150.w,
                              child: Text(
                                list[index]['name'].length > 20 ? list[index]['name'].toString().substring(0, 20) : list[index]['name'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ],
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
        AppCubit.get(context).GetAllCollections(page: page.toString(), token: access_token);
      }
    }
  }

}
