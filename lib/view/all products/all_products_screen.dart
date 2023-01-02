import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';
import '../../constants/product_card.dart';

class AllProductsScreen extends StatefulWidget {

  var brand_id;
  AllProductsScreen(this.brand_id);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState(brand_id);
}

class _AllProductsScreenState extends State<AllProductsScreen> {

  var brand_id;
  _AllProductsScreenState(this.brand_id);

  bool get_all_products = false;
  var access_token = CacheHelper.getData(key: 'access_token');

  int page = 1;
  int totalPages = 0;
  final scrollcontroller = ScrollController();
  List<Map<String, dynamic>> list = [];
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).GetProductsByBrand(token: access_token, page: page.toString(), brand_id: brand_id);
    scrollcontroller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){
        if(state is GetAllProductsSuccessState){
          for (final e in state.allProductsModel.data!){
            list.add(e.toJson());
          }
          isLoadingMore = false;
          totalPages = (state.allProductsModel.totalResult!/10).ceil();
          get_all_products = true;
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
              'All Items',
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
              condition: get_all_products,
              fallback: (context) => Center(child: Image.asset("assets/images/loader.gif", scale: .7,)),
              builder: (context) => GridView.builder(
                controller: scrollcontroller,
                itemCount: isLoadingMore ? list.length + 1 : list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .75),
                itemBuilder: (BuildContext context, int index) {
                  if(index < list.length){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardBuilder(
                          context: context,
                          image: list[index]['images'][0].toString(),
                          name: list[index]['name'].toString(),
                          price: list[index]['price'].toString(),
                          rate: list[index]['averageRate'].toString(),
                          id: list[index]['_id'].toString(),
                          brand: list[index]['brandId']['name'].toString(),
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
        AppCubit.get(context).GetProductsByBrand(token: access_token, page: page.toString(), brand_id: brand_id);
      }
    }
  }

}
