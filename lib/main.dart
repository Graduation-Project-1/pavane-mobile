import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Helper/Cache_helper.dart';
import 'bloc/bloc_observer.dart';
import 'bloc/cubit.dart';
import 'bloc/state.dart';
import 'dio/dio_helper.dart';
import 'view/authentication/login_or_register_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer <AppCubit, AppStates>(
        listener: (BuildContext context, state){},
        builder: (BuildContext context, state){
          return ScreenUtilInit(
            designSize: const Size(414, 736),
            builder: (context, child) => MaterialApp(
              title: 'PAVANE',
              debugShowCheckedModeBanner: false,
              home:  LoginOrRegisterScreen(),
            ),
          );
        },
      ),
    );
  }
}
