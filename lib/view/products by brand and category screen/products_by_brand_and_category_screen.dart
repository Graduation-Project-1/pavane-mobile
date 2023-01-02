import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/constants/product_card.dart';
import '../../Helper/Cache_helper.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../constants/colors.dart';

class ProductsByBrandAndCategoryScreen extends StatefulWidget {

  var cat_id;
  var title;
  var brand_id;
  ProductsByBrandAndCategoryScreen(this.cat_id, this.title, this.brand_id);

  @override
  State<ProductsByBrandAndCategoryScreen> createState() => _ProductsByBrandAndCategoryScreenState(cat_id, title, brand_id);
}

class _ProductsByBrandAndCategoryScreenState extends State<ProductsByBrandAndCategoryScreen> {

  var cat_id;
  var title;
  var brand_id;
  _ProductsByBrandAndCategoryScreenState(this.cat_id, this.title, this.brand_id);

  int page = 1;
  int totalPages = 0;
  final scrollcontroller = ScrollController();
  List<Map<String, dynamic>> list = [];
  bool isLoadingMore = false;
  bool get = false;
  var access_token = CacheHelper.getData(key: 'access_token');

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).GetProductsByBrandAndCat(page: page.toString(), token: access_token, cat_id: cat_id, brand_id: brand_id);
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
              title,
              style: TextStyle(
                  color: depOrange,
                  fontSize: 35.sp,
                  fontFamily: "Roller"
              ),
            ),
          ),
          body: GridView.builder(
              controller: scrollcontroller,
              itemCount: isLoadingMore ? list.length + 1 : list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .75),
              itemBuilder: (context, index) {
                if(index < list.length){
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
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
              }
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
        AppCubit.get(context).GetProductsByCat(page: page.toString(), token: access_token, cat_id: cat_id);
      }
    }
  }

}
