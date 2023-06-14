// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, no_logic_in_create_state, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';

class AllBrandReviewsScreen extends StatefulWidget {

  var brand_id;
  AllBrandReviewsScreen(this.brand_id);

  @override
  State<AllBrandReviewsScreen> createState() => _AllBrandReviewsScreenState(brand_id);
}

class _AllBrandReviewsScreenState extends State<AllBrandReviewsScreen> {

  var brand_id;
  _AllBrandReviewsScreenState(this.brand_id);

  List<Map<String, dynamic>> list = [];
  int page = 1;
  int totalPages = 0;
  bool get_reviews = false;
  bool isLoadingMore = false;
  var access_token = CacheHelper.getData(key: 'access_token');
  final scrollcontroller = ScrollController();

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async {
    setState(() {
      list.clear();
      page = 1;
      get_reviews = false;
    });
    AppCubit.get(context).GetBrandReviews(token: access_token, id: brand_id, page: 1, size: 10);
    _refreshController.refreshCompleted();
  }


  @override
  void initState() {
    AppCubit.get(context).GetBrandReviews(token: access_token, id: brand_id, page: 1, size: 10);
    scrollcontroller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if(state is GetBrandReviewsSuccessState){
          for (final e in state.reviewModel.data!) {
            list.add(e.toJson());
          }
          get_reviews = true;
          isLoadingMore = false;
          totalPages = state.reviewModel.totalPages!;
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
          title: Text(
            'All Reviews',
            style: TextStyle(
                color: depOrange,
                fontSize: 35.sp,
                fontFamily: "Roller"
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ConditionalBuilder(
            condition: get_reviews,
            fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
            builder: (context) => SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              header: const WaterDropHeader(),
              child: ListView.separated(
                controller: scrollcontroller,
                itemBuilder: (context, index) {
                  if (index < list.length) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(radius: 13.r, backgroundColor: Colors.grey, child: const Icon(Icons.person, color: Colors.white,),),
                                SizedBox(width: 10.w,),
                                Text(list[index]["customerId"]["name"].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  list[index]["rate"].toString(),
                                  style: TextStyle(
                                      color: depOrange,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp
                                  ),
                                ),
                                Icon(Icons.star, color: depOrange, size: 20.sp,),
                              ],
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(list[index]["comment"].toString()),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: depOrange),
                    );
                  }
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(height: 1.h, width: double.infinity, color: Colors.grey.shade300,),
                ),
                itemCount: isLoadingMore ? list.length + 1 : list.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    if (scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent) {
      if (page < totalPages) {
        setState(() {
          isLoadingMore = true;
        });
        page = page + 1;
        AppCubit.get(context).GetBrandReviews(token: access_token, id: brand_id, page: page, size: 10);
      }
    }
  }


}
