import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterwithfirebase/business_logic/cubit/shop_cubit.dart';
import 'package:flutterwithfirebase/business_logic/helpers/helper.dart';
import 'package:flutterwithfirebase/peresentation/helper_widgets.dart';
import 'package:flutterwithfirebase/peresentation/screens/home_register_screen.dart';

import 'all_products_screen.dart';

class HomeLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopState>(

        listener: (context, state) {
          if (state is ShopGetCategoryModelSuccessState) {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) =>
                BlocProvider<ShopCubit>(
                  create: (context) => ShopCubit(),
                  child: AllProductsScreen(),
                )), (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'sign in'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Sign in to buy what you want',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    defaultFormField(
                        controller: emailController,
                        lable: 'email',
                        prefixicon: Icons.email,
                        type: TextInputType.emailAddress,
                        onValidate: (value) {
                          if (value!.isEmpty)
                            return 'Email must not be empty';
                          else
                            return null;
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                        controller: passwordController,
                        lable: 'password',
                        prefixicon: Icons.lock_outline,
                        suffixFun: () {
                          cubit.changePasswordVisibility();
                        },
                        suffixIcon: cubit.isPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        type: cubit.isPassword
                            ? TextInputType.visiblePassword
                            : TextInputType.text,
                        onValidate: (value) {
                          if (value!.isEmpty)
                            return 'Password must not be empty';
                          else
                            return null;
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: (state != ShopGetUserModelLoadingState),
                      builder: (context) =>
                          defaultMaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.getUserData({
                                  'email': emailController.text,
                                  'password': passwordController.text
                                });
                                cubit.getHomeData();
                                cubit.getCategoryData();
                              }
                            },
                            text: 'login',
                          ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator(),),),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('don\'t have an account'),
                        SizedBox(width: 7,),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeRegisterScreen()));
                        }, child: Text(
                          'register now',
                          style: TextStyle(
                              color: Colors.blue
                          ),
                        ))
                      ],
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
