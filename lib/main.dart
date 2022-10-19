import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwithfirebase/business_logic/cubit/shop_cubit.dart';
import 'package:flutterwithfirebase/business_logic/helpers/helper.dart';
import 'package:flutterwithfirebase/data/web_services/web_services.dart';
import 'package:flutterwithfirebase/peresentation/screens/all_products_screen.dart';
import 'package:flutterwithfirebase/peresentation/screens/home_login_screen.dart';
import 'package:flutterwithfirebase/peresentation/screens/onboarding_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Helper.init();
  Webservices.init();

  bool? onBoarding=Helper.sharedPreferences.getBool('onBoarding');
  token=Helper.sharedPreferences.getString('token');
  Widget startWidget;
  if(onBoarding==true){
    if(token!=null)
      startWidget=AllProductsScreen();
    else
      startWidget=HomeLoginScreen();
  }
  else{
    startWidget=OnBoardingScreen();
  }
  runApp(MyApp(startWidget:startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key,required this.startWidget}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   token= Helper.sharedPreferences.get('token').toString();

   // ShopCubit.get(context).getHomeData(token)

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<ShopCubit>(
        create: (context) => ShopCubit(),
        child: startWidget,
      ),
    );
  }
}

